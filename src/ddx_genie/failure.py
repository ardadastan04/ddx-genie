"""Attribute each wrong diagnosis to a cause.

A wrong top-1 can come from three different places, and lumping them together hides
the study's actual finding:

``missed_evidence``
    The agent never elicited findings that discriminate the true condition. A real
    interview weakness, and the thing a worksheet is supposed to prevent.
``wrong_evidence``
    The agent recorded findings the patient does not have. A precision problem; the
    diagnosis was reasoning over partly fictional input.
``diagnosis_step``
    The agent collected enough, and still ranked wrongly. The interview is not at
    fault; the diagnosis call (or the closed condition set) is.

The third case is made *decidable* rather than inferred: the same diagnosis prompt is
re-run on the patient's complete true evidence, mapped through the same field list the
agent had. If that oracle also gets it wrong, no amount of interviewing would have
fixed this patient, so the failure cannot be attributed to elicitation. Running it
costs one cached LLM call per wrong diagnosis.
"""

from __future__ import annotations

import json
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any

from ddx_genie.diagnosis import diagnose_findings
from ddx_genie.llm import LLMClient
from ddx_genie.score import FieldMap, positive_fields
from ddx_genie.subset import load_json

#: A patient is judged to have been under-interviewed when this share or more of the
#: findings that specifically characterise their true condition were never recorded.
MISSED_KEY_THRESHOLD = 0.5

CAUSE_LABELS = {
    "missed_evidence": "Missed key symptoms",
    "wrong_evidence": "Recorded wrong evidence",
    "diagnosis_step": "Good evidence, wrong diagnosis",
}


@dataclass
class FailureCase:
    system: str
    row_index: int
    true_pathology: str
    predicted: str | None
    cause: str
    #: Findings that characterise the true condition and were never recorded.
    missed_key: list[str]
    #: Of the condition's characterising findings the patient actually had, how many
    #: the agent captured.
    key_captured: int
    key_total: int
    #: Recorded but not true for this patient.
    false_positives: list[str]
    recall: float | None
    precision: float | None
    turns: int
    #: Top-1 when the same prompt is given the patient's complete true evidence.
    oracle_top1: str | None
    oracle_correct: bool

    def as_json(self) -> dict[str, Any]:
        return asdict(self)


def condition_fields(pathology: str, field_map: FieldMap) -> set[str]:
    """Field names that characterise a condition, per release_conditions.json.

    DDXPlus lists each condition's ``symptoms`` and ``antecedents`` as evidence codes.
    Those are the questions a clinician would need answered to reach it, so they are
    the right denominator for "did the agent ask the things that mattered here".
    """
    conditions = load_json("release_conditions.json")
    definition = conditions.get(pathology, {})
    codes = set(definition.get("symptoms", {})) | set(definition.get("antecedents", {}))
    code_to_fields: dict[str, set[str]] = {}
    for name, code in field_map.field_to_code.items():
        code_to_fields.setdefault(code, set()).add(name)
    out: set[str] = set()
    for code in codes:
        out |= code_to_fields.get(code, set())
    return out


def classify(
    *,
    missed_key_share: float,
    false_positives: int,
    oracle_correct: bool,
) -> str:
    """Decide which of the three causes this failure belongs to.

    Order matters. The oracle is checked first because it is the only evidence-based
    test: if perfect elicitation still fails, calling it an interview problem would be
    wrong regardless of what the agent missed.
    """
    if not oracle_correct:
        return "diagnosis_step"
    if missed_key_share >= MISSED_KEY_THRESHOLD:
        return "missed_evidence"
    if false_positives > 0:
        return "wrong_evidence"
    return "diagnosis_step"


def analyse_run(
    run_dir: Path, field_map: FieldMap, client: LLMClient
) -> list[FailureCase]:
    """Every wrong top-1 in the run, with its cause."""
    cases: list[FailureCase] = []
    for path in sorted(run_dir.glob("*_*.json")):
        if path.name == "summary.json":
            continue
        result = json.loads(path.read_text())
        ranked = [entry["condition"] for entry in (result.get("differential") or [])]
        predicted = ranked[0] if ranked else None
        pathology = result["pathology"]
        if predicted == pathology:
            continue

        truth = field_map.truth_fields(result.get("true_evidences") or [])
        captured = positive_fields(result.get("findings") or {})
        key = condition_fields(pathology, field_map) & truth
        missed_key = sorted(key - captured)
        false_positives = sorted(captured - truth)

        # The oracle: the same prompt, given everything that was true.
        oracle = diagnose_findings(
            {name: True for name in sorted(truth)}, client=client, tag="oracle"
        )

        share = len(missed_key) / len(key) if key else 0.0
        cases.append(
            FailureCase(
                system=result["system"],
                row_index=result["row_index"],
                true_pathology=pathology,
                predicted=predicted,
                cause=classify(
                    missed_key_share=share,
                    false_positives=len(false_positives),
                    oracle_correct=oracle.top1 == pathology,
                ),
                missed_key=missed_key,
                key_captured=len(key) - len(missed_key),
                key_total=len(key),
                false_positives=false_positives,
                recall=(len(captured & truth) / len(truth)) if truth else None,
                precision=(len(captured & truth) / len(captured)) if captured else None,
                turns=result.get("turns", 0),
                oracle_top1=oracle.top1,
                oracle_correct=oracle.top1 == pathology,
            )
        )
    return cases


