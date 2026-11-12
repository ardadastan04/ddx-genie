"""Print the frozen MediQ baseline numbers as markdown tables (no LLM calls).

    uv run python scripts/baseline_report.py [--oneshot-run mediq_open_v1] [--baselines-run baselines_v1]

Reads saved per-case results, so it is free and deterministic. 95% CIs are Wilson
intervals for proportions and percentile bootstrap (seed 0) for means.
"""

from __future__ import annotations

import argparse
import json
import math
import random
from collections import defaultdict
from pathlib import Path

RUNS = Path(__file__).resolve().parents[1] / "runs"


def wilson(k: int, n: int, z: float = 1.96) -> tuple[float, float]:
    if n == 0:
        return (float("nan"), float("nan"))
    p = k / n
    d = 1 + z * z / n
    c = (p + z * z / (2 * n)) / d
    h = z * math.sqrt(p * (1 - p) / n + z * z / (4 * n * n)) / d
    return (c - h, c + h)


def boot(xs: list[float], reps: int = 2000) -> tuple[float, float]:
    rng = random.Random(0)
    means = sorted(sum(rng.choices(xs, k=len(xs))) / len(xs) for _ in range(reps))
    return (means[int(0.025 * reps)], means[int(0.975 * reps)])


def prop(hits: list[bool]) -> str:
    k, n = sum(hits), len(hits)
    lo, hi = wilson(k, n)
    return f"{k / n:.2f} [{lo:.2f}–{hi:.2f}]"


def mean(xs: list[float]) -> str:
    lo, hi = boot(xs)
    return f"{sum(xs) / len(xs):.2f} [{lo:.2f}–{hi:.2f}]"


def oneshot_tables(run: str) -> None:
    rows = [json.loads(p.read_text()) for p in (RUNS / run).glob("mediq-*.json")]
    cells: dict[tuple[str, float], list[dict]] = defaultdict(list)
    for r in rows:
        modes = ("prefix", "gaps") if r["fraction"] in (0.0, 1.0) else (r["mode"],)
        for m in modes:
            cells[(m, r["fraction"])].append(r)
    fr = sorted({f for _, f in cells})
    print(f"\n### Baseline 1: one-shot vs. information ({run}, n={len({r['case_id'] for r in rows})})\n")
    print("| mode | metric | " + " | ".join(f"p={f:.1f}" for f in fr) + " |")
    print("|---|---|" + "---|" * len(fr))
    for m in ("prefix", "gaps"):
        for label, fn in (("top-1", lambda rs: prop([r["match_rank"] == 1 for r in rs])),
                          ("top-5", lambda rs: prop([r["match_rank"] is not None for r in rs])),
                          ("P(gold)", lambda rs: mean([r["p_gold"] for r in rs]))):
            print(f"| {m} | {label} | " + " | ".join(fn(cells[(m, f)]) for f in fr) + " |")

    # Calibration: confidence = probability the model put on its own top answer.
    print("\nCalibration of the top answer (all views pooled):\n")
    print("| stated confidence | n | actual top-1 accuracy |")
    print("|---|---|---|")
    bins = [(0, .4), (.4, .6), (.6, .8), (.8, 1.01)]
    ece, n_all = 0.0, 0
    for lo, hi in bins:
        sel = [r for r in rows if r["differential"] and lo <= r["differential"][0]["probability"] < hi]
        if sel:
            conf = sum(r["differential"][0]["probability"] for r in sel) / len(sel)
            acc = sum(r["match_rank"] == 1 for r in sel) / len(sel)
            ece += len(sel) * abs(conf - acc)
            n_all += len(sel)
            print(f"| {lo:.1f}–{min(hi, 1):.1f} (mean {conf:.2f}) | {len(sel)} | {acc:.2f} |")
    print(f"\nExpected calibration error (ECE): {ece / n_all:.3f}")
    by_f = defaultdict(list)
    for r in rows:
        if r["differential"]:
            by_f[r["fraction"]].append(r["differential"][0]["probability"])
    print("Mean top-answer confidence by p: " + ", ".join(
        f"{f:.1f}: {sum(v) / len(v):.2f}" for f, v in sorted(by_f.items())))


def load(run: str, name: str) -> list[dict]:
    return [json.loads(p.read_text()) for p in sorted((RUNS / run / name).glob("*.json"))]


