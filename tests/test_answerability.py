"""Answerability model and answerable-informative policy (no LLM calls, no answer-key reads by the policy)."""

from __future__ import annotations

import json
from pathlib import Path

from smt_trial_matching import answerability as A
from smt_trial_matching.policies import (
    AnswerableConfig,
    answerable_informative,
    candidate_questions,
    score_question,
)
from smtstate import TrialState
from smtstate.runner import run_patient
from smtstate.sim import AnswerKeySimulator

ROOT = Path(__file__).resolve().parents[1]
DEMO_QID = "trec-202112"  # dev patient from the onboarding doc
SLEEP_TRIAL = "NCT01029561"  # gold ineligible; 3 cohorts


def _trials(qid: str) -> list[str]:
    return [p["nct"] for p in map(json.loads, (ROOT / "data/pairs.jsonl").open()) if p["qid"] == qid]


def test_parse_name_parts() -> None:
    p = A.parse("patient_has_diagnosis_of_asthma_inthepast6months@@severe")
    assert (p["kind"], p["timeframe"], p["qualifier"]) == ("diagnosis", "inthepast", "severe")
    assert A.parse("patient_age_value_recorded_now_in_years")["kind"] == "value"
    assert A.parse("patient_is_pregnant_now")["timeframe"] == "now"


def test_features_have_no_patient_or_variable_identity() -> None:
    f = A.features("patient_has_finding_of_cough_now@@productive", "Bool")
    assert f["has_qualifier"] == 1.0 and "q=productive" in f and "w=cough" in f
    assert not any("trec" in k or "NCT" in k for k in f)


def test_dev_model_never_sees_test_patients() -> None:
    test = set(A.load_split("test"))
    assert not {e.qid for e in A.load_examples(A.load_split("dev"))} & test


def test_crossfit_uses_other_folds_for_dev_patients() -> None:
    dev_qid = DEMO_QID
    assert A.model_for(_trials(dev_qid)) is A._fold_model(A.dev_fold(dev_qid), "gpt5_oracle")
    test_qid = min(A.load_split("test"))
    assert A.model_for(_trials(test_qid)) is A.fit_default("gpt5_oracle")


def test_probabilities_are_sensible() -> None:
    m = A.fit_default("gpt5_oracle")
    diag = m.p_answered("patient_has_diagnosis_of_asthma_now", "Bool")
    qualified = m.p_answered("patient_has_finding_of_x_now@@based_on_qualifying_echocardiography", "Bool")
    assert 0.0 < qualified < diag < 1.0


def test_candidates_include_cohort_knockouts_missed_by_informative() -> None:
    s = TrialState(SLEEP_TRIAL)
    informative = {v for v, _ in s.informative()}
    cands = set(candidate_questions(s))
    assert "patient_is_included_in_obesity_surgery_program_now" in cands - informative


def test_score_rewards_ruling_out_cohorts() -> None:
    s = TrialState(SLEEP_TRIAL)
    m = A.fit_default("gpt5_oracle")
    cfg = AnswerableConfig()
    assert score_question(s, "patient_is_included_in_obesity_surgery_program_now", m, cfg) > 0
    s.answers["patient_is_included_in_obesity_surgery_program_now"] = False
    s.answers["patient_is_included_in_obesity_surgery_program"] = False
    s.answers["patient_has_diagnosis_of_sleep_apnea_now"] = False
    assert s.status() == "ineligible" and candidate_questions(s) == []


def test_policy_fixes_the_demo_patient_and_never_repeats() -> None:
    ep = run_patient(DEMO_QID, _trials(DEMO_QID), answerable_informative, AnswerKeySimulator(), budget=30)
    asked = [(t["nct"], t["var"]) for t in ep["turns"]]
    assert len(asked) == len(set(asked)) == 30
    assert ep["final_verdicts"][SLEEP_TRIAL] == "ineligible"
