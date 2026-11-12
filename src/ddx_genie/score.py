"""Scoring: elicitation quality, diagnosis quality, and cost, per run.

    uv run python -m ddx_genie.score --run-id dev1

Two measurement decisions are made explicitly here, because getting either wrong
quietly produces numbers that look fine and mean nothing.

**The recall denominator excludes unrepresentable evidences.** The worksheet drops the
skin-lesion group and any multi-select with a single observed value, so neither system
has anywhere to record them. Counting them as missed would penalise both systems for
the spec's scope and depress recall by a constant. ``representable`` reports how many
were excluded so the choice stays visible.

**Differential overlap is computed against the ground truth filtered to the study's
six conditions.** DDXPlus differentials have a median of 12 entries, of which only
about 4 fall inside our condition set, while both agents are restricted to those six.
Comparing against the unfiltered list caps overlap well below 1.0 by construction.
"""

from __future__ import annotations

import argparse
import json
import statistics
from collections import defaultdict
from dataclasses import asdict, dataclass, field as dc_field
from pathlib import Path
from typing import Any, Iterable

from ddx_genie.llm import RUNS_DIR
from ddx_genie.subset import (
    PROCESSED_DIR,
    REPO_ROOT,
    decode_value,
    load_json,
    region_for,
)

TOP_K_DIFFERENTIAL = 5


# ------------------------------------------------------------------ field <-> evidence


@dataclass
class FieldMap:
    """Translates between worksheet field names and DDXPlus evidences."""

    #: field name -> evidence code
    field_to_code: dict[str, str]
    #: (code, decoded value) -> field name, for region-collapsed multi-selects
    region_to_field: dict[tuple[str, str], str]
    #: evidence codes that have no field at all
    unrepresentable: set[str]

    @classmethod
    def load(cls, plan_path: Path | None = None) -> FieldMap:
        plan = json.loads(
            (plan_path or PROCESSED_DIR / "field_list.json").read_text()
        )
        field_to_code: dict[str, str] = {}
        region_to_field: dict[tuple[str, str], str] = {}
        for spec in plan["fields"]:
            if spec["name"] == "differential":
                continue
            field_to_code[spec["name"]] = spec["evidence_code"]
            if spec.get("region"):
                region_to_field[(spec["evidence_code"], spec["region"])] = spec["name"]
        represented = set(field_to_code.values())
        unrepresentable = set(plan["observed_evidence_codes"]) - represented
        return cls(field_to_code, region_to_field, unrepresentable)

    @property
    def region_collapsed_codes(self) -> set[str]:
        """Codes the field plan actually split into per-region booleans.

        Not every multi-select was collapsed: a short option list (``E_54``,
        "characterize your pain", 16 options) stayed a single Enum. Routing those
        through the region mapping sends their values to ``other``, which has no
        field, and silently drops them from the truth set -- inflating recall and
        charging the agent's correct answers as false positives.
        """
        return {code for code, _ in self.region_to_field}

    def truth_fields(self, evidences: Iterable[dict[str, Any]]) -> set[str]:
        """The set of field names a perfect interviewer would have filled positive.

        Multi-select values collapse through the same region mapping the worksheet
        used, so a patient with pain in the "upper chest" counts as ``pain_chest``.
        """
        definitions = _evidence_definitions()
        out: set[str] = set()
        for item in evidences:
            code, value = item["code"], item.get("value")
            if code in self.unrepresentable:
                continue
            if value is None:
                name = next(
                    (f for f, c in self.field_to_code.items() if c == code), None
                )
                if name:
                    out.add(name)
                continue
            definition = definitions.get(code, {})
            # Route through regions only for codes the plan actually collapsed, not
            # for every multi-select: see FieldMap.region_collapsed_codes.
            if code in self.region_collapsed_codes:
                region = region_for(decode_value(definition, value))
                if name := self.region_to_field.get((code, region)):
                    out.add(name)
            else:
                name = next(
                    (f for f, c in self.field_to_code.items() if c == code), None
                )
                if name:
                    out.add(name)
        return out


