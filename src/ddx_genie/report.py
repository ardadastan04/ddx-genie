"""Turn a scored run into paper-ready tables and a failure analysis.

    uv run python -m ddx_genie.report --run-id dev3

Emits, into ``runs/<run_id>/report/``:

``comparison.md``
    The headline table, plus per-condition breakdowns, formatted for the paper.
``missed_evidences.md``
    Which evidences each system failed to elicit most often. This is the useful
    qualitative output: it says *what* the agents forgot to ask, which is the claim
    the study is actually about.
``failures.md``
    Why each wrong diagnosis was wrong, attributed to missed evidence, wrong evidence,
    or the diagnosis step itself.
``per_condition.svg``
    Grouped bars for the metric of interest, drawn without a plotting dependency so
    the report works on a bare checkout.
"""

from __future__ import annotations

import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any

from ddx_genie.llm import RUNS_DIR
from ddx_genie.score import FieldMap, positive_fields
from ddx_genie.subset import REPO_ROOT

METRICS: list[tuple[str, str, str]] = [
    ("Evidence recall", "evidence_recall", ".3f"),
    ("Evidence precision", "evidence_precision", ".3f"),
    ("Turns", "turns", ".1f"),
    ("Fields captured", "fields_captured", ".1f"),
    ("Top-1 accuracy", "top1_accuracy", ".3f"),
    ("Top-3 accuracy", "top3_accuracy", ".3f"),
    ("Differential overlap", "differential_overlap", ".3f"),
    ("Volunteered findings", "volunteered_per_patient", ".1f"),
    ("USD per patient", "usd_per_patient", ".4f"),
]

SYSTEM_LABELS = {"genie": "Genie Worksheets", "baseline": "Function calling"}


def fmt(value: Any, spec: str) -> str:
    if value is None:
        return "—"
    try:
        return format(float(value), spec)
    except (TypeError, ValueError):
        return str(value)


def comparison_table(summary: dict[str, Any]) -> str:
    systems = list(summary["systems"])
    labels = [SYSTEM_LABELS.get(s, s) for s in systems]
    lines = [
        "## System comparison",
        "",
        f"| Metric | {' | '.join(labels)} |",
        f"|---|{'---|' * len(systems)}",
    ]
    for label, key, spec in METRICS:
        cells = [
            fmt(summary["systems"][s]["overall"].get(key), spec) for s in systems
        ]
        lines.append(f"| {label} | {' | '.join(cells)} |")
    # Contextualise every accuracy number against what is even achievable.
    ceiling_path = Path(__file__).resolve().parents[2] / "runs" / "oracle" / "oracle_ceiling.json"
    if ceiling_path.exists():
        ceiling = json.loads(ceiling_path.read_text())
        pad = " | ".join(["—"] * (len(systems) - 1))
        lines.append(
            f"| _Oracle ceiling (perfect evidence), top-1_ "
            f"| {fmt(ceiling['top1_accuracy'], '.3f')}"
            + (f" | {pad} |" if pad else " |")
        )
        lines.append(
            f"| _Oracle ceiling, top-3_ | {fmt(ceiling['top3_accuracy'], '.3f')}"
            + (f" | {pad} |" if pad else " |")
        )
    ns = ", ".join(
        f"{SYSTEM_LABELS.get(s, s)}: {summary['systems'][s]['overall']['n']}"
        for s in systems
    )
    lines += ["", f"n = {ns}.", ""]

    note = summary.get("differential_scored_against")
    excluded = summary.get("unrepresentable_evidence_codes") or []
    lines += [
        "### Measurement notes",
        "",
        f"- Differential overlap is computed against {note}. The unfiltered DDXPlus "
        "differential has a median of 12 entries while both systems may only output "
        "the six study conditions, so comparing against it caps overlap below 1.0 by "
        "construction.",
        "- Accuracy must be read against the oracle ceiling: given each patient's "
        "complete true evidence, the same diagnosis prompt reaches only top-1 0.650 "
        "(top-3 0.950). DDXPlus's own differential, restricted to these six "
        "conditions, reaches 0.617. The ceiling is a property of the dataset, so "
        "top-1 accuracy is not a valid discriminator between the systems here.",
        f"- {len(excluded)} evidence codes are excluded from the recall denominator "
        "because the worksheet has no field for them "
        f"({', '.join(excluded)}). Counting them would penalise both systems for the "
        "specification's scope.",
        "",
    ]
    return "\n".join(lines)


