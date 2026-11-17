"""Accuracy-vs-budget metrics, patient-level bootstrap CIs and paired tests over episode logs.

Budget rule (identical to ``eval/evaluate.py``): the verdicts after k questions are the initial
verdicts when k = 0 or the episode has no turns, else those of turn min(k, n_turns). A patient who
stopped early keeps their final verdicts. "final" uses ``final_verdicts``.

All CIs resample PATIENTS (pairs within a patient are not independent): 2,000 resamples, seed 0.
"""

from __future__ import annotations

import json
import math
import warnings
from dataclasses import dataclass
from pathlib import Path

import numpy as np

from .policy_loading import ROOT

N_BOOT = 2000
SEED = 0
TEST_KS = (5, 10, 20, 30)
FINAL = "final"

#: Per-patient additive counts, one column per k (plus "final" as the last column).
COUNTS = ("pairs", "correct", "tp", "fp", "fn", "asked", "informative", "answered", "set_f1",
          "useful_answered", "useful_unanswered", "not_useful")
#: Question labels (waste breakdown), in stacking order.
LABELS = ("useful_answered", "useful_unanswered", "not_useful")
#: Reported metrics, each computed from the counts of a set of patients.
METRICS = ("accuracy", "f1", "informative_rate", "answered_rate", "set_f1",
           "questions_per_patient", "answered_per_patient",
           *(f"share_{lab}" for lab in LABELS))
AUC = "auc"


def load_gold() -> dict[tuple[str, str], bool]:
    rows = map(json.loads, (ROOT / "data" / "pairs.jsonl").open())
    return {(p["qid"], p["nct"]): p["gold"] == "eligible" for p in rows}


def load_split(split: str) -> list[str]:
    return list(json.load((ROOT / "data" / "splits.json").open())[split])


def load_log(path: Path) -> list[dict]:
    return [json.loads(line) for line in path.open() if line.strip()]


def label(turn: dict) -> str:
    """Waste label of one question: could it change a trial's status, and did it get an answer?"""
    if not turn.get("informative"):
        return "not_useful"
    return "useful_unanswered" if turn["answer"] is None else "useful_answered"


def verdicts_at(ep: dict, k: int | str) -> dict[str, str]:
    """Verdicts after k questions, by evaluate.py's rule; k = "final" gives final_verdicts."""
    if k == FINAL:
        return ep["final_verdicts"]
    turns = ep["turns"]
    return ep["initial_verdicts"] if k == 0 or not turns else turns[min(k, len(turns)) - 1]["verdicts"]


def _set_f1(pred: set[str], gold: set[str]) -> float:
    """evaluate.py's patient-level eligible-set F1 (empty sets handled the same way)."""
    tp = len(pred & gold)
    p = tp / len(pred) if pred else (1.0 if not gold else 0.0)
    r = tp / len(gold) if gold else 1.0
    return 2 * p * r / max(p + r, 1e-9)


@dataclass
class Table:
    """Counts for one policy: ``counts[name]`` has shape (patients, budget + 2); last column = final."""

    qids: list[str]
    ks: list[int | str]
    counts: dict[str, np.ndarray]
    #: Per (patient, k) list of pair correctness, in trial order; used by McNemar.
    pair_correct: list[list[list[bool]]]


def build_table(episodes: list[dict], gold: dict[tuple[str, str], bool], budget: int) -> Table:
    ks: list[int | str] = [*range(budget + 1), FINAL]
    counts = {c: np.zeros((len(episodes), len(ks))) for c in COUNTS}
    pair_correct: list[list[list[bool]]] = []
    for i, ep in enumerate(episodes):
        q, turns, row = ep["qid"], ep["turns"], []
        for j, k in enumerate(ks):
            v = verdicts_at(ep, k)
            pred = [v[n] == "eligible" for n in ep["trials"]]
            truth = [gold[(q, n)] for n in ep["trials"]]
            seen = turns if k == FINAL else turns[:k]
            c = counts
            c["pairs"][i, j] = len(pred)
            c["correct"][i, j] = sum(p == g for p, g in zip(pred, truth))
            c["tp"][i, j] = sum(p and g for p, g in zip(pred, truth))
            c["fp"][i, j] = sum(p and not g for p, g in zip(pred, truth))
            c["fn"][i, j] = sum(g and not p for p, g in zip(pred, truth))
            c["asked"][i, j] = len(seen)
            c["informative"][i, j] = sum(bool(t.get("informative")) for t in seen)
            c["answered"][i, j] = sum(t["answer"] is not None for t in seen)
            labels = [label(t) for t in seen]
            for lab in LABELS:
                c[lab][i, j] = labels.count(lab)
            c["set_f1"][i, j] = _set_f1({n for n, p in zip(ep["trials"], pred) if p},
                                        {n for n, g in zip(ep["trials"], truth) if g})
            row.append([p == g for p, g in zip(pred, truth)])
        pair_correct.append(row)
    return Table([e["qid"] for e in episodes], ks, counts, pair_correct)


def _metrics(s: dict[str, np.ndarray], n_patients: int | np.ndarray) -> dict[str, np.ndarray]:
    """Metrics from summed counts (works on any trailing shape, e.g. (k,) or (boot, k))."""
    with np.errstate(divide="ignore", invalid="ignore"):
        p = s["tp"] / np.maximum(s["tp"] + s["fp"], 1)
        r = s["tp"] / np.maximum(s["tp"] + s["fn"], 1)
        return {
            "accuracy": s["correct"] / np.maximum(s["pairs"], 1),
            "f1": 2 * p * r / np.maximum(p + r, 1e-9),
            "informative_rate": np.where(s["asked"] > 0, s["informative"] / s["asked"], np.nan),
            "answered_rate": np.where(s["asked"] > 0, s["answered"] / s["asked"], np.nan),
            "set_f1": s["set_f1"] / n_patients,
            "questions_per_patient": s["asked"] / n_patients,
            "answered_per_patient": s["answered"] / n_patients,
            **{f"share_{lab}": np.where(s["asked"] > 0, s[lab] / s["asked"], np.nan)
               for lab in LABELS},
        }