_DEFINITIONS: dict[str, Any] | None = None


def _evidence_definitions() -> dict[str, Any]:
    global _DEFINITIONS
    if _DEFINITIONS is None:
        _DEFINITIONS = load_json("release_evidences.json")
    return _DEFINITIONS


def positive_fields(findings: dict[str, Any]) -> set[str]:
    """Fields the agent recorded as a positive finding.

    ``False`` is a denial, not a positive; a numeric 0 on a 0-10 scale is a real
    answer and counts as asked-and-positive for that field.
    """
    return {
        name
        for name, value in findings.items()
        if value is not None and value is not False
    }


# --------------------------------------------------------------------------- metrics


@dataclass
class PatientScore:
    row_index: int
    pathology: str
    system: str
    turns: int
    captured: int
    truth: int
    true_positives: int
    recall: float | None
    precision: float | None
    denials: int
    correct_denials: int
    top1_correct: bool
    top3_correct: bool
    differential_overlap: float | None
    usd: float
    volunteered: int
    unrepresentable_skipped: int
    error: str | None = None


def jaccard(a: set[str], b: set[str]) -> float | None:
    if not a and not b:
        return None
    return len(a & b) / len(a | b)


def score_patient(result: dict[str, Any], field_map: FieldMap) -> PatientScore:
    findings = result.get("findings") or {}
    captured = positive_fields(findings)
    truth = field_map.truth_fields(result.get("true_evidences") or [])
    hits = captured & truth

    denials = {n for n, v in findings.items() if v is False}
    correct_denials = denials - truth  # denied something the patient truly lacks

    ranked = [entry["condition"] for entry in (result.get("differential") or [])]
    pathology = result["pathology"]

    # Ground truth filtered to the conditions both systems may actually output.
    allowed = set(field_map_conditions())
    true_top = [
        entry["pathology"]
        for entry in sorted(
            result.get("true_differential") or [],
            key=lambda e: -e["probability"],
        )
        if entry["pathology"] in allowed
    ][:TOP_K_DIFFERENTIAL]

    return PatientScore(
        row_index=result["row_index"],
        pathology=pathology,
        system=result["system"],
        turns=result.get("turns", 0),
        captured=len(captured),
        truth=len(truth),
        true_positives=len(hits),
        recall=(len(hits) / len(truth)) if truth else None,
        precision=(len(hits) / len(captured)) if captured else None,
        denials=len(denials),
        correct_denials=len(correct_denials),
        top1_correct=bool(ranked) and ranked[0] == pathology,
        top3_correct=pathology in ranked[:3],
        differential_overlap=jaccard(set(ranked[:TOP_K_DIFFERENTIAL]), set(true_top)),
        usd=float(result.get("usd", 0.0)),
        volunteered=sum(max(0, n - 1) for n in result.get("fills_per_turn") or []),
        unrepresentable_skipped=len(field_map.unrepresentable),
        error=result.get("error"),
    )


def field_map_conditions() -> tuple[str, ...]:
    from ddx_genie.subset import CONDITIONS

    return CONDITIONS


def _mean(values: Iterable[float | None]) -> float | None:
    present = [v for v in values if v is not None]
    return statistics.fmean(present) if present else None


def aggregate(scores: list[PatientScore]) -> dict[str, Any]:
    """Means over a group of patients, with None where nothing was measurable."""
    if not scores:
        return {}
    return {
        "n": len(scores),
        "evidence_recall": _mean(s.recall for s in scores),
        "evidence_precision": _mean(s.precision for s in scores),
        "turns": _mean(float(s.turns) for s in scores),
        "fields_captured": _mean(float(s.captured) for s in scores),
        "fields_true": _mean(float(s.truth) for s in scores),
        "top1_accuracy": _mean(float(s.top1_correct) for s in scores),
        "top3_accuracy": _mean(float(s.top3_correct) for s in scores),
        "differential_overlap": _mean(s.differential_overlap for s in scores),
        "usd_per_patient": _mean(s.usd for s in scores),
        "volunteered_per_patient": _mean(float(s.volunteered) for s in scores),
        "denials": _mean(float(s.denials) for s in scores),
        "errors": sum(1 for s in scores if s.error),
    }


