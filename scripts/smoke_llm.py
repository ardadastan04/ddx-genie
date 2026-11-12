"""T1 smoke test: one short prompt on CHEAP_MODEL, printing reply, tokens and cost.

    uv run python scripts/smoke_llm.py

Costs a small fraction of a cent. Writes to runs/smoke/cost.jsonl. Pass --no-cache
to force a real call when a cached reply already exists.
"""

from __future__ import annotations

import argparse
import sys

from ddx_genie.llm import (
    BudgetExceeded,
    ConfigError,
    DiskCache,
    LLMClient,
    resolve_model,
)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--no-cache", action="store_true", help="bypass the disk cache")
    parser.add_argument("--run-id", default="smoke")
    parser.add_argument("--prompt", default="Reply with exactly: ok")
    args = parser.parse_args()

    try:
        client = LLMClient(args.run_id, cache=DiskCache(enabled=not args.no_cache))
        print(f"backend  : {client.credentials.backend}")
        print(f"base_url : {client.credentials.base_url}")
        print(f"model    : {resolve_model('cheap')}")

        result = client.complete(
            [{"role": "user", "content": args.prompt}],
            model="cheap",
            tag="smoke",
            max_tokens=32,
            use_cache=not args.no_cache,
        )
    except ConfigError as exc:
        print(f"\nCONFIG ERROR: {exc}", file=sys.stderr)
        return 2
    except BudgetExceeded as exc:
        print(f"\nBUDGET: {exc}", file=sys.stderr)
        return 3

    print(f"\nreply    : {result.text.strip()!r}")
    print(
        f"tokens   : {result.prompt_tokens} in / {result.completion_tokens} out"
        f"{' (cached)' if result.cached else ''}"
    )
    print(f"cost     : ${result.usd:.6f}")
    print(f"latency  : {result.latency_s:.2f}s")
    print(f"ledger   : {client.summary()}")
    print(f"           {client.cost_log.path}")

    if not result.text.strip():
        print("\nFAIL: empty reply", file=sys.stderr)
        return 1
    if result.usd > 0.01:
        print(f"\nFAIL: ${result.usd:.6f} exceeds the $0.01 smoke-test bar", file=sys.stderr)
        return 1
    print("\nPASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
