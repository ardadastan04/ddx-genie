"""Tests for DDXPlus evidence parsing and the field plan. No raw data needed."""

from __future__ import annotations

import pytest

from ddx_genie.subset import (
    CONDITIONS,
    REGIONS,
    DataError,
    build_field_plan,
    decode_value,
    is_numeric_scale,
    parse_differential,
    parse_evidences,
    region_for,
)

SCALE = {"question_en": "How intense is the pain?", "data_type": "C",
         "possible-values": list(range(11)), "value_meaning": {}, "code_question": "E_56"}
CATEG = {"question_en": "What color is the rash?", "data_type": "C",
         "possible-values": ["V_86", "V_157"],
         "value_meaning": {"V_86": {"en": "dark"}, "V_157": {"en": "red"}},
         "code_question": "E_53"}
#: Same shape, but inside the excluded skin group.
CATEG_SKIN = CATEG | {"code_question": "E_129"}
BINARY = {"question_en": "Do you have a fever?", "data_type": "B",
          "possible-values": [], "value_meaning": {}, "code_question": "E_91"}
LOCATION = {"question_en": "Do you feel pain somewhere?", "data_type": "M",
            "possible-values": [f"V_{i}" for i in range(165)],
            "value_meaning": {"V_1": {"en": "upper chest"}, "V_2": {"en": "posterior chest wall(L)"},
                              "V_3": {"en": "forehead"}, "V_123": {"en": "nowhere"}},
            "code_question": "E_53"}
PAIN_CHAR = {"question_en": "Characterize your pain:", "data_type": "M",
             "possible-values": ["V_1", "V_2"],
             "value_meaning": {"V_1": {"en": "burning"}, "V_2": {"en": "sharp"}},
             "code_question": "E_53"}


class TestParseEvidences:
    def test_bare_binary_has_no_value(self) -> None:
        assert parse_evidences("['E_91', 'E_55']") == [("E_91", None), ("E_55", None)]

    def test_splits_the_at_separator(self) -> None:
        assert parse_evidences("['E_55_@_V_89']") == [("E_55", "V_89")]

    def test_numeric_value_stays_a_string(self) -> None:
        assert parse_evidences("['E_56_@_7']") == [("E_56", "7")]

    def test_mixed_list(self) -> None:
        assert parse_evidences("['E_91', 'E_56_@_7', 'E_55_@_V_89']") == [
            ("E_91", None), ("E_56", "7"), ("E_55", "V_89")
        ]

    def test_value_containing_underscores_is_not_split_twice(self) -> None:
        # partition on the first separator only; V_1_@_X would be pathological
        assert parse_evidences("['E_1_@_V_10_@_extra']") == [("E_1", "V_10_@_extra")]

    def test_empty_list(self) -> None:
        assert parse_evidences("[]") == []

    def test_accepts_an_already_parsed_list(self) -> None:
        assert parse_evidences(["E_91"]) == [("E_91", None)]

    def test_non_list_is_an_error(self) -> None:
        with pytest.raises(DataError):
            parse_evidences("'E_91'")


class TestParseDifferential:
    def test_pairs_become_floats(self) -> None:
        assert parse_differential("[['Pneumonia', 0.5], ['URTI', 0.25]]") == [
            ("Pneumonia", 0.5), ("URTI", 0.25)
        ]

    def test_empty(self) -> None:
        assert parse_differential("[]") == []


class TestIsNumericScale:
    def test_integer_values_are_a_scale(self) -> None:
        assert is_numeric_scale(SCALE) is True

    def test_v_codes_are_not(self) -> None:
        assert is_numeric_scale(CATEG) is False

    def test_no_values_is_not(self) -> None:
        assert is_numeric_scale(BINARY) is False


class TestDecodeValue:
    def test_known_code(self) -> None:
        assert decode_value(CATEG, "V_86") == "dark"

    def test_scale_digit_passes_through(self) -> None:
        assert decode_value(SCALE, "7") == "7"


class TestRegionFor:
    @pytest.mark.parametrize(
        "location,expected",
        [
            ("nowhere", "nowhere"),
            ("upper chest", "chest"),
            ("lower chest", "chest"),
            ("side of the chest(L)", "chest"),
            # "posterior chest wall" must reach back before chest claims it
            ("posterior chest wall(R)", "back"),
            ("thoracic spine", "back"),
            ("lumbar spine", "back"),
            ("side of the neck(L)", "neck"),
            ("back of the neck", "neck"),
            ("pharynx", "throat"),
            ("forehead", "head"),
            ("temple(R)", "head"),
            ("occiput", "head"),
            ("back of head", "head"),
            ("breast(L)", "breast"),
            ("belly", "abdomen"),
            ("shoulder(L)", "limb"),
        ],
    )
    def test_mapping(self, location: str, expected: str) -> None:
        assert region_for(location) == expected

    def test_unknown_falls_back_to_other(self) -> None:
        assert region_for("xyzzy") == "other"

    def test_every_region_is_declared(self) -> None:
        samples = ["nowhere", "upper chest", "posterior chest wall(L)", "pharynx",
                   "forehead", "breast(R)", "belly", "shoulder(L)", "side of the neck(L)",
                   "xyzzy"]
        assert {region_for(s) for s in samples} <= set(REGIONS)

    def test_case_and_whitespace_insensitive(self) -> None:
        assert region_for("  UPPER CHEST  ") == "chest"