def point(table: Table) -> dict[str, np.ndarray]:
    return _metrics({c: a.sum(0) for c, a in table.counts.items()}, len(table.qids))


def boot_indices(n_patients: int, n_boot: int = N_BOOT, seed: int = SEED) -> np.ndarray:
    return np.random.default_rng(seed).integers(0, n_patients, size=(n_boot, n_patients))


def boot(table: Table, idx: np.ndarray) -> dict[str, np.ndarray]:
    """Metric arrays of shape (n_boot, k) over patient resamples ``idx``."""
    return _metrics({c: a[idx].sum(1) for c, a in table.counts.items()}, idx.shape[1])


def curves(table: Table, idx: np.ndarray) -> dict[str, list[tuple[float, float, float]]]:
    """metric -> per k (value, ci_low, ci_high), 95% percentile CI over patients."""
    pt, bt = point(table), boot(table, idx)
    out = {}
    for m in METRICS:
        with warnings.catch_warnings():  # rates are NaN at k=0 (no questions asked yet)
            warnings.simplefilter("ignore", RuntimeWarning)
            lo = np.nanpercentile(bt[m], 2.5, axis=0)
            hi = np.nanpercentile(bt[m], 97.5, axis=0)
        out[m] = list(zip(pt[m].tolist(), np.atleast_1d(lo).tolist(), np.atleast_1d(hi).tolist()))
    return out


def auc(accuracy: np.ndarray, budget: int) -> np.ndarray:
    """Area under accuracy vs k over k = 0..budget (trapezoid), divided by budget: 0-1 scale.

    ``accuracy`` has k on the last axis (columns 0..budget; a trailing "final" column is ignored).
    """
    acc = accuracy[..., : budget + 1]
    if budget == 0:
        return acc[..., 0]
    return np.trapezoid(acc, dx=1.0, axis=-1) / budget


def auc_ci(table: Table, idx: np.ndarray, budget: int) -> tuple[float, float, float]:
    """Accuracy AUC with a 95% patient-bootstrap CI."""
    b = auc(boot(table, idx)["accuracy"], budget)
    return (float(auc(point(table)["accuracy"], budget)),
            float(np.percentile(b, 2.5)), float(np.percentile(b, 97.5)))


# ------------------------------------------------------------------ paired tests


def mcnemar_exact(a: list[bool], b: list[bool]) -> dict[str, float]:
    """Exact two-sided McNemar on paired correctness: binomial test on the discordant pairs."""
    if len(a) != len(b):
        raise ValueError("paired lists differ in length")
    only_a = sum(x and not y for x, y in zip(a, b))
    only_b = sum(y and not x for x, y in zip(a, b))
    n = only_a + only_b
    tail = sum(math.comb(n, i) for i in range(min(only_a, only_b) + 1)) / 2**n if n else 1.0
    return {"only_a": only_a, "only_b": only_b, "p": min(1.0, 2 * tail)}


def _paired_boot(diff: np.ndarray, observed: float) -> dict[str, float]:
    """Percentile CI and two-sided p (share of resampled differences on the other side of 0)."""
    p = 2 * min(np.mean(diff <= 0), np.mean(diff >= 0))
    return {"diff": observed, "ci_low": float(np.percentile(diff, 2.5)),
            "ci_high": float(np.percentile(diff, 97.5)), "p": float(min(1.0, p))}


def _flat(table: Table, j: int) -> list[bool]:
    """Pair-level correctness at column j, all patients, in a fixed order."""
    return [c for patient in table.pair_correct for c in patient[j]]


def paired_tests(table: Table, ref: Table, idx: np.ndarray, budget: int) -> list[dict]:
    """McNemar + paired patient bootstrap (accuracy, set F1) vs ``ref`` at TEST_KS <= budget and final."""
    if table.qids != ref.qids:
        raise ValueError("policies were run on different patients")
    pa, pr = point(table), point(ref)
    ba, br = boot(table, idx), boot(ref, idx)
    rows = []
    for k in [*(k for k in TEST_KS if k <= budget), FINAL]:
        j = table.ks.index(k)
        mc = mcnemar_exact(_flat(table, j), _flat(ref, j))
        rows.append({"k": k, "test": "mcnemar_pairs", "stat": mc["only_a"] - mc["only_b"],
                     "p": mc["p"], "only_policy": mc["only_a"], "only_reference": mc["only_b"]})
        for m in ("accuracy", "set_f1"):
            r = _paired_boot(ba[m][:, j] - br[m][:, j], float(pa[m][j] - pr[m][j]))
            rows.append({"k": k, "test": f"bootstrap_{m}_diff", "stat": r["diff"], "p": r["p"],
                         "ci_low": r["ci_low"], "ci_high": r["ci_high"]})
    d = auc(ba["accuracy"], budget) - auc(br["accuracy"], budget)
    r = _paired_boot(d, float(auc(pa["accuracy"], budget) - auc(pr["accuracy"], budget)))
    rows.append({"k": AUC, "test": "bootstrap_auc_diff", "stat": r["diff"], "p": r["p"],
                 "ci_low": r["ci_low"], "ci_high": r["ci_high"]})
    return rows
