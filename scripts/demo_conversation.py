"""Step through one patient's conversation, turn by turn (solver only, no LLM).

Two modes:

  # live: run a policy on one patient now
  uv run python scripts/demo_conversation.py --qid trec-202112 \
      --policy smt_trial_matching.policies:answerable_informative

  # replay: print a replay the harness wrote (runs/<run_id>/<key>/replays/<policy>/<qid>.json)
  uv run python scripts/demo_conversation.py --replay runs/main_dev/gpt5_oracle/replays/answerable_informative/trec-202112.json

Both print the same view: the patient note, each trial's starting status and gold label, then per
turn the question, the policy's score (if it reports one), the answer, whether the question was
useful, and any trial whose status changed. ``--json PATH`` also saves the live replay.
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path[:0] = [str(ROOT), str(ROOT / "src")]

from smt_trial_matching import metrics as M
from smt_trial_matching.policy_loading import load_policy, policy_label
from smt_trial_matching.replay import build_replay, format_replay


def live(qid: str, spec: str, key: str, budget: int) -> dict:
    from smtstate.runner import run_patient
    from smtstate.sim import AnswerKeySimulator

    ncts = [p["nct"] for p in map(json.loads, (ROOT / "data" / "pairs.jsonl").open()) if p["qid"] == qid]
    if not ncts:
        raise SystemExit(f"unknown patient {qid!r}")
    sim = AnswerKeySimulator(key)
    policy = load_policy(spec)
    bind = getattr(policy, "for_patient", None)
    chosen = bind(qid, sim) if bind else policy
    scores: list[float | None] = []

    def recording(states: dict, asked: set, rng) -> tuple[str, str] | None:
        q = chosen(states, asked, rng)
        if q is not None:
            scores.append(getattr(chosen, "last_score", None))
        return q

    ep = run_patient(qid, ncts, recording, sim, budget=budget)
    return build_replay(ep, policy_label(spec), key, M.load_gold(), scores)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--replay", help="a replay JSON written by the harness")
    ap.add_argument("--qid", default="trec-202112", help="live mode: patient id")
    ap.add_argument("--policy", default="smt_trial_matching.policies:answerable_informative",
                    help="live mode: CA name or module.path:function")
    ap.add_argument("--key", default="gpt5_oracle", help="live mode: answer key")
    ap.add_argument("--budget", type=int, default=30)
    ap.add_argument("--json", help="live mode: also save the replay here")
    ap.add_argument("--note-chars", type=int, default=600, help="how much of the patient note to show")
    a = ap.parse_args(argv)
    if a.replay:
        rp = json.loads(Path(a.replay).read_text())
    else:
        rp = live(a.qid, a.policy, a.key, a.budget)
        if a.json:
            Path(a.json).write_text(json.dumps(rp, indent=1) + "\n")
    print(format_replay(rp, a.note_chars))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
