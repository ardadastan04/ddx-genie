"""Cohort-level usefulness label and answerability diagnostics (no LLM calls)."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from smt_trial_matching import diagnostics as D
from smt_trial_matching import metrics as M
from smt_trial_matching.replay import cohort_useful, cohort_useful_flags
from smtstate import TrialState

ROOT = Path(__file__).resolve().parents[1]
FIXTURE = json.loads((ROOT / "tests" / "fixtures" / "answerable_informative_turns.json").read_text())
SLEEP_TRIAL = "NCT01029561"  # 3 cohorts
KNOCKOUT = "patient_is_included_in_obesity_surgery_program_now"  # rules out one cohort only


def _trials(qid: str) -> list[str]:
    return [p["nct"] for p in map(json.loads, (ROOT / "data/pairs.jsonl").open()) if p["qid"] == qid]


def test_cohort_knockout_is_useful_under_our_rule_only() -> None:
    s = TrialState(SLEEP_TRIAL)
    assert KNOCKOUT not in {v for v, _ in s.informative()}  # CA: not informative
    assert cohort_useful(s, KNOCKOUT)  # ours: it can rule out a cohort


def test_cohort_rule_is_a_superset_of_the_ca_rule() -> None:
    log = ROOT / "logs" / "reference" / "random_stop_gpt5_oracle.jsonl"
    dev = set(M.load_split("dev"))
    eps = [e for e in M.load_log(log) if e["qid"] in dev][:4]
    n_extra = 0
    for ep in eps:
        for t, flag in zip(ep["turns"], cohort_useful_flags(ep)):
            assert flag or not t["informative"]
            n_extra += flag and not t["informative"]
    assert sum(len(e["turns"]) for e in eps) > 0


def test_cohort_label_counts() -> None:
    t = {"answer": None, "informative": False, "useful_cohort": True}
    assert M.label(t) == "not_useful" and M.label(t, cohort=True) == "useful_unanswered"
    assert M.label({"answer": True, "informative": True}, cohort=True) == "not_useful"  # flag missing
    ep = {"qid": "p", "trials": ["A"], "initial_verdicts": {"A": "eligible"},
          "turns": [{**t, "nct": "A", "var": "v", "verdicts": {"A": "eligible"}}],
          "final_verdicts": {"A": "eligible"}}
    pt = M.point(M.build_table([ep], {("p", "A"): True}, budget=1))
    assert pt["share_not_useful"][1] == 1.0 and pt["share_cohort_useful_unanswered"][1] == 1.0


def test_trace_follows_answerable_informative_and_scores_three_ways() -> None:
    qid = "trec-202112"
    tr = D.trace_patient((qid, _trials(qid), "gpt5_oracle", 30, "pred"))
    assert [list(q) for q in tr["asked"]] == FIXTURE["turns"][qid]  # same conversation as the policy
    for t in tr["turns"]:
        assert t["oracle_answered"] or t["n_answerable"] == 0
        assert t["pred_answered"] == t["chosen_answered"]
        assert t["oracle_realized"] >= t["pred_realized"] - 1e-12  # oracle picks the best answered value
    orc = D.trace_patient((qid, _trials(qid), "gpt5_oracle", 30, "oracle"))
    assert all(t["chosen_answered"] for t in orc["turns"])


def test_calibration_and_scores_on_toy_rows() -> None:
    rows = [{"p": 0.05, "answered": False}, {"p": 0.05, "answered": False},
            {"p": 0.95, "answered": True}, {"p": 0.95, "answered": False}]
    cal = D.calibration(rows)
    assert [(c["bin"], c["n"], c["observed"]) for c in cal] == [("0.0–0.1", 2, 0.0), ("0.9–1.0", 2, 0.5)]
    s = D.scores(rows)
    # 1 positive (0.95) vs 3 negatives (0.05, 0.05, 0.95): wins 2, ties 1 -> 2.5 / 3
    assert s["auc"] == pytest.approx(2.5 / 3) and s["ece"] == pytest.approx((2 * 0.05 + 2 * 0.45) / 4)
