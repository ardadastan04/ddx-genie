"""Tests for patient-card decoding. The invariants here protect the simulator."""

from __future__ import annotations

import pytest

from ddx_genie.cards import (
    Finding,
    PatientCard,
    answer_text,
    assert_no_codes,
    build_card,
    _pick_chief_complaint,
)

BINARY = {"question_en": "Do you have a cough?", "data_type": "B",
          "possible-values": [], "value_meaning": {}, "code_question": "E_201",
          "is_antecedent": False}
SCALE = {"question_en": "How intense is the pain?", "data_type": "C",
         "possible-values": list(range(11)), "value_meaning": {}, "code_question": "E_56",
         "is_antecedent": False}
YESNO = {"question_en": "Do your lesions peel off?", "data_type": "C",
         "possible-values": ["V_10", "V_12"],
         "value_meaning": {"V_10": {"en": "N"}, "V_12": {"en": "Y"}},
         "code_question": "E_129", "is_antecedent": False}
SKIN = {"question_en": "Do you have skin lesions?", "data_type": "B",
        "possible-values": [], "value_meaning": {}, "code_question": "E_129",
        "is_antecedent": False}
HISTORY = {"question_en": "Do you smoke cigarettes?", "data_type": "B",
           "possible-values": [], "value_meaning": {}, "code_question": "E_21",
           "is_antecedent": True}


class TestAnswerText:
    def test_bare_binary_is_yes(self) -> None:
        assert answer_text(BINARY, None) == "yes"

    def test_scale_is_out_of_max(self) -> None:
        assert answer_text(SCALE, "6") == "6 out of 10"

    def test_bare_y_n_becomes_speech(self) -> None:
        # "Y"/"N" read as codes, not as something a patient would say.
        assert answer_text(YESNO, "V_12") == "yes"
        assert answer_text(YESNO, "V_10") == "no"


class TestChiefComplaint:
    def _finding(self, code: str, *, chief: bool, antecedent: bool = False) -> Finding:
        return Finding(code=code, question="q?", answer="yes",
                       is_antecedent=antecedent, is_chief_complaint=chief)

    def test_prefers_the_initial_evidence(self) -> None:
        findings = [self._finding("E_91", chief=False), self._finding("E_201", chief=True)]
        picked = _pick_chief_complaint(findings, {"E_91": BINARY, "E_201": BINARY})
        assert picked is not None and picked.code == "E_201"

    def test_falls_back_when_initial_is_excluded(self) -> None:
        # E_129 is in the excluded skin group: the patient would open with something
        # neither system has a field to record.
        findings = [self._finding("E_129", chief=True), self._finding("E_201", chief=False)]
        picked = _pick_chief_complaint(findings, {"E_129": SKIN, "E_201": BINARY})
        assert picked is not None and picked.code == "E_201"

    def test_fallback_skips_antecedents(self) -> None:
        findings = [self._finding("E_129", chief=True),
                    self._finding("E_21", chief=False, antecedent=True),
                    self._finding("E_201", chief=False)]
        picked = _pick_chief_complaint(findings, {"E_129": SKIN, "E_21": HISTORY, "E_201": BINARY})
        assert picked is not None and picked.code == "E_201"

    def test_no_findings_returns_none(self) -> None:
        assert _pick_chief_complaint([], {}) is None


class TestBuildCard:
    def _record(self) -> dict:
        return {"row_index": 7, "pathology": "Pneumonia", "age": 40, "sex": "F",
                "initial_evidence": "E_201",
                "evidences": [{"code": "E_201", "value": None},
                              {"code": "E_56", "value": "6"},
                              {"code": "E_21", "value": None}],
                "differential": [{"pathology": "Pneumonia", "probability": 0.8}]}

    def test_splits_symptoms_from_history(self) -> None:
        card = build_card(self._record(), {"E_201": BINARY, "E_56": SCALE, "E_21": HISTORY})
        block = card.prompt_block()
        assert "Your medical history and background:" in block
        assert block.index("Do you have a cough?") < block.index("Do you smoke cigarettes?")

    def test_prompt_block_hides_the_answer(self) -> None:
        card = build_card(self._record(), {"E_201": BINARY, "E_56": SCALE, "E_21": HISTORY})
        # The simulator must never see the diagnosis it is meant to be diagnosed with.
        assert "Pneumonia" not in card.prompt_block()
        assert "Pneumonia" in card.human_text()

    def test_multiple_values_are_joined(self) -> None:
        record = self._record()
        record["evidences"] = [{"code": "E_201", "value": None},
                               {"code": "E_56", "value": "6"},
                               {"code": "E_56", "value": "8"}]
        card = build_card(record, {"E_201": BINARY, "E_56": SCALE})
        answers = {f.code: f.answer for f in card.findings}
        assert answers["E_56"] == "6 out of 10, 8 out of 10"

    def test_nowhere_is_dropped_when_a_real_value_exists(self) -> None:
        loc = {"question_en": "Where?", "data_type": "M", "possible-values": ["V_1", "V_123"],
               "value_meaning": {"V_1": {"en": "upper chest"}, "V_123": {"en": "nowhere"}},
               "code_question": "E_53", "is_antecedent": False}
        record = self._record()
        record["evidences"] = [{"code": "E_55", "value": "V_123"},
                               {"code": "E_55", "value": "V_1"}]
        record["initial_evidence"] = "E_55"
        card = build_card(record, {"E_55": loc})
        assert card.findings[0].answer == "upper chest"


class TestNoCodeLeakage:
    def test_clean_card_passes(self) -> None:
        card = PatientCard(row_index=1, age=30, sex="M", chief_complaint="a cough",
                           findings=[Finding("E_201", "Do you have a cough?", "yes", False, True)],
                           pathology="URTI", differential=[])
        assert_no_codes([card])

    def test_leaked_code_raises(self) -> None:
        card = PatientCard(row_index=1, age=30, sex="M", chief_complaint="E_201 positive",
                           findings=[Finding("E_201", "Do you have V_12?", "yes", False, True)],
                           pathology="URTI", differential=[])
        with pytest.raises(AssertionError, match="leaks raw codes"):
            assert_no_codes([card])