def asking_tables(run: str, oneshot: str) -> None:
    ask, rnd, best, gap = (load(run, n) for n in ("asking", "random", "bestk", "gapid"))
    ids = {r["case_id"] for r in ask}
    one = {}
    for f in (0.0, 1.0):
        for p in (RUNS / oneshot).glob(f"*__prefix__{f:.1f}.json"):
            r = json.loads(p.read_text())
            if r["case_id"] in ids:
                one[(r["case_id"], f)] = r
    k0 = [one[(i, 0.0)] for i in ids if (i, 0.0) in one]
    full = [one[(i, 1.0)] for i in ids if (i, 1.0) in one]

    def step_rows(results: list[dict], k: int) -> list[dict]:
        return [s["scored"] for r in results for s in r["steps"] if s["k"] == k]

    print(f"\n### Baselines 2 and 4: questions asked vs. accuracy ({run}, n={len(ids)})\n")
    print("| k (facts obtained) | arm | top-1 | top-5 | P(gold) |")
    print("|---|---|---|---|---|")
    print(f"| 0 | one-shot (complaint only) | {prop([r['match_rank'] == 1 for r in k0])} | "
          f"{prop([r['match_rank'] is not None for r in k0])} | {mean([r['p_gold'] for r in k0])} |")
    for k in range(1, 6):
        for label, res in (("prompted asking", ask), ("random facts", rnd), ("best-k ceiling", best)):
            rows = step_rows(res, k)
            if rows:
                print(f"| {k} | {label} | {prop([r['match_rank'] == 1 for r in rows])} | "
                      f"{prop([r['match_rank'] is not None for r in rows])} | "
                      f"{mean([r['p_gold'] for r in rows])} |")
    print(f"| all | full case (oracle) | {prop([r['match_rank'] == 1 for r in full])} | "
          f"{prop([r['match_rank'] is not None for r in full])} | {mean([r['p_gold'] for r in full])} |")

    steps = [s for r in ask for s in r["steps"]]
    print(f"\nAsking behaviour: {len(steps)} questions; "
          f"{sum(s['wasted'] for s in steps) / len(steps):.0%} got no new fact; "
          f"{sum(len(s['answered_with']) for s in steps) / len(steps):.2f} facts per question.")

    # Gap closed at k=3: (arm - oneshot) / (bestk - oneshot), on mean P(gold).
    base = sum(r["p_gold"] for r in k0) / len(k0)
    ceil = sum(r["p_gold"] for r in step_rows(best, 3)) / len(step_rows(best, 3))
    for label, res in (("prompted asking", ask), ("random facts", rnd)):
        v = sum(r["p_gold"] for r in step_rows(res, 3)) / len(step_rows(res, 3))
        print(f"Gap closed at k=3 (P(gold)), {label}: {(v - base) / (ceil - base):.0%}")

    key = {r["case_id"]: set(r["key_facts"]) for r in best}
    print(f"\nCases where some single fact raises P(gold) (have key facts): "
          f"{sum(bool(v) for v in key.values())}/{len(key)}")
    print(f"\n### Baseline 3: gap identification ({run}, n={len(gap)})\n")
    print("| starting view | hidden-fact recall (5 questions) | key-fact recall | n with key facts |")
    print("|---|---|---|---|")
    cells: dict[str, dict[str, list[float]]] = defaultdict(lambda: defaultdict(list))
    for r in gap:
        for v in r["views"]:
            if v["hidden"]:
                cells[v["view"]]["h"].append(len(v["covered"]) / len(v["hidden"]))
            kk = key.get(r["case_id"], set()) & set(v["hidden"])
            if kk:
                cells[v["view"]]["k"].append(len(kk & set(v["covered"])) / len(kk))
    for view in ("prefix:0.0", "prefix:0.2", "prefix:0.4", "gaps:0.2", "gaps:0.4"):
        c = cells[view]
        print(f"| {view} | {mean(c['h'])} | {mean(c['k']) if c['k'] else 'n/a'} | {len(c['k'])} |")
    # Same yardstick for the asker: share of key facts its 5 questions actually obtained.
    got = [len(key[r["case_id"]] & {i for s in r["steps"] for i in s["answered_with"]}) / len(key[r["case_id"]])
           for r in ask if key.get(r["case_id"])]
    print(f"\nPrompted asking (5 questions) obtained {mean(got)} of key facts (same cases).")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--oneshot-run", default="mediq_open_v1")
    ap.add_argument("--baselines-run", default="baselines_v1")
    a = ap.parse_args()
    oneshot_tables(a.oneshot_run)
    asking_tables(a.baselines_run, a.oneshot_run)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