def failure_table(cases: list[FailureCase]) -> str:
    """The per-failure table and the cause tally, as markdown."""
    if not cases:
        return (
            "## Why each diagnosis was wrong\n\nNo incorrect top-1 diagnoses in "
            "this run.\n"
        )

    lines = [
        "## Why each diagnosis was wrong",
        "",
        "`oracle` re-runs the identical diagnosis prompt on the patient's complete "
        "true evidence. When the oracle is also wrong, the interview cannot be "
        "blamed: perfect elicitation would not have helped.",
        "",
        "| System | Row | True condition | Predicted | Key findings captured | "
        "False positives | Recall | Oracle top-1 | Cause |",
        "|---|---|---|---|---|---|---|---|---|",
    ]
    for case in sorted(cases, key=lambda c: (c.system, c.row_index)):
        recall = "—" if case.recall is None else f"{case.recall:.2f}"
        oracle = f"{case.oracle_top1 or '—'}{' ✓' if case.oracle_correct else ''}"
        lines.append(
            f"| {case.system} | {case.row_index} | {case.true_pathology} "
            f"| {case.predicted or '—'} | {case.key_captured}/{case.key_total} "
            f"| {len(case.false_positives)} | {recall} | {oracle} "
            f"| **{CAUSE_LABELS[case.cause]}** |"
        )

    lines += ["", "### Cause breakdown", ""]
    systems = sorted({c.system for c in cases})
    lines.append(f"| Cause | {' | '.join(systems)} |")
    lines.append(f"|---|{'---|' * len(systems)}")
    for cause, label in CAUSE_LABELS.items():
        counts = [
            str(sum(1 for c in cases if c.system == s and c.cause == cause))
            for s in systems
        ]
        lines.append(f"| {label} | {' | '.join(counts)} |")
    lines.append(
        f"| **Total wrong** | "
        f"{' | '.join(str(sum(1 for c in cases if c.system == s)) for s in systems)} |"
    )

    lines += ["", "### Most-missed key findings on failed cases", ""]
    from collections import Counter

    for system in systems:
        tally = Counter(
            name for case in cases if case.system == system for name in case.missed_key
        )
        if not tally:
            continue
        top = ", ".join(f"`{n}` ({c})" for n, c in tally.most_common(8))
        lines.append(f"- **{system}**: {top}")
    lines.append("")
    return "\n".join(lines)


# ------------------------------------------------------------------- oracle ceiling


def oracle_ceiling(client: LLMClient, *, limit: int | None = None) -> dict[str, Any]:
    """Top-1/top-3 accuracy when the diagnosis step is given perfect evidence.

    This is a property of the condition set and the diagnosis prompt, not of either
    agent, and it bounds what any interview can achieve. If the ceiling is well below
    1.0, a top-1 gap between systems is partly noise on top of that limit, and
    evidence recall is the metric that actually discriminates them.
    """
    import json as _json

    from ddx_genie.score import FieldMap
    from ddx_genie.subset import PROCESSED_DIR

    field_map = FieldMap.load()
    records = [
        _json.loads(line)
        for line in (PROCESSED_DIR / "subset.jsonl").read_text().splitlines()
        if line
    ][: limit or None]

    per_condition: dict[str, list[bool]] = {}
    confusions: dict[str, dict[str, int]] = {}
    top1 = top3 = 0
    for record in records:
        truth = field_map.truth_fields(record["evidences"])
        result = diagnose_findings(
            {name: True for name in sorted(truth)}, client=client, tag="oracle_ceiling"
        )
        pathology = record["pathology"]
        correct = result.top1 == pathology
        top1 += int(correct)
        top3 += int(pathology in result.top3)
        per_condition.setdefault(pathology, []).append(correct)
        if not correct and result.top1:
            confusions.setdefault(pathology, {}).setdefault(result.top1, 0)
            confusions[pathology][result.top1] += 1

    return {
        "n": len(records),
        "top1_accuracy": top1 / len(records) if records else None,
        "top3_accuracy": top3 / len(records) if records else None,
        "per_condition": {
            condition: {"n": len(flags), "top1": sum(flags) / len(flags)}
            for condition, flags in sorted(per_condition.items())
        },
        "confusions": confusions,
    }
