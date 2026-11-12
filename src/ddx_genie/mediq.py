"""Build a fixed diagnosis-only subset from MediQ (CC BY 4.0, github.com/stellalisy/mediQ).

MediQ re-packages MedQA vignettes as ordered lists of atomic ``facts``, which is what
the partial-information eval needs: a case can be revealed as a prefix, or with facts
held back, and the agent has to recover what is missing.

Only questions that ask for *the diagnosis* are kept. Most MedQA items ask about
treatment, mechanism, the next diagnostic test, or something "associated with" the
diagnosis; those are not differential-diagnosis tasks and are excluded.

Writes ``data/processed/mediq/subset.jsonl``, reproducible from ``SEED``. No LLM calls.

Run: ``uv run python -m ddx_genie.mediq``
"""

from __future__ import annotations

import json
import random
import re
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any

REPO_ROOT = Path(__file__).resolve().parents[2]
MEDIQ_DIR = REPO_ROOT / "data" / "raw" / "mediq" / "repo" / "data"
SOURCE_FILE = "all_dev_good.jsonl"  # MedQA-derived; all_craft_md.jsonl is dermatology only
OUT_PATH = REPO_ROOT / "data" / "processed" / "mediq" / "subset.jsonl"

SEED = 0
N_CASES = 50

#: The stem must ask for the diagnosis itself...
_ASKS_DIAGNOSIS = re.compile(
    r"most (likely|probable)\b.{0,40}\bdiagnosis"
    r"|diagnosis\b.{0,20}\bmost likely"
    r"|what is the diagnosis",
    re.IGNORECASE,
)
#: ...and not something adjacent to it ("next step in diagnosis", "associated with
#: the most likely diagnosis", "risk factor for", "test to confirm the diagnosis").
_ADJACENT_TASK = re.compile(
    r"\b(tests?|step|confirm|criteria|characteristic|sequelae|helpful|work-?up"
    r"|sensitive|treatment|management|associated|risk factor|etiology|cause|yield)\b",
    re.IGNORECASE,
)
#: Stems longer than this, or containing table rows ("|"), carry case data that is
#: absent from ``facts`` and would leak past the reveal schedule.
MAX_STEM_CHARS = 150

_FACT_NUMBER = re.compile(r"^\s*\d+\.\s*")


class DataError(ValueError):
    """A MediQ record does not have the shape this module relies on."""


@dataclass(frozen=True)
class MediQCase:
    case_id: str
    source_file: str
    source_id: int
    question: str
    options: dict[str, str]
    answer_idx: str
    answer: str
    facts: list[str]
    context: list[str]
    #: Leading facts that make up MediQ's "initial information" (``context[0]``):
    #: demographics plus presenting complaint. Always revealed; see ``reveal.py``.
    n_initial: int
    age: str | None
    sex: str | None
    specialty: str | None


def is_diagnosis_question(stem: str) -> bool:
    """True if the stem asks for the most likely diagnosis and nothing adjacent."""
    if "|" in stem or len(stem) > MAX_STEM_CHARS:
        return False
    return bool(_ASKS_DIAGNOSIS.search(stem)) and not _ADJACENT_TASK.search(stem)


def clean_fact(fact: str) -> str:
    """Strip MediQ's leading "12. " numbering; order is kept by list position."""
    return _FACT_NUMBER.sub("", fact).strip()


_TOKEN = re.compile(r"[a-z0-9]+")
_STOPWORDS = frozenset(
    "the a an is of and to with his her he she has had patient for in by was are".split()
)
#: A fact belongs to the initial sentence if this share of its content words occur in it.
INITIAL_OVERLAP = 0.7


def _content_tokens(text: str) -> set[str]:
    return set(_TOKEN.findall(text.lower())) - _STOPWORDS