def score_run(run_id: str, *, runs_dir: Path = RUNS_DIR) -> dict[str, Any]:
    run_dir = runs_dir / run_id
    files = sorted(p for p in run_dir.glob("*_*.json") if p.name != "summary.json")
    if not files:
        raise FileNotFoundError(f"no patient result files in {run_dir}")

    field_map = FieldMap.load()
    by_system: dict[str, list[PatientScore]] = defaultdict(list)
    for path in files:
        result = json.loads(path.read_text())
        score = score_patient(result, field_map)
        by_system[score.system].append(score)

    summary: dict[str, Any] = {
        "run_id": run_id,
        "unrepresentable_evidence_codes": sorted(field_map.unrepresentable),
        "differential_scored_against": "ground truth filtered to the 6 study conditions",
        "systems": {},
    }
    for system, scores in sorted(by_system.items()):
        per_condition: dict[str, list[PatientScore]] = defaultdict(list)
        for score in scores:
            per_condition[score.pathology].append(score)
        summary["systems"][system] = {
            "overall": aggregate(scores),
            "per_condition": {
                condition: aggregate(group)
                for condition, group in sorted(per_condition.items())
            },
            "patients": [asdict(s) for s in scores],
        }
    (run_dir / "summary.json").write_text(
        json.dumps(summary, indent=2, ensure_ascii=False) + "\n"
    )
    return summary


# ------------------------------------------------------------------------- reporting


def _fmt(value: float | None, spec: str = ".3f") -> str:
    return "  -  " if value is None else format(value, spec)


def print_summary(summary: dict[str, Any]) -> None:
    systems = summary["systems"]
    print(f"run {summary['run_id']}\n")

    rows = [
        ("evidence recall", "evidence_recall", ".3f"),
        ("evidence precision", "evidence_precision", ".3f"),
        ("turns", "turns", ".1f"),
        ("fields captured", "fields_captured", ".1f"),
        ("fields true (representable)", "fields_true", ".1f"),
        ("top-1 accuracy", "top1_accuracy", ".3f"),
        ("top-3 accuracy", "top3_accuracy", ".3f"),
        ("differential overlap", "differential_overlap", ".3f"),
        ("volunteered / patient", "volunteered_per_patient", ".1f"),
        ("USD / patient", "usd_per_patient", ".4f"),
        ("errors", "errors", ".0f"),
    ]
    names = list(systems)
    header = "  " + f"{'metric':<30}" + "".join(f"{n:>14}" for n in names)
    print(header)
    print("  " + "-" * (30 + 14 * len(names)))
    for label, key, spec in rows:
        line = f"  {label:<30}"
        for name in names:
            line += f"{_fmt(systems[name]['overall'].get(key), spec):>14}"
        print(line)
    print(f"\n  n = " + ", ".join(
        f"{n}: {systems[n]['overall']['n']}" for n in names
    ))

    for name in names:
        print(f"\n  {name} by condition:")
        print(f"    {'condition':<44}{'n':>4}{'recall':>9}{'prec':>8}{'top1':>7}{'turns':>7}")
        for condition, stats in systems[name]["per_condition"].items():
            print(
                f"    {condition[:44]:<44}{stats['n']:>4}"
                f"{_fmt(stats['evidence_recall']):>9}"
                f"{_fmt(stats['evidence_precision']):>8}"
                f"{_fmt(stats['top1_accuracy'], '.2f'):>7}"
                f"{_fmt(stats['turns'], '.1f'):>7}"
            )

    if skipped := summary["unrepresentable_evidence_codes"]:
        print(f"\n  excluded from the recall denominator ({len(skipped)} evidence "
              f"codes with no worksheet field): {', '.join(skipped)}")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run-id", default="dev1")
    args = parser.parse_args()
    summary = score_run(args.run_id)
    print_summary(summary)
    print(f"\nwrote {(RUNS_DIR / args.run_id / 'summary.json').relative_to(REPO_ROOT)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
