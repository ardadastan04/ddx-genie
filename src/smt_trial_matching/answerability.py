"""Predict, from a variable's name alone, how likely the patient can answer it.

The answer key is ~57% unknown, and an unknown answer never changes a trial's status, so a policy
that asks only "informative" questions still wastes about half of them (greedy_smt: 54% on dev).
This model gives two probabilities per (variable, type):

- ``p_answered``: the simulator returns a value rather than unknown;
- ``p_true``: a Bool answer is true, given that it is answered.

Features are generic name parts only (kind, timeframe, qualifier, type, name words), never the
variable's identity or the patient, so the model cannot memorise a particular patient's answers.
It is fit on the **dev** split's answer key only; test patients never touch it.

Cross-fitting on dev: a model fit on all of dev would partly memorise each dev patient's own answers
(name words act like variable ids: in-sample AUC 0.95 vs 0.75 held out). So ``model_for(trials)``
returns, for a dev patient, a model fit on the *other* folds of dev patients (5 folds by patient), and
for anyone else (test) the model fit on all of dev. Each patient's candidate-trial set is unique, so
the policy can find the patient from the trials it is given without seeing the answer key.
"""

from __future__ import annotations

import json
import re
from collections import Counter
from collections.abc import Iterable
from dataclasses import dataclass
from functools import cache
from pathlib import Path

import numpy as np
from sklearn.feature_extraction import DictVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_auc_score

ROOT = Path(__file__).resolve().parents[2]
DATA = ROOT / "data"
SEED = 0
C_DEFAULT = 0.3  # best patient-held-out AUC on dev among 0.1, 0.3, 1, 3
FOLDS = 5
MIN_VALUE_PATIENTS = 5  # a numeric name needs answers from this many patients to get a value distribution

_KINDS = (
    ("value", "value_recorded"),
    ("diagnosis", "has_diagnosis_of"),
    ("finding", "has_finding_of"),
    ("procedure", "has_undergone"),
    ("procedure", "is_undergoing"),
    ("medication", "is_taking"),
    ("medication", "is_exposed_to"),
    ("need", "needs_"),
    ("ability", "can_"),
    ("ability", "is_able"),
    ("criterion", "meets_"),
    ("state", "is_"),
    ("has", "has_"),
)
_TIMEFRAME = re.compile(r"_(now|inthehistory|inthepast\w*|prior_to\w*|within\w*|during\w*)$")
_STOP = frozenset({'patient', 'has', 'is', 'of', 'the', 'a', 'an', 'and', 'or', 'to', 'in', 'at', 'by', 'on', 'for', 'with', 'now', 'value', 'recorded'})


def _words(text: str) -> list[str]:
    return [w for w in re.split(r"[^a-z0-9]+", text.lower()) if len(w) > 2 and w not in _STOP]


def parse(name: str) -> dict[str, str | bool]:
    """Split a canonical variable name into kind, timeframe and qualifier."""
    stem, _, qualifier = name.partition("@@")
    kind = next((k for k, marker in _KINDS if marker in stem), "other")
    tf = _TIMEFRAME.search(stem)
    timeframe = tf.group(1) if tf else "none"
    if timeframe.startswith("inthepast"):
        timeframe = "inthepast"
    elif timeframe.startswith(("prior_to", "within", "during")):
        timeframe = timeframe.split("_")[0]
    return {"stem": stem, "kind": kind, "timeframe": timeframe, "qualifier": qualifier}


def features(name: str, vtype: str) -> dict[str, float]:
    """Sparse feature dict for one variable (one-hot parts + bag of name words)."""
    p = parse(name)
    f: dict[str, float] = {
        f"kind={p['kind']}": 1.0,
        f"tf={p['timeframe']}": 1.0,
        f"type={vtype}": 1.0,
        f"kind_tf={p['kind']}|{p['timeframe']}": 1.0,
        "has_qualifier": float(bool(p["qualifier"])),
    }
    for w in _words(str(p["stem"])):
        f[f"w={w}"] = 1.0
    for w in _words(str(p["qualifier"])):
        f[f"q={w}"] = 1.0
    return f


@dataclass(frozen=True)
class Example:
    qid: str
    nct: str
    name: str
    vtype: str
    value: object  # None = unknown


@cache
def _types(nct: str) -> dict[str, str]:
    path = DATA / "variables" / f"{nct}.json"
    return {v["name"]: v["type"] for v in json.loads(path.read_text())} if path.exists() else {}


def _vtype(nct: str, name: str) -> str:
    return _types(nct).get(name) or ("Real" if "value_recorded" in name else "Bool")


def load_examples(qids: Iterable[str], key: str = "gpt5_oracle") -> list[Example]:
    """Every (variable, value) in the answer key for the given patients."""
    keep = set(qids)
    out = []
    for row in map(json.loads, (DATA / "answer_keys" / f"{key}.jsonl").open()):
        qid, nct = row["pair"].split("__")
        if qid in keep:
            out += [Example(qid, nct, n, _vtype(nct, n), v) for n, v in sorted(row["assign"].items())]
    return out


def load_split(split: str) -> list[str]:
    return json.loads((DATA / "splits.json").read_text())[split]