def initial_fact_count(facts: list[str], initial_sentence: str) -> int:
    """How many leading facts restate MediQ's initial information (``context[0]``).

    MediQ gives the expert only ``context[0]`` up front. Facts are a lightly
    paraphrased split of the context, so leading facts whose content words mostly
    occur in ``context[0]`` are taken to be that initial information. Stops at the
    first mismatch, so a miss reveals less, never more. Always at least 1.
    """
    initial = _content_tokens(initial_sentence)
    count = 0
    for fact in facts:
        words = _content_tokens(fact)
        if not words or len(words & initial) / len(words) < INITIAL_OVERLAP:
            break
        count += 1
    return max(count, 1)


def answer_leaks(facts: list[str], answer: str) -> bool:
    """True if the gold answer text appears verbatim in a fact."""
    needle = answer.lower().strip()
    return any(needle in fact.lower() for fact in facts)


def parse_record(raw: dict[str, Any], source_file: str) -> MediQCase:
    try:
        options = {str(k): str(v) for k, v in raw["options"].items()}
        answer_idx = str(raw["answer_idx"])
        facts = [clean_fact(f) for f in raw["facts"]]
        patient = raw.get("patient") or {}
        facts = [f for f in facts if f]
        context = [str(s) for s in raw["context"]]
        case = MediQCase(
            case_id=f"mediq-{Path(source_file).stem}-{raw['id']}",
            source_file=source_file,
            source_id=int(raw["id"]),
            question=str(raw["question"]).strip(),
            options=options,
            answer_idx=answer_idx,
            answer=str(raw["answer"]),
            facts=facts,
            context=context,
            n_initial=initial_fact_count(facts, context[0] if context else ""),
            age=patient.get("age"),
            sex=patient.get("gender"),
            specialty=patient.get("gpt_specialty"),
        )
    except (KeyError, TypeError, AttributeError) as exc:
        raise DataError(f"malformed MediQ record id={raw.get('id')!r}: {exc}") from exc
    if options.get(answer_idx) != case.answer:
        raise DataError(f"id={case.source_id}: answer_idx does not match answer text")
    if not case.facts:
        raise DataError(f"id={case.source_id}: no facts")
    return case


def load_cases(path: Path) -> tuple[list[MediQCase], list[int]]:
    """Parse every record. Returns (cases, ids skipped for having no facts).

    3 of 1272 records in all_dev_good.jsonl (ids 224, 298, 779) have empty ``facts``
    and ``context``; they are skipped. Any other malformation still raises.
    """
    cases: list[MediQCase] = []
    skipped: list[int] = []
    for line in path.read_text().splitlines():
        if not line.strip():
            continue
        raw = json.loads(line)
        if not raw.get("facts"):
            skipped.append(int(raw["id"]))
            continue
        cases.append(parse_record(raw, path.name))
    return cases, skipped


def select_diagnosis_cases(cases: list[MediQCase]) -> list[MediQCase]:
    return [
        c for c in cases
        if is_diagnosis_question(c.question) and not answer_leaks(c.facts, c.answer)
    ]


def sample(cases: list[MediQCase], n: int = N_CASES, seed: int = SEED) -> list[MediQCase]:
    """Deterministic sample, returned in source order."""
    ordered = sorted(cases, key=lambda c: c.source_id)
    if len(ordered) < n:
        raise DataError(f"only {len(ordered)} eligible cases, wanted {n}")
    picked = random.Random(seed).sample(ordered, n)
    return sorted(picked, key=lambda c: c.source_id)


def write_subset(cases: list[MediQCase], path: Path = OUT_PATH) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("".join(json.dumps(asdict(c)) + "\n" for c in cases))


def main() -> int:
    all_cases, skipped = load_cases(MEDIQ_DIR / SOURCE_FILE)
    eligible = select_diagnosis_cases(all_cases)
    picked = sample(eligible)
    write_subset(picked)
    n_facts = sorted(len(c.facts) for c in picked)
    print(f"skipped {len(skipped)} records with no facts: {skipped}")
    print(f"{len(all_cases)} records -> {len(eligible)} diagnosis questions "
          f"-> {len(picked)} sampled (seed {SEED})")
    print(f"facts per case: min {n_facts[0]}, median {n_facts[len(n_facts) // 2]}, "
          f"max {n_facts[-1]}")
    print(f"wrote {OUT_PATH.relative_to(REPO_ROOT)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
