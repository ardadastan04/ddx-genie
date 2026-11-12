"""Tests for differential parsing. No network: the LLM's text is the input here.

The model returns free text, so the parser must survive fences, prose, bad names and
unnormalised probabilities without ever inventing a condition outside the study set.
"""

from __future__ import annotations

import pytest

from ddx_genie.diagnosis import (
    Differential,
    _parse_differential,
    format_findings,
)

CONDS = ("Pneumonia", "Influenza", "Bronchitis", "URTI",
         "Acute COPD exacerbation / infection",
         "Bronchospasm / acute asthma exacerbation")


def parse(text: str):
    return _parse_differential(text, CONDS)


class TestParseDifferential:
    def test_plain_json(self) -> None:
        out = parse('{"differential":[{"condition":"Pneumonia","probability":0.6},'
                    '{"condition":"Bronchitis","probability":0.4}]}')
        assert out == [("Pneumonia", 0.6), ("Bronchitis", 0.4)]

    def test_fenced_json(self) -> None:
        out = parse('```json\n{"differential":[{"condition":"URTI","probability":1.0}]}\n```')
        assert out == [("URTI", 1.0)]

    def test_prose_around_json(self) -> None:
        out = parse('Here you go:\n{"differential":[{"condition":"Influenza",'
                    '"probability":1.0}]}\nHope that helps!')
        assert out == [("Influenza", 1.0)]

    def test_probabilities_are_normalised(self) -> None:
        out = parse('{"differential":[{"condition":"Pneumonia","probability":30},'
                    '{"condition":"URTI","probability":10}]}')
        assert out == [("Pneumonia", 0.75), ("URTI", 0.25)]

    def test_case_insensitive_names(self) -> None:
        assert parse('{"differential":[{"condition":"pneumonia","probability":1}]}') == [
            ("Pneumonia", 1.0)
        ]

    def test_conditions_outside_the_set_are_dropped(self) -> None:
        out = parse('{"differential":[{"condition":"Tuberculosis","probability":0.5},'
                    '{"condition":"Pneumonia","probability":0.5}]}')
        # Never invent a diagnosis the study did not sample.
        assert out == [("Pneumonia", 1.0)]

    def test_duplicates_are_dropped(self) -> None:
        out = parse('{"differential":[{"condition":"URTI","probability":0.5},'
                    '{"condition":"URTI","probability":0.5}]}')
        assert out == [("URTI", 1.0)]

    def test_truncated_to_top_k(self) -> None:
        entries = ",".join(
            f'{{"condition":"{c}","probability":1}}' for c in CONDS
        )
        assert len(parse(f'{{"differential":[{entries}]}}')) == 5

    def test_long_name_prefix_match(self) -> None:
        out = parse('{"differential":[{"condition":"Acute COPD exacerbation",'
                    '"probability":1}]}')
        assert out == [("Acute COPD exacerbation / infection", 1.0)]

    def test_bare_list_without_wrapper(self) -> None:
        assert parse('[{"condition":"URTI","probability":1}]') == [("URTI", 1.0)]

    @pytest.mark.parametrize("text", ["", "not json at all", "{}", "{'bad': quotes}",
                                      '{"differential": "not a list"}',
                                      '{"differential":[1,2,3]}'])
    def test_unparseable_yields_empty(self, text: str) -> None:
        assert parse(text) == []

    def test_non_numeric_probability_becomes_zero(self) -> None:
        out = parse('{"differential":[{"condition":"URTI","probability":"high"},'
                    '{"condition":"Pneumonia","probability":1}]}')
        assert out == [("URTI", 0.0), ("Pneumonia", 1.0)]


class TestDifferential:
    def test_accessors(self) -> None:
        d = Differential(ranked=[("Pneumonia", 0.5), ("URTI", 0.3), ("Influenza", 0.2)],
                         raw="")
        assert d.top1 == "Pneumonia"
        assert d.top3 == ["Pneumonia", "URTI", "Influenza"]
        assert d.as_json()[0] == {"condition": "Pneumonia", "probability": 0.5}

    def test_empty_is_safe(self) -> None:
        d = Differential(ranked=[], raw="garbage")
        assert d.top1 is None
        assert d.top3 == []
        assert "no differential" in str(d)


class TestFormatFindings:
    def test_empty(self) -> None:
        assert format_findings({}) == "No findings were collected."

    def test_all_none_is_empty(self) -> None:
        # Unasked fields must not read as negative findings.
        assert format_findings({"cough": None}) == "No findings were collected."

    def test_false_is_kept(self) -> None:
        # A denial is a finding and must reach the diagnosis.
        assert "cough: False" in format_findings({"cough": False})

    def test_unasked_fields_are_omitted(self) -> None:
        out = format_findings({"cough": True, "fever": None})
        assert "cough" in out and "fever" not in out