def per_condition_table(summary: dict[str, Any]) -> str:
    lines = ["## Per condition", ""]
    for system, block in summary["systems"].items():
        lines += [
            f"### {SYSTEM_LABELS.get(system, system)}",
            "",
            "| Condition | n | Recall | Precision | Top-1 | Turns |",
            "|---|---|---|---|---|---|",
        ]
        for condition, stats in block["per_condition"].items():
            lines.append(
                f"| {condition} | {stats['n']} "
                f"| {fmt(stats.get('evidence_recall'), '.3f')} "
                f"| {fmt(stats.get('evidence_precision'), '.3f')} "
                f"| {fmt(stats.get('top1_accuracy'), '.2f')} "
                f"| {fmt(stats.get('turns'), '.1f')} |"
            )
        lines.append("")
    return "\n".join(lines)


def missed_evidences(run_dir: Path, field_map: FieldMap) -> str:
    """Which fields each system most often failed to elicit."""
    missed: dict[str, Counter[str]] = defaultdict(Counter)
    false_pos: dict[str, Counter[str]] = defaultdict(Counter)
    opportunities: dict[str, Counter[str]] = defaultdict(Counter)

    for path in sorted(run_dir.glob("*_*.json")):
        if path.name == "summary.json":
            continue
        result = json.loads(path.read_text())
        system = result["system"]
        truth = field_map.truth_fields(result.get("true_evidences") or [])
        captured = positive_fields(result.get("findings") or {})
        for name in truth:
            opportunities[system][name] += 1
        for name in truth - captured:
            missed[system][name] += 1
        for name in captured - truth:
            false_pos[system][name] += 1

    lines = ["## What the agents failed to elicit", ""]
    for system in sorted(missed):
        lines += [
            f"### {SYSTEM_LABELS.get(system, system)}",
            "",
            "Most-missed findings (present in the patient, never recorded):",
            "",
            "| Field | Missed | Of | Miss rate |",
            "|---|---|---|---|",
        ]
        for name, count in missed[system].most_common(15):
            total = opportunities[system][name]
            lines.append(f"| `{name}` | {count} | {total} | {count / total:.0%} |")
        lines += ["", "Most-common false positives (recorded, but not true):", ""]
        if false_pos[system]:
            lines += ["| Field | Count |", "|---|---|"]
            lines += [
                f"| `{name}` | {count} |"
                for name, count in false_pos[system].most_common(10)
            ]
        else:
            lines.append("None.")
        lines.append("")
    return "\n".join(lines)


def stalled_conversations(run_dir: Path) -> str:
    """Patients where the interview hit the cap or produced almost nothing."""
    lines = ["## Where conversations stalled", "",
             "| System | Row | Condition | Turns | Fields | Hit cap | Error |",
             "|---|---|---|---|---|---|---|"]
    rows = []
    for path in sorted(run_dir.glob("*_*.json")):
        if path.name == "summary.json":
            continue
        r = json.loads(path.read_text())
        hit_cap = r.get("turns", 0) >= r.get("max_turns", 0)
        if hit_cap or r.get("error") or len(r.get("findings") or {}) < 5:
            rows.append(
                f"| {r['system']} | {r['row_index']} | {r['pathology']} "
                f"| {r.get('turns')} | {len(r.get('findings') or {})} "
                f"| {'yes' if hit_cap else 'no'} | {r.get('error') or '—'} |"
            )
    lines += rows or ["| — | — | — | — | — | — | — |"]
    lines.append("")
    return "\n".join(lines)


