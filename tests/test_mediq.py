"""Tests for MediQ parsing and the diagnosis-question filter. No raw data needed."""

from __future__ import annotations

import pytest

from ddx_genie.mediq import (
    DataError,
    answer_leaks,
    clean_fact,
    is_diagnosis_question,
    parse_record,
    sample,
)

RAW = {
    "id": 7,
    "question": "What is the most likely diagnosis?",
    "context": ["A 59-year-old man presents.", "He feels down."],
    "options": {"A": "Bipolar disorder", "B": "Dysthymia"},
    "answer": "Dysthymia",
    "answer_idx": "B",
    "facts": ["1. A 59-year-old man presents.", "2. He feels down.", "10. Labs normal."],
    "patient": {"age": "59", "gender": "Male", "gpt_specialty": "Psychiatry"},
}


@pytest.mark.parametrize("stem", [
    "Which of the following is the most likely diagnosis?",
    "What is the most likely diagnosis in this patient?",
    "Which of the following is most likely the diagnosis?",
    "Which of the following is the most likely underlying diagnosis?",
    "What is the diagnosis in this patient?",
])
def test_diagnosis_stems_kept(stem: str) -> None:
    assert is_diagnosis_question(stem)


@pytest.mark.parametrize("stem", [
    "Which of the following is the most appropriate next step in diagnosis?",
    "Which of the following is most likely to confirm the diagnosis?",
    "Which of the following is associated with the most likely diagnosis?",
    "Which of the following is the most significant risk factor for this patient’s most likely diagnosis?",
    "What is the most likely etiology of this patient’s diagnosis?",
    "Which of the following tests is most likely to yield an accurate diagnosis?",
    "WBC 2,500/mm3 | Platelets 95,000/mm3 | What is the most likely diagnosis?",
    "Which of the following was given?",
])
def test_adjacent_or_leaky_stems_dropped(stem: str) -> None:
    assert not is_diagnosis_question(stem)


def test_clean_fact_strips_numbering_only() -> None:
    assert clean_fact("12. BP is 120/80 mm Hg.") == "BP is 120/80 mm Hg."
    assert clean_fact("He is 5.5 feet tall.") == "He is 5.5 feet tall."


def test_parse_record_keeps_fact_order() -> None:
    case = parse_record(RAW, "all_dev_good.jsonl")
    assert case.case_id == "mediq-all_dev_good-7"
    assert case.facts == ["A 59-year-old man presents.", "He feels down.", "Labs normal."]
    assert case.sex == "Male" and case.specialty == "Psychiatry"


def test_parse_record_rejects_mismatched_answer() -> None:
    with pytest.raises(DataError):
        parse_record(RAW | {"answer_idx": "A"}, "x.jsonl")


def test_answer_leak_detected() -> None:
    assert answer_leaks(["History of dysthymia."], "Dysthymia")
    assert not answer_leaks(["He feels down."], "Dysthymia")


def test_sample_is_deterministic_and_sorted() -> None:
    cases = [parse_record(RAW | {"id": i}, "x.jsonl") for i in range(30)]
    a, b = sample(cases, n=10, seed=0), sample(list(reversed(cases)), n=10, seed=0)
    assert [c.source_id for c in a] == [c.source_id for c in b]
    assert [c.source_id for c in a] == sorted(c.source_id for c in a)
    with pytest.raises(DataError):
        sample(cases, n=31)
