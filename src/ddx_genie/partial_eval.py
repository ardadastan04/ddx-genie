"""Diagnosis accuracy as a function of how much of the case is known.

Each *arm* gets a partial view of a MediQ case (see ``reveal.py``) and returns a
differential. In the default ``open`` answer space no options are shown: the arm names
its own top-5, as a clinician would, and a judge call finds the gold diagnosis in it.
``mcq4`` keeps MediQ's four options as a closed list. Today there is one arm:

``oneshot``
    Diagnose straight from the revealed facts, no questions asked. This single arm
    already yields three of the planned baselines, because they differ only in the
    view it is handed:

    - ``prefix`` views at p<1  -> one-shot on an interrupted consultation
    - ``gaps``   views at p<1  -> one-shot on matched information with random holes
    - the p=1 view             -> the oracle (full case)

Gap-filling arms (the Genie agent, John's question tree) will implement the same
:class:`Arm` protocol, so their curves are directly comparable: same views, same
diagnosis prompt, same model.

Results go to ``runs/<run_id>/<view>.json`` (resumable) plus ``summary.json``.

Run: ``uv run python -m ddx_genie.partial_eval --run-id mediq_open_dev --limit 5``
"""

from __future__ import annotations

import argparse
import json
from collections import defaultdict
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any, Literal, Protocol

import csv
import random

from ddx_genie.diagnosis import (
    Differential,
    Judgement,
    diagnose_facts,
    diagnose_open,
    judge_differential,
)
from ddx_genie.llm import RUNS_DIR, LLMClient
from ddx_genie.reveal import SUBSET_PATH, VIEWS_PATH

#: CLAUDE.md: never run more than 5 cases without explicit confirmation.
MAX_UNCONFIRMED_CASES = 5
#: Views to run before projecting the whole batch's cost against MAX_RUN_USD.
ESTIMATE_AFTER_VIEWS = 3
#: Judge decisions sampled into judge_review.csv for a human to check.
JUDGE_REVIEW_N = 30

#: ``open``: the model names its own differential (no options shown), and a judge
#: call matches it to gold -- how clinicians actually work. ``mcq4``: MediQ's four
#: options as a closed list (kept for comparison; the options leak a lot).
AnswerSpace = Literal["open", "mcq4"]
ANSWER_SPACES: tuple[str, ...] = ("open", "mcq4")


class Arm(Protocol):
    name: str

    def diagnose(self, view: dict[str, Any], case: dict[str, Any]) -> Differential:
        """Return a differential over ``case["options"]`` given only ``view``."""


@dataclass
class OneShotArm:
    client: LLMClient
    answer_space: AnswerSpace = "open"
    name: str = "oneshot"

    def diagnose(self, view: dict[str, Any], case: dict[str, Any]) -> Differential:
        tag = f"{self.name}:{self.answer_space}:{view['mode']}"
        if self.answer_space == "open":
            return diagnose_open(view["facts"], client=self.client, tag=tag)
        return diagnose_facts(
            view["facts"], client=self.client, conditions=option_texts(case), tag=tag
        )


@dataclass
class ViewResult:
    view_id: str
    case_id: str
    arm: str
    mode: str
    fraction: float
    n_revealed: int
    n_facts: int
    answer: str
    answer_idx: str
    predicted: str | None
    correct: bool
    p_gold: float
    parse_ok: bool
    differential: list[dict[str, Any]]
    raw: str
    usd: float
    # Defaults keep result files written before open-ended mode loadable.
    answer_space: str = "mcq4"
    #: 1-based rank of gold in the differential, None if absent.
    match_rank: int | None = None
    judge_reason: str = ""
    judge_parse_ok: bool = True
    #: Open mode only: per-candidate relation to gold, and the rank if a broader
    #: category also counted (secondary, lenient metric).
    judge_relations: list[str] | None = None
    lenient_rank: int | None = None

    def hit_at(self, k: int) -> bool:
        if self.match_rank is None and self.answer_space == "mcq4":
            names = [d["condition"] for d in self.differential]
            return self.answer in names[:k]
        return self.match_rank is not None and self.match_rank <= k


def option_texts(case: dict[str, Any]) -> tuple[str, ...]:
    """Options in letter order (A, B, C, D)."""
    return tuple(case["options"][k] for k in sorted(case["options"]))


