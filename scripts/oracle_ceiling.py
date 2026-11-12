"""Measure the diagnosis step's ceiling: accuracy given perfect evidence.

    uv run python scripts/oracle_ceiling.py

One cached LLM call per patient. The result bounds what any interview can achieve,
so it belongs in the paper alongside both systems' top-1 accuracy.
"""

from __future__ import annotations

import argparse
import json

from ddx_genie.failure import oracle_ceiling
from ddx_genie.llm import RUNS_DIR, LLMClient


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--run-id", default="oracle")
    parser.add_argument("--limit", type=int, default=None)
    args = parser.parse_args()

    client = LLMClient(args.run_id)
    stats = oracle_ceiling(client, limit=args.limit)

    print(f"oracle ceiling over {stats['n']} patients "
          f"(diagnosis step given the complete true evidence)\n")
    print(f"  top-1 accuracy : {stats['top1_accuracy']:.3f}")
    print(f"  top-3 accuracy : {stats['top3_accuracy']:.3f}\n")
    print(f"  {'condition':<44}{'n':>4}{'top-1':>8}")
    for condition, s in stats["per_condition"].items():
        print(f"  {condition[:44]:<44}{s['n']:>4}{s['top1']:>8.2f}")
    if stats["confusions"]:
        print("\n  what it confuses, given perfect evidence:")
        for true, preds in stats["confusions"].items():
            for pred, n in sorted(preds.items(), key=lambda kv: -kv[1]):
                print(f"    {true[:34]:<34} -> {pred[:34]:<34} x{n}")
    out = RUNS_DIR / args.run_id / "oracle_ceiling.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(stats, indent=2) + "\n")
    print(f"\n{client.summary()}\nwrote {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
