"""Ablation switches, the answerable-informative oracle, configs, replays and the criteria lookup."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from smt_trial_matching import answerability as A
from smt_trial_matching import metrics as M
from smt_trial_matching.experiment import load_config, parse_args
from smt_trial_matching.policies import (
    AnswerableConfig,
    AnswerableInformative,
    answerable_informative,
    answerable_informative_no_answerability,
    answerable_informative_no_value,
    answerable_informative_oracle,
    candidate_questions,
    score_question,
)
from smt_trial_matching.policy_loading import load_policy
from smt_trial_matching.replay import build_replay, criteria_line, format_replay
from smtstate import TrialState
from smtstate.runner import run_patient
from smtstate.sim import AnswerKeySimulator

ROOT = Path(__file__).resolve().parents[1]
FIXTURE = json.loads((ROOT / "tests" / "fixtures" / "answerable_informative_turns.json").read_text())
SLEEP_TRIAL = "NCT01029561"


def _trials(qid: str) -> list[str]:
    return [p["nct"] for p in map(json.loads, (ROOT / "data/pairs.jsonl").open()) if p["qid"] == qid]


def _asked(policy, qid: str, budget: int = 30) -> list[list[str]]:
    ep = run_patient(qid, _trials(qid), policy, AnswerKeySimulator(), budget=budget)
    return [[t["nct"], t["var"]] for t in ep["turns"]]


# ------------------------------------------------------------------ ablation switches


@pytest.mark.parametrize("qid", sorted(FIXTURE["turns"]))
def test_defaults_reproduce_the_policy_before_the_switches(qid: str) -> None:
    # Fixture: answerable_informative's choices at origin/main e6e5b1c, before this change.
    assert _asked(answerable_informative, qid) == FIXTURE["turns"][qid]
    assert _asked(AnswerableInformative(AnswerableConfig()), qid) == FIXTURE["turns"][qid]


def test_no_answerability_scores_value_alone() -> None:
    s, m = TrialState(SLEEP_TRIAL), A.fit_default("gpt5_oracle")
    on, off = AnswerableConfig(), AnswerableConfig(use_answerability=False)
    for v in candidate_questions(s):
        p = m.p_answered(v, s.types[v])
        assert score_question(s, v, m, off) == pytest.approx(score_question(s, v, m, on) / p)


def test_no_value_scores_answerability_alone() -> None:
    s, m = TrialState(SLEEP_TRIAL), A.fit_default("gpt5_oracle")
    cfg = AnswerableConfig(use_value=False)
    seen = set()
    for v in candidate_questions(s):
        p = m.p_answered(v, s.types[v])
        score = score_question(s, v, m, cfg)
        assert score == pytest.approx(p) or score == 0.0
        seen.add(score > 0)
        if score_question(s, v, m, AnswerableConfig()) > 0:  # anything with value is "informative"
            assert score == pytest.approx(p)
    assert True in seen


def test_ablations_change_choices_and_are_loadable() -> None:
    qid = "trec-202112"
    base = FIXTURE["turns"][qid]
    assert _asked(answerable_informative_no_answerability, qid) != base
    assert _asked(answerable_informative_no_value, qid) != base
    for name in ("answerable_informative_no_answerability", "answerable_informative_no_value"):
        assert load_policy(f"smt_trial_matching.policies:{name}") is not None


def test_informative_oracle_asks_only_answered_questions() -> None:
    with pytest.raises(RuntimeError, match="answer key"):
        answerable_informative_oracle({}, set(), None)
    qid, sim = "trec-202112", AnswerKeySimulator()
    pol = answerable_informative_oracle.for_patient(qid, sim)
    ep = run_patient(qid, _trials(qid), pol, sim, budget=30)
    assert ep["turns"] and all(t["answer"] is not None for t in ep["turns"])
    assert pol.last_score is not None or len(ep["turns"]) < 30


# ------------------------------------------------------------------ configs


def test_config_files_parse_and_cli_overrides(tmp_path: Path) -> None:
    a = parse_args(["--config", "configs/main_dev.yaml"])
    assert a.run_id == "main_dev" and a.split == "dev" and a.keys == ["gpt5_oracle", "gpt5mini"]
    assert "smt_trial_matching.policies:answerable_informative_oracle" in a.policies.split(",")
    a = parse_args(["--config", "configs/ablations_dev.yaml", "--run-id", "x", "--keys", "gpt5mini"])
    assert (a.run_id, a.keys) == ("x", ["gpt5mini"])
    assert a.reference == "smt_trial_matching.policies:answerable_informative"
    for spec in a.policies.split(","):
        load_policy(spec)
    for name in ("main_test", "ablations_test"):
        with pytest.raises(SystemExit):  # test split still needs --confirmed on the command line
            parse_args(["--config", f"configs/{name}.yaml"])
    bad = tmp_path / "bad.yaml"
    bad.write_text("run_id: x\npolicies: [greedy_smt]\nconfirmed: true\n")
    with pytest.raises(SystemExit, match="unknown fields"):
        load_config(str(bad))


# ------------------------------------------------------------------ replays and criteria lookup


def test_replay_tracks_statuses_and_prints() -> None:
    qid = "trec-202112"
    ep = run_patient(qid, _trials(qid), answerable_informative, AnswerKeySimulator(), budget=30)
    rp = build_replay(ep, "answerable_informative", "gpt5_oracle", M.load_gold())
    assert len(rp["turns"]) == len(ep["turns"])
    assert {n: t["status"] for n, t in rp["final"].items()} == ep["final_status"]
    assert {n: t["verdict"] for n, t in rp["final"].items()} == ep["final_verdicts"]
    assert rp["trials"][SLEEP_TRIAL]["gold"] == "ineligible"
    assert [t["label"] for t in rp["turns"]] == [M.label(t) for t in ep["turns"]]
    text = format_replay(rp)
    assert "Turn  1" in text and "Final (" in text


def test_criteria_line_finds_the_mentioning_line() -> None:
    hit = criteria_line(SLEEP_TRIAL, "patient_age_value_recorded_now_in_years", "age in years")
    assert hit is not None and "18" in hit[1] and "65" in hit[1]
    assert criteria_line(SLEEP_TRIAL, "patient_has_finding_of_zzzz_now") is None