def per_condition_svg(summary: dict[str, Any], metric: str = "evidence_recall") -> str:
    """Grouped bar chart as hand-written SVG, so no plotting dependency is needed."""
    systems = list(summary["systems"])
    conditions = sorted(
        {c for s in systems for c in summary["systems"][s]["per_condition"]}
    )
    if not conditions:
        return "<svg xmlns='http://www.w3.org/2000/svg'/>"

    pad_left, pad_top, pad_bottom = 190, 36, 46
    row_h, bar_h, gap = 34, 12, 4
    width, plot_w = 760, 760 - pad_left - 24
    height = pad_top + row_h * len(conditions) + pad_bottom
    colours = ["#2f6f4f", "#8a5a2b", "#3a5a8a", "#7a3a5a"]

    out = [
        f"<svg xmlns='http://www.w3.org/2000/svg' width='{width}' height='{height}' "
        f"viewBox='0 0 {width} {height}' font-family='system-ui,sans-serif'>",
        f"<rect width='{width}' height='{height}' fill='#fdfdfb'/>",
        f"<text x='16' y='22' font-size='14' font-weight='600'>"
        f"{metric.replace('_', ' ')} by condition</text>",
    ]
    for tick in (0.0, 0.25, 0.5, 0.75, 1.0):
        x = pad_left + tick * plot_w
        out.append(
            f"<line x1='{x:.1f}' y1='{pad_top}' x2='{x:.1f}' "
            f"y2='{height - pad_bottom}' stroke='#e2e2dc'/>"
        )
        out.append(
            f"<text x='{x:.1f}' y='{height - pad_bottom + 16}' font-size='10' "
            f"fill='#666' text-anchor='middle'>{tick:g}</text>"
        )
    for row, condition in enumerate(conditions):
        y0 = pad_top + row * row_h
        label = condition if len(condition) <= 30 else condition[:29] + "…"
        out.append(
            f"<text x='{pad_left - 8}' y='{y0 + row_h / 2 + 4:.1f}' font-size='11' "
            f"fill='#333' text-anchor='end'>{label}</text>"
        )
        for i, system in enumerate(systems):
            stats = summary["systems"][system]["per_condition"].get(condition, {})
            value = stats.get(metric)
            if value is None:
                continue
            w = max(1.0, float(value) * plot_w)
            y = y0 + (row_h - (bar_h * len(systems) + gap)) / 2 + i * (bar_h + gap / 2)
            out.append(
                f"<rect x='{pad_left}' y='{y:.1f}' width='{w:.1f}' height='{bar_h}' "
                f"fill='{colours[i % len(colours)]}' rx='2'/>"
            )
            out.append(
                f"<text x='{pad_left + w + 5:.1f}' y='{y + bar_h - 2:.1f}' "
                f"font-size='9' fill='#555'>{float(value):.2f}</text>"
            )
    for i, system in enumerate(systems):
        x = 16 + i * 170
        out.append(
            f"<rect x='{x}' y='{height - 22}' width='10' height='10' "
            f"fill='{colours[i % len(colours)]}' rx='2'/>"
        )
        out.append(
            f"<text x='{x + 15}' y='{height - 13}' font-size='11' fill='#333'>"
            f"{SYSTEM_LABELS.get(system, system)}</text>"
        )
    out.append("</svg>")
    return "\n".join(out)


def build_report(run_id: str, *, runs_dir: Path = RUNS_DIR) -> Path:
    run_dir = runs_dir / run_id
    summary_path = run_dir / "summary.json"
    if not summary_path.exists():
        raise FileNotFoundError(
            f"{summary_path} is missing; run `python -m ddx_genie.score "
            f"--run-id {run_id}` first"
        )
    summary = json.loads(summary_path.read_text())
    field_map = FieldMap.load()

    out_dir = run_dir / "report"
    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / "comparison.md").write_text(
        f"# DDXPlus × Genie Worksheets — run `{run_id}`\n\n"
        + comparison_table(summary)
        + "\n"
        + per_condition_table(summary)
        + "\n"
        + stalled_conversations(run_dir)
    )
    (out_dir / "missed_evidences.md").write_text(
        missed_evidences(run_dir, field_map)
    )

    # Failure attribution needs one cached LLM call per wrong diagnosis.
    from ddx_genie.failure import analyse_run, failure_table
    from ddx_genie.llm import LLMClient

    cases = analyse_run(run_dir, field_map, LLMClient(f"{run_id}-failures"))
    (out_dir / "failures.md").write_text(failure_table(cases))
    (out_dir / "failures.json").write_text(
        json.dumps([c.as_json() for c in cases], indent=2) + "\n"
    )
    (out_dir / "per_condition.svg").write_text(per_condition_svg(summary))
    return out_dir


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run-id", default="dev3")
    args = parser.parse_args()
    out_dir = build_report(args.run_id)
    print(f"wrote {out_dir.relative_to(REPO_ROOT)}/")
    for path in sorted(out_dir.iterdir()):
        print(f"  {path.name}")
    print()
    print((out_dir / "failures.md").read_text())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