def score_view(
    view: dict[str, Any],
    case: dict[str, Any],
    diff: Differential,
    arm: str,
    usd: float,
    *,
    answer_space: AnswerSpace = "mcq4",
    judgement: Judgement | None = None,
) -> ViewResult:
    """Score one view. ``open`` needs the judge's verdict; ``mcq4`` is exact match."""
    names = [name for name, _ in diff.ranked]
    if answer_space == "open":
        if judgement is None:
            raise ValueError("open answer space needs a judgement")
        rank = judgement.match_rank
    else:
        rank = names.index(case["answer"]) + 1 if case["answer"] in names else None
    p_gold = diff.ranked[rank - 1][1] if rank is not None else 0.0
    return ViewResult(
        view_id=view["view_id"],
        case_id=case["case_id"],
        arm=arm,
        mode=view["mode"],
        fraction=view["fraction"],
        n_revealed=len(view["revealed"]),
        n_facts=len(view["revealed"]) + len(view["hidden"]),
        answer=case["answer"],
        answer_idx=case["answer_idx"],
        predicted=diff.top1,
        correct=rank == 1,
        p_gold=p_gold,
        parse_ok=bool(diff.ranked),
        differential=diff.as_json(),
        raw=diff.raw,
        usd=usd,
        answer_space=answer_space,
        match_rank=rank,
        judge_reason=judgement.reason if judgement else "",
        judge_parse_ok=judgement.parse_ok if judgement else True,
        judge_relations=judgement.relations if judgement else None,
        lenient_rank=judgement.lenient_rank if judgement else rank,
    )


def aggregate(results: list[ViewResult]) -> dict[str, Any]:
    """Accuracy and mean P(gold) per (mode, fraction). p=0/p=1 count for both modes."""
    cells: dict[tuple[str, float], list[ViewResult]] = defaultdict(list)
    modes = {r.mode for r in results} | {"gaps"}
    for r in results:
        if r.fraction in (0.0, 1.0):  # shared endpoints, stored once under prefix
            for mode in modes:
                cells[(mode, r.fraction)].append(r)
        else:
            cells[(r.mode, r.fraction)].append(r)
    rows = []
    for (mode, fraction), rs in sorted(cells.items()):
        rows.append({
            "mode": mode,
            "fraction": fraction,
            "n": len(rs),
            "accuracy": sum(r.correct for r in rs) / len(rs),
            "top3": sum(r.hit_at(3) for r in rs) / len(rs),
            "top5": sum(r.hit_at(5) for r in rs) / len(rs),
            "accuracy_lenient": sum(r.correct or r.lenient_rank == 1 for r in rs) / len(rs),
            "mean_p_gold": sum(r.p_gold for r in rs) / len(rs),
            "parse_failures": sum(not (r.parse_ok and r.judge_parse_ok) for r in rs),
        })
    return {"cells": rows, "n_cases": len({r.case_id for r in results})}


def load_jsonl(path: Path) -> list[dict[str, Any]]:
    return [json.loads(line) for line in path.read_text().splitlines() if line.strip()]


def _result_path(run_dir: Path, view_id: str) -> Path:
    return run_dir / (view_id.replace(":", "__") + ".json")


def run(
    arm: Arm,
    client: LLMClient,
    *,
    run_id: str,
    limit: int,
    runs_dir: Path = RUNS_DIR,
) -> list[ViewResult]:
    cases = load_jsonl(SUBSET_PATH)[:limit]
    by_id = {c["case_id"]: c for c in cases}
    views = [v for v in load_jsonl(VIEWS_PATH) if v["case_id"] in by_id]
    run_dir = runs_dir / run_id
    run_dir.mkdir(parents=True, exist_ok=True)

    results: list[ViewResult] = []
    fresh = 0
    session_start_usd = client.cost_log.total_usd
    for case in cases:
        for view in (v for v in views if v["case_id"] == case["case_id"]):
            path = _result_path(run_dir, view["view_id"])
            if path.exists():  # resumable
                results.append(ViewResult(**json.loads(path.read_text())))
                continue
            client.budget.check()
            before = client.cost_log.total_usd
            diff = arm.diagnose(view, case)
            space: AnswerSpace = getattr(arm, "answer_space", "mcq4")
            judgement = None
            if space == "open":
                judgement = judge_differential(
                    [name for name, _ in diff.ranked], case["answer"], client=client
                )
            result = score_view(
                view, case, diff, arm.name, client.cost_log.total_usd - before,
                answer_space=space, judgement=judgement,
            )
            path.write_text(json.dumps(asdict(result), indent=1) + "\n")
            results.append(result)
            fresh += 1
            if fresh == ESTIMATE_AFTER_VIEWS:
                per_view = (client.cost_log.total_usd - session_start_usd) / fresh
                _check_projection(client, per_view, remaining=len(views) - len(results))
        print(f"{case['case_id']}: done | {client.summary()}")
    return results


