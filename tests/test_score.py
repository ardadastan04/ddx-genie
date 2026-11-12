"""Scoring tests on a hand-made example, so the metrics can be checked by hand.

The numbers here are small enough to verify on paper, which is the point: a scoring
bug produces plausible-looking results that silently misstate the study's finding.
"""

from __future__ import annotations

import json

import pytest

from ddx_genie.score import (
    FieldMap,
    aggregate,
    jaccard,
    positive_fields,
    score_patient,
    score_run,
)

PLAN = {
    "observed_evidence_codes": ["E_53", "E_55", "E_91", "E_201", "E_129", "E_57"],
    "fields": [
        {"name": "pain_present", "evidence_code": "E_53", "region": None,
         "kind": "bool", "description": "", "enum_values": [], "parent_field": None},
        {"name": "fever", "evidence_code": "E_91", "region": None,
         "kind": "bool", "description": "", "enum_values": [], "parent_field": None},
        {"name": "cough", "evidence_code": "E_201", "region": None,
         "kind": "bool", "description": "", "enum_values": [], "parent_field": None},
        {"name": "pain_chest", "evidence_code": "E_55", "region": "chest",
         "kind": "bool", "description": "", "enum_values": [], "parent_field": None},
        {"name": "pain_back", "evidence_code": "E_55", "region": "back",
         "kind": "bool", "description": "", "enum_values": [], "parent_field": None},
        {"name": "differential", "evidence_code": "", "region": None,
         "kind": "str", "description": "", "enum_values": [], "parent_field": None},
    ],
}


@pytest.fixture
def field_map(tmp_path):
    path = tmp_path / "field_list.json"
    path.write_text(json.dumps(PLAN))
    return FieldMap.load(path)


class TestFieldMap:
    def test_unrepresentable_codes_are_identified(self, field_map) -> None:
        # E_129 (skin group) and E_57 (single-value multi-select) have no field.
        assert field_map.unrepresentable == {"E_129", "E_57"}

    def test_differential_is_not_a_scored_field(self, field_map) -> None:
        assert "differential" not in field_map.field_to_code

    def test_binary_truth(self, field_map) -> None:
        truth = field_map.truth_fields([{"code": "E_201", "value": None}])
        assert truth == {"cough"}

    def test_multiselect_collapses_through_regions(self, field_map) -> None:
        # V_29 decodes to "lower chest" -> region "chest" -> field pain_chest.
        truth = field_map.truth_fields([{"code": "E_55", "value": "V_29"}])
        assert truth == {"pain_chest"}

    def test_unrepresentable_evidence_is_excluded_from_truth(self, field_map) -> None:
        # Counting it would penalise both systems for the spec's scope.
        assert field_map.truth_fields([{"code": "E_129", "value": None}]) == set()

    def test_unknown_code_is_ignored(self, field_map) -> None:
        assert field_map.truth_fields([{"code": "E_999", "value": None}]) == set()


class TestPositiveFields:
    def test_true_counts(self) -> None:
        assert positive_fields({"cough": True}) == {"cough"}

    def test_false_is_a_denial_not_a_positive(self) -> None:
        assert positive_fields({"cough": False}) == set()

    def test_none_is_unasked(self) -> None:
        assert positive_fields({"cough": None}) == set()

    def test_zero_on_a_scale_is_a_real_answer(self) -> None:
        # 0/10 pain is an answer, not an absence of one.
        assert positive_fields({"pain_intensity": 0}) == {"pain_intensity"}

    def test_enum_text_counts(self) -> None:
        assert positive_fields({"pain_character": "sharp"}) == {"pain_character"}


def _result(**overrides):
    base = {
        "row_index": 1,
        "pathology": "Pneumonia",
        "system": "genie",
        "turns": 10,
        "findings": {"cough": True, "fever": True, "pain_present": False},
        "true_evidences": [
            {"code": "E_201", "value": None},   # cough     -> captured, hit
            {"code": "E_91", "value": None},    # fever     -> captured, hit
            {"code": "E_55", "value": "V_29"},  # lower chest -> pain_chest, missed
            {"code": "E_129", "value": None},   # excluded from the denominator
        ],
        "differential": [
            {"condition": "Pneumonia", "probability": 0.6},
            {"condition": "Bronchitis", "probability": 0.4},
        ],
        "true_differential": [
            {"pathology": "Pneumonia", "probability": 0.5},
            {"pathology": "Chagas", "probability": 0.3},      # outside the 6
            {"pathology": "Bronchitis", "probability": 0.2},
        ],
        "fills_per_turn": [1, 2, 1],
        "usd": 0.01,
    }
    base.update(overrides)
    return base


