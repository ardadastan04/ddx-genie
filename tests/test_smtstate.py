"""Regression checks on the CA's SMT state library and baselines (no LLM calls)."""

from __future__ import annotations

import json
import sys
from pathlib import Path

from smtstate import TrialState
from smtstate.runner import run_patient
from smtstate.sim import AnswerKeySimulator

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "baselines"))
from policies import greedy_smt  # noqa: E402


def _reference(name: str) -> dict[str, dict]:
    path = ROOT / "logs" / "reference" / f"{name}_gpt5_oracle.jsonl"
    return {e["qid"]: e for e in map(json.loads, path.open())}


def test_empty_state_is_undetermined_and_has_questions() -> None:
    ep = next(iter(_reference("greedy_smt").values()))
    s = TrialState(ep["trials"][0])
    assert s.status() == "undetermined"
    assert s.informative()
    assert s.verdict() == "eligible"  # undetermined counts as eligible


def test_greedy_smt_reproduces_reference_log() -> None:
    ref = _reference("greedy_smt")
    qid = sorted(ref)[0]
    ep = run_patient(qid, ref[qid]["trials"], greedy_smt, AnswerKeySimulator(), budget=30)
    assert [(t["nct"], t["var"]) for t in ep["turns"]] == [
        (t["nct"], t["var"]) for t in ref[qid]["turns"]]
    assert ep["final_verdicts"] == ref[qid]["final_verdicts"]