class TestBuildFieldPlan:
    def test_binary_becomes_one_bool(self) -> None:
        specs = build_field_plan({"E_91": set()}, {"E_91": BINARY})
        # E_91 has a curated override ("fever"), which takes precedence over the
        # fixture's question text -- that precedence is the point of the override.
        assert [(s.name, s.kind) for s in specs] == [("fever", "bool")]
        assert specs[0].evidence_code == "E_91"

    def test_scale_becomes_int_with_bounds(self) -> None:
        (spec,) = build_field_plan({"E_56": {"7"}}, {"E_56": SCALE})
        assert (spec.kind, spec.min_value, spec.max_value) == ("int", 0, 10)
        assert spec.name == "pain_intensity"
        assert "scale from 0 to 10" in spec.description

    def test_categorical_becomes_enum_of_decoded_values(self) -> None:
        (spec,) = build_field_plan({"E_130": {"V_86"}}, {"E_130": CATEG})
        assert spec.kind == "enum"
        assert spec.enum_values == ["dark", "red"]

    def test_single_observed_m_value_is_dropped(self) -> None:
        # E_57 "does the pain radiate" is only ever "nowhere" in the subset.
        assert build_field_plan({"E_55": {"V_123"}}, {"E_55": LOCATION}) == []

    def test_long_m_collapses_to_region_bools(self) -> None:
        specs = build_field_plan({"E_55": {"V_1", "V_2", "V_3"}}, {"E_55": LOCATION})
        assert {s.kind for s in specs} == {"bool"}
        assert [s.region for s in specs] == ["head", "chest", "back"]  # REGIONS order
        assert [s.name for s in specs] == ["pain_head", "pain_chest", "pain_back"]
        assert all(s.evidence_code == "E_55" for s in specs)

    def test_short_m_stays_a_single_enum(self) -> None:
        (spec,) = build_field_plan({"E_54": {"V_1", "V_2"}}, {"E_54": PAIN_CHAR})
        assert spec.kind == "enum"
        assert spec.enum_values == ["burning", "sharp"]

    def test_parent_is_recorded_for_predicate_gating(self) -> None:
        (spec,) = build_field_plan({"E_130": {"V_86"}}, {"E_130": CATEG, "E_53": BINARY})
        assert spec.parent_code == "E_53"

    def test_field_is_not_its_own_parent(self) -> None:
        (spec,) = build_field_plan({"E_91": set()}, {"E_91": BINARY})
        assert spec.parent_code is None


def test_six_conditions_declared() -> None:
    assert len(CONDITIONS) == 6
    assert len(set(CONDITIONS)) == 6


class TestExcludedGroups:
    def test_skin_group_members_are_dropped(self) -> None:
        from ddx_genie.subset import EXCLUDED_GROUPS, build_field_plan

        assert "E_129" in EXCLUDED_GROUPS
        evidences = {"E_129": BINARY | {"code_question": "E_129"},
                     "E_130": CATEG_SKIN,       # code_question E_129
                     "E_91": BINARY}
        specs = build_field_plan({"E_129": set(), "E_130": {"V_86"}, "E_91": set()}, evidences)
        # only the unrelated binary survives (E_91 -> curated name "fever")
        assert [s.name for s in specs] == ["fever"]

    def test_unexcluded_group_survives(self) -> None:
        from ddx_genie.subset import build_field_plan

        pain_scale = SCALE | {"code_question": "E_53"}
        specs = build_field_plan({"E_56": {"7"}}, {"E_56": pain_scale, "E_53": BINARY})
        assert [s.name for s in specs] == ["pain_intensity"]
        assert specs[0].parent_code == "E_53"


class TestFieldNames:
    """Names are what Genie's semantic parser must target, so they must be readable,
    unique, and valid Python identifiers."""

    def test_override_wins(self) -> None:
        from ddx_genie.subset import field_name_for

        assert field_name_for("E_201", "Do you have a cough?") == "cough"

    def test_parentheticals_are_dropped(self) -> None:
        from ddx_genie.subset import field_name_for

        name = field_name_for("E_999", "Do you have a chronic obstructive pulmonary disease (COPD)?")
        assert name == "chronic_obstructive_pulmonary_disease"

    def test_stopwords_are_dropped(self) -> None:
        from ddx_genie.subset import field_name_for

        assert field_name_for("E_999", "Do you work in agriculture?") == "work_agriculture"

    def test_region_is_suffixed(self) -> None:
        from ddx_genie.subset import field_name_for

        assert field_name_for("E_55", "Do you feel pain somewhere?", "chest") == "pain_chest"

    def test_result_is_always_an_identifier(self) -> None:
        from ddx_genie.subset import field_name_for

        for question in ["???", "Is it?", "Do you?", "class?", "123 go?"]:
            assert field_name_for("E_1", question).isidentifier()

    def test_keyword_is_escaped(self) -> None:
        from ddx_genie.subset import field_name_for
        import keyword

        name = field_name_for("E_1", "Class?")
        assert not keyword.iskeyword(name)

    def test_collisions_are_deduped_with_the_code(self) -> None:
        a = {"question_en": "Do you have a cough?", "data_type": "B",
             "possible-values": [], "value_meaning": {}, "code_question": "E_1",
             "is_antecedent": False}
        b = dict(a)  # identical question text, different code
        specs = build_field_plan({"E_1": set(), "E_2": set()}, {"E_1": a, "E_2": b})
        names = [s.name for s in specs]
        assert len(set(names)) == 2, names
        assert any(n.endswith("_e_2") for n in names), names

    def test_parent_field_is_resolved_to_a_name(self) -> None:
        pain = {"question_en": "Do you have pain somewhere?", "data_type": "B",
                "possible-values": [], "value_meaning": {}, "code_question": "E_53",
                "is_antecedent": False}
        specs = build_field_plan({"E_53": set(), "E_56": {"7"}},
                                 {"E_53": pain, "E_56": SCALE | {"code_question": "E_53"}})
        gated = next(s for s in specs if s.evidence_code == "E_56")
        assert gated.parent_field == "pain_present"