class TestScorePatient:
    def test_recall_denominator_excludes_unrepresentable(self, field_map) -> None:
        s = score_patient(_result(), field_map)
        # truth = {cough, fever, pain_chest}; E_129 excluded -> 3, not 4
        assert s.truth == 3
        assert s.true_positives == 2
        assert s.recall == pytest.approx(2 / 3)

    def test_precision_over_captured_positives(self, field_map) -> None:
        s = score_patient(_result(), field_map)
        # captured positives = {cough, fever}; pain_present=False is a denial
        assert s.captured == 2
        assert s.precision == pytest.approx(1.0)

    def test_false_positive_lowers_precision(self, field_map) -> None:
        s = score_patient(
            _result(findings={"cough": True, "pain_back": True}), field_map
        )
        # pain_back was never true for this patient
        assert s.precision == pytest.approx(0.5)

    def test_denials_are_counted(self, field_map) -> None:
        s = score_patient(_result(), field_map)
        assert s.denials == 1
        assert s.correct_denials == 1  # patient genuinely has no pain_present

    def test_top1_and_top3(self, field_map) -> None:
        s = score_patient(_result(), field_map)
        assert s.top1_correct is True
        assert s.top3_correct is True

    def test_wrong_top1(self, field_map) -> None:
        s = score_patient(
            _result(differential=[{"condition": "URTI", "probability": 1.0}]),
            field_map,
        )
        assert s.top1_correct is False
        assert s.top3_correct is False

    def test_differential_overlap_filters_out_of_set_truth(self, field_map) -> None:
        s = score_patient(_result(), field_map)
        # truth filtered to the 6 = {Pneumonia, Bronchitis}; predicted the same two.
        # Unfiltered, Chagas would cap this below 1.0 by construction.
        assert s.differential_overlap == pytest.approx(1.0)

    def test_volunteered_counts_extra_fills(self, field_map) -> None:
        s = score_patient(_result(), field_map)
        assert s.volunteered == 1  # fills_per_turn [1,2,1] -> one extra

    def test_empty_findings_yield_zero_recall_and_no_precision(self, field_map) -> None:
        s = score_patient(_result(findings={}), field_map)
        assert s.recall == 0.0
        assert s.precision is None  # nothing captured: precision is undefined

    def test_error_is_carried_through(self, field_map) -> None:
        s = score_patient(_result(error="boom"), field_map)
        assert s.error == "boom"


class TestJaccard:
    def test_identical(self) -> None:
        assert jaccard({"a"}, {"a"}) == 1.0

    def test_disjoint(self) -> None:
        assert jaccard({"a"}, {"b"}) == 0.0

    def test_partial(self) -> None:
        assert jaccard({"a", "b"}, {"b", "c"}) == pytest.approx(1 / 3)

    def test_both_empty_is_undefined(self) -> None:
        assert jaccard(set(), set()) is None


class TestAggregate:
    def test_empty(self) -> None:
        assert aggregate([]) == {}

    def test_skips_none_without_counting_it_as_zero(self, field_map) -> None:
        a = score_patient(_result(), field_map)
        b = score_patient(_result(findings={}), field_map)
        stats = aggregate([a, b])
        # b's precision is None and must be omitted, not treated as 0.0
        assert stats["evidence_precision"] == pytest.approx(1.0)
        assert stats["n"] == 2


def test_score_run_writes_summary(tmp_path, field_map, monkeypatch) -> None:
    import ddx_genie.score as score_module

    monkeypatch.setattr(FieldMap, "load", classmethod(lambda cls, p=None: field_map))
    run_dir = tmp_path / "runX"
    run_dir.mkdir()
    (run_dir / "genie_000001.json").write_text(json.dumps(_result()))
    (run_dir / "baseline_000001.json").write_text(
        json.dumps(_result(system="baseline"))
    )

    summary = score_module.score_run("runX", runs_dir=tmp_path)
    assert set(summary["systems"]) == {"genie", "baseline"}
    assert (run_dir / "summary.json").exists()
    assert summary["systems"]["genie"]["per_condition"]["Pneumonia"]["n"] == 1


class TestShortMultiSelectRegression:
    """E_54 is data_type 'M' but kept as a single Enum, not region booleans.

    Routing it through the region mapping sent every value to 'other', which has no
    field, silently dropping 62 true evidences across the 60-patient subset.
    """

    @pytest.fixture
    def mixed_map(self, tmp_path):
        plan = {
            "observed_evidence_codes": ["E_54", "E_55"],
            "fields": [
                # a short multi-select kept as one Enum
                {"name": "pain_character", "evidence_code": "E_54", "region": None,
                 "kind": "enum", "description": "", "enum_values": ["sharp"],
                 "parent_field": None},
                # a long multi-select collapsed into regions
                {"name": "pain_chest", "evidence_code": "E_55", "region": "chest",
                 "kind": "bool", "description": "", "enum_values": [],
                 "parent_field": None},
            ],
        }
        path = tmp_path / "field_list.json"
        path.write_text(json.dumps(plan))
        return FieldMap.load(path)

    def test_only_collapsed_codes_are_region_routed(self, mixed_map) -> None:
        assert mixed_map.region_collapsed_codes == {"E_55"}

    def test_short_multiselect_maps_to_its_enum_field(self, mixed_map) -> None:
        # "a knife stroke" has no anatomical region; it must still be credited.
        truth = mixed_map.truth_fields([{"code": "E_54", "value": "V_18"}])
        assert truth == {"pain_character"}

    def test_long_multiselect_still_region_routed(self, mixed_map) -> None:
        truth = mixed_map.truth_fields([{"code": "E_55", "value": "V_29"}])
        assert truth == {"pain_chest"}
