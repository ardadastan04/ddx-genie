"""Sample questions and pairs for the failure-analysis note (solver-only runs; no LLM).

  uv run python scripts/failure_sample.py main_dev            # writes runs/main_dev/failure_sample.md

From a harness run (``runs/<run_id>/``), with seed 0:
  A. N ``useful_unanswered`` questions per policy (default 15 for greedy_smt and 15 for
     answerable_informative): informative questions whose answer was unknown;
  B. every pair where answerable_informative is wrong at k=30 but greedy_smt is right;
  C. every pair where greedy_smt is wrong at k=30 but answerable_informative is right.
Per item: patient (with the note in a collapsible block), trial title, variable meaning, answer, and
the criteria line that mentions the variable (best match, may be missing). Each item ends with a blank
"Category:" line to fill in by hand.
"""

from __future__ import annotations

import argparse
import csv
import random
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path[:0] = [str(ROOT), str(ROOT / "src")]

from smt_trial_matching import metrics as M
from smt_trial_matching.replay import criteria_line, patient_note, trial

SEED = 0


def _note_block(qid: str) -> list[str]:
    return ["<details><summary>patient note</summary>", "", patient_note(qid), "", "</details>", ""]


def _criteria(nct: str, var: str, meaning: str) -> str:
    hit = criteria_line(nct, var, meaning)
    return f"{hit[0]}: “{hit[1]}”" if hit else "(no matching line found)"


def _question_item(i: int, r: dict) -> list[str]:
    return [
        f"### A{i}. {r['policy']} · {r['qid']} · turn {r['turn']}",
        "",
        f"- **Trial:** {r['nct']}, {trial(r['nct']).get('title', '')}",
        f"- **Question:** {r['meaning'] or r['var']}",
        f"- **Variable:** `{r['var']}`",
        f"- **Answer:** {r['answer']} ({r['label']})",
        f"- **Criteria line:** {_criteria(r['nct'], r['var'], r['meaning'])}",
        "",
        *_note_block(r["qid"]),
        "Category:",
        "",
    ]


def _pair_item(tag: str, qid: str, nct: str, gold: bool, verdicts: dict[str, str],
               asked: dict[str, list[dict]]) -> list[str]:
    g = "eligible" if gold else "ineligible"
    lines = [f"### {tag}. {qid} × {nct}", "",
             f"- **Trial:** {trial(nct).get('title', '')}",
             f"- **Gold:** {g}; at k=30: " + ", ".join(f"{p} → {v}" for p, v in verdicts.items())]
    for pol, qs in asked.items():
        lines.append(f"- **{pol} asked on this trial ({len(qs)}):**" + ("" if qs else " nothing"))
        for q in qs:
            lines.append(f"  - turn {q['turn']}: {q['meaning'] or q['var']} → {q['answer']} ({q['label']})")
            lines.append(f"    criteria line: {_criteria(nct, q['var'], q['meaning'])}")
    return [*lines, "", *_note_block(qid), "Category:", ""]


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("run_id")
    ap.add_argument("--key", default="gpt5_oracle")
    ap.add_argument("--n", type=int, default=15, help="useful_unanswered questions per policy")
    ap.add_argument("--policy", default="answerable_informative")
    ap.add_argument("--baseline", default="greedy_smt")
    ap.add_argument("--k", type=int, default=30)
    a = ap.parse_args(argv)

    run = ROOT / "runs" / a.run_id
    rows = [r for r in csv.DictReader((run / "questions.csv").open()) if r["key"] == a.key]
    by_pair: dict[tuple[str, str, str], list[dict]] = defaultdict(list)
    for r in rows:
        r["turn"] = int(r["turn"])
        by_pair[(r["policy"], r["qid"], r["nct"])].append(r)

    out = [f"# Failure sample: run `{a.run_id}`, key `{a.key}`", "",
           (f"Seed {SEED}. A = {a.n} random *useful, unanswered* questions per policy (informative, but "
            f"the answer was unknown). B/C = every pair where one policy is right at k={a.k} and the "
            "other is wrong. Criteria lines are a keyword match and can be off. Fill in each "
            "**Category:** line."), ""]

    rng = random.Random(SEED)
    i = 0
    for pol in (a.baseline, a.policy):
        pool = [r for r in rows if r["policy"] == pol and r["label"] == "useful_unanswered"]
        pick = sorted(rng.sample(pool, min(a.n, len(pool))), key=lambda r: (r["qid"], r["turn"]))
        out += [f"## A. {pol}: useful but unanswered ({len(pick)} of {len(pool)})", ""]
        for r in pick:
            i += 1
            out += _question_item(i, r)

    gold = M.load_gold()
    eps = {p: {e["qid"]: e for e in M.load_log(run / a.key / f"{p}.jsonl")}
           for p in (a.baseline, a.policy)}
    flips: dict[str, list[tuple[str, str]]] = {"B": [], "C": []}
    for qid in sorted(eps[a.policy]):
        v = {p: M.verdicts_at(eps[p][qid], a.k) for p in eps}
        for nct in eps[a.policy][qid]["trials"]:
            ok = {p: (v[p][nct] == "eligible") == gold[(qid, nct)] for p in eps}
            if ok[a.baseline] and not ok[a.policy]:
                flips["B"].append((qid, nct))
            elif ok[a.policy] and not ok[a.baseline]:
                flips["C"].append((qid, nct))
    titles = {"B": f"{a.policy} wrong, {a.baseline} right", "C": f"{a.baseline} wrong, {a.policy} right"}
    for tag in ("B", "C"):
        out += [f"## {tag}. {titles[tag]} at k={a.k} ({len(flips[tag])} pairs)", ""]
        for j, (qid, nct) in enumerate(flips[tag], 1):
            verdicts = {p: M.verdicts_at(eps[p][qid], a.k)[nct] for p in eps}
            asked = {p: [r for r in by_pair[(p, qid, nct)] if r["turn"] <= a.k] for p in eps}
            out += _pair_item(f"{tag}{j}", qid, nct, gold[(qid, nct)], verdicts, asked)

    path = run / "failure_sample.md"
    path.write_text("\n".join(out))
    print(f"wrote {path.relative_to(ROOT)}: {i} questions, {len(flips['B'])} + {len(flips['C'])} pairs")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