class AnswerabilityModel:
    """Two logistic regressions over name features: answered vs unknown, and true vs false."""

    def __init__(self, c: float = C_DEFAULT) -> None:
        self.c = c
        self._vec = DictVectorizer()
        self._answered = LogisticRegression(C=c, max_iter=2000, random_state=SEED)
        self._true = LogisticRegression(C=c, max_iter=2000, random_state=SEED)
        self._cache: dict[tuple[str, str], tuple[float, float]] = {}
        self._values: dict[str, list[tuple[float, float]]] = {}

    def fit(self, examples: list[Example]) -> AnswerabilityModel:
        X = self._vec.fit_transform([features(e.name, e.vtype) for e in examples])
        y = np.array([e.value is not None for e in examples])
        self._answered.fit(X, y)
        bools = [i for i, e in enumerate(examples) if isinstance(e.value, bool)]
        self._true.fit(X[bools], np.array([examples[i].value for i in bools]))
        self._cache.clear()
        self._values = _value_distributions(examples)
        return self

    def predict(self, name: str, vtype: str) -> tuple[float, float]:
        """(p_answered, p_true_given_answered) for one variable."""
        k = (name, vtype)
        if k not in self._cache:
            x = self._vec.transform([features(name, vtype)])
            self._cache[k] = (float(self._answered.predict_proba(x)[0, 1]),
                              float(self._true.predict_proba(x)[0, 1]))
        return self._cache[k]

    def p_answered(self, name: str, vtype: str) -> float:
        return self.predict(name, vtype)[0]

    def p_true(self, name: str, vtype: str) -> float:
        return self.predict(name, vtype)[1]

    def value_distribution(self, name: str) -> list[tuple[float, float]] | None:
        """Observed values of a numeric variable in the training patients, as (value, probability),
        or None when fewer than MIN_VALUE_PATIENTS answered it (in practice only age qualifies)."""
        return self._values.get(name)


def _value_distributions(examples: list[Example]) -> dict[str, list[tuple[float, float]]]:
    """Empirical distribution of each numeric name over the training patients, one value per patient
    (the first answer, so a patient asked in several trials counts once). Exact name match only:
    names carry units, so pooling e.g. two BMI spellings would need unit handling first."""
    per_patient: dict[str, dict[str, float]] = {}
    for e in examples:
        if e.vtype != "Bool" and isinstance(e.value, (int, float)) and not isinstance(e.value, bool):
            per_patient.setdefault(e.name, {}).setdefault(e.qid, float(e.value))
    out = {}
    for name, by_qid in per_patient.items():
        if len(by_qid) >= MIN_VALUE_PATIENTS:
            counts = Counter(by_qid.values())
            out[name] = [(v, c / len(by_qid)) for v, c in sorted(counts.items())]
    return out


@cache
def fit_default(key: str = "gpt5_oracle") -> AnswerabilityModel:
    """The model policies use: fit on the dev split's answer key only."""
    return AnswerabilityModel().fit(load_examples(load_split("dev"), key))


@cache
def _patient_trials() -> dict[frozenset[str], str]:
    by: dict[str, set[str]] = {}
    for p in map(json.loads, (DATA / "pairs.jsonl").open()):
        by.setdefault(p["qid"], set()).add(p["nct"])
    return {frozenset(v): q for q, v in by.items()}


def dev_fold(qid: str) -> int | None:
    """Fold index of a dev patient (round robin over sorted ids), or None if not in dev."""
    dev = sorted(load_split("dev"))
    return dev.index(qid) % FOLDS if qid in dev else None


@cache
def _fold_model(fold: int, key: str = "gpt5_oracle") -> AnswerabilityModel:
    train = [q for q in load_split("dev") if dev_fold(q) != fold]
    return AnswerabilityModel().fit(load_examples(train, key))


def model_for(trials: Iterable[str], key: str = "gpt5_oracle") -> AnswerabilityModel:
    """The model to use for the patient whose candidate trials are ``trials`` (see module doc)."""
    qid = _patient_trials().get(frozenset(trials))
    fold = dev_fold(qid) if qid else None
    return fit_default(key) if fold is None else _fold_model(fold, key)


def crossfit_auc(qids: list[str], folds: int = FOLDS, key: str = "gpt5_oracle") -> dict[str, float]:
    """Patient-level k-fold AUC of p_answered, versus the in-sample AUC (a leakage check)."""
    order = sorted(qids)
    held: list[tuple[float, bool]] = []
    for f in range(folds):
        test = set(order[f::folds])  # same round-robin folds as dev_fold
        model = AnswerabilityModel().fit(load_examples([q for q in order if q not in test], key))
        held += [(model.p_answered(e.name, e.vtype), e.value is not None)
                 for e in load_examples(test, key)]
    full = AnswerabilityModel().fit(load_examples(order, key))
    insample = [(full.p_answered(e.name, e.vtype), e.value is not None)
                for e in load_examples(order, key)]

    def auc(rows: list[tuple[float, bool]]) -> float:
        return float(roc_auc_score([y for _, y in rows], [p for p, _ in rows]))

    return {"crossfit_auc": auc(held), "insample_auc": auc(insample),
            "answered_rate": float(np.mean([y for _, y in insample]))}


if __name__ == "__main__":
    print(json.dumps(crossfit_auc(load_split("dev")), indent=1))