def _check_projection(client: LLMClient, per_view_usd: float, remaining: int) -> None:
    """Per *view*, not per call: an open-ended view costs two calls (diagnose + judge)."""
    projected = client.cost_log.total_usd + per_view_usd * remaining
    print(f"projected run total ${projected:.4f} (cap ${client.budget.max_run_usd:.2f})")
    if projected > client.budget.max_run_usd:
        raise SystemExit("projected spend exceeds MAX_RUN_USD; aborting before the batch")


def print_summary(summary: dict[str, Any]) -> None:
    by_mode: dict[str, dict[float, dict[str, Any]]] = defaultdict(dict)
    for cell in summary["cells"]:
        by_mode[cell["mode"]][cell["fraction"]] = cell
    fractions = sorted({c["fraction"] for c in summary["cells"]})
    modes = sorted(by_mode, key=lambda m: m != "prefix")
    print(f"\n{summary['n_cases']} cases, answer space {summary['answer_space']}")
    for metric in ("accuracy", "accuracy_lenient", "top3", "top5", "mean_p_gold"):
        print(f"\n  {metric:<12}" + "".join(f"{f:>7.1f}" for f in fractions))
        for mode in modes:
            cells = by_mode[mode]
            row = "".join(f"{cells[f][metric]:>7.2f}" if f in cells else " " * 7 for f in fractions)
            print(f"  {mode:<12}{row}")
    fails = sum(c["parse_failures"] for c in summary["cells"])
    if fails:
        print(f"\n  WARNING: {fails} unparseable differentials or judgements (scored as misses)")


def write_judge_review(
    results: list[ViewResult], path: Path, n: int = JUDGE_REVIEW_N, seed: int = 0
) -> None:
    """Sample judge decisions for a human to verify. Fill in the ``human_agrees`` column."""
    judged = sorted((r for r in results if r.answer_space == "open"), key=lambda r: r.view_id)
    picked = random.Random(seed).sample(judged, min(n, len(judged)))
    with path.open("w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["view_id", "gold", "candidates", "judge_relations",
                         "judge_match_rank", "judge_reason", "human_agrees"])
        for r in sorted(picked, key=lambda r: r.view_id):
            candidates = " | ".join(
                f"{i}. {d['condition']}" for i, d in enumerate(r.differential, 1)
            )
            writer.writerow([r.view_id, r.answer, candidates,
                             " | ".join(r.judge_relations or []), r.match_rank or "",
                             r.judge_reason, ""])


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--run-id", required=True)
    parser.add_argument("--answer-space", choices=ANSWER_SPACES, default="open")
    parser.add_argument("--limit", type=int, default=MAX_UNCONFIRMED_CASES)
    parser.add_argument("--confirmed", action="store_true",
                        help=f"required for more than {MAX_UNCONFIRMED_CASES} cases")
    args = parser.parse_args()
    if args.limit > MAX_UNCONFIRMED_CASES and not args.confirmed:
        parser.error(f"--limit {args.limit} > {MAX_UNCONFIRMED_CASES} needs --confirmed")

    client = LLMClient(args.run_id)
    arm = OneShotArm(client, answer_space=args.answer_space)
    results = run(arm, client, run_id=args.run_id, limit=args.limit)
    spaces = {r.answer_space for r in results}
    if spaces != {args.answer_space}:
        raise SystemExit(f"run {args.run_id!r} mixes answer spaces {spaces}; use a new --run-id")
    run_dir = RUNS_DIR / args.run_id
    summary = aggregate(results) | {
        "arm": arm.name, "answer_space": args.answer_space, "usd": client.cost_log.total_usd,
    }
    (run_dir / "summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    print_summary(summary)
    if args.answer_space == "open":
        write_judge_review(results, run_dir / "judge_review.csv")
        print(f"\njudge sample for human check: {run_dir / 'judge_review.csv'}")
    print(f"\n{client.summary()}\nwrote {run_dir / 'summary.json'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
