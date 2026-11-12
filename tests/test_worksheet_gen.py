"""Tests for the worksheet CSV generator.

The CSV format is positional, so the highest-value test here pins our column order
against Genie's own index constants: if upstream reorders a column, every cell we
write silently lands in the wrong field, and only this test would notice.
"""

from __future__ import annotations

import pytest

from ddx_genie.worksheet_gen import (
    DIFFERENTIAL_FIELD,
    HEADER,
    WORKSHEET_NAME,
    _row,
    build_rows,
    predicate_for,
)

PLAN = {
    "fields": [
        {"name": "pain_present", "kind": "bool", "description": "Do you have pain somewhere?",
         "enum_values": [], "parent_code": None, "parent_field": None, "evidence_code": "E_53"},
        {"name": "pain_intensity", "kind": "int", "description": "How intense is the pain? 0 to 10.",
         "enum_values": [], "parent_code": "E_53", "parent_field": "pain_present",
         "evidence_code": "E_56"},
        {"name": "pain_character", "kind": "enum", "description": "Characterize your pain:",
         "enum_values": ["burning", "sharp"], "parent_code": "E_53",
         "parent_field": "pain_present", "evidence_code": "E_54"},
        {"name": "orphan", "kind": "bool", "description": "Orphan child.",
         "enum_values": [], "parent_code": "E_900", "parent_field": None,
         "evidence_code": "E_99"},
    ]
}


def test_header_matches_genie_column_constants() -> None:
    """Our column order must equal upstream's positional indices, exactly."""
    import worksheets.specification.from_spreadsheet as fs

    expected = {
        "Form Predicate": fs.FORM_PREDICATE,
        "Form Name": fs.FORM_NAME,
        "Predicate": fs.FIELD_PREDICATE,
        "Kind": fs.KIND,
        "Type": fs.FIELD_TYPE,
        "Name": fs.FIELD_NAME,
        "Enum Values": fs.VARIABLE_ENUMS,
        "Description": fs.FIELD_DESCRIPTION,
        "Don't Ask": fs.DONT_ASK,
        "Required": fs.REQUIRED,
        "Confirm": fs.FIELD_CONFIRMATION,
        "Actions": fs.FIELD_ACTION,
        "Form Actions": fs.FORM_ACTION,
        "Validation": fs.FIELD_VALIDATION,
    }
    for label, index in expected.items():
        assert HEADER[index] == label, f"column {index} should be {label}, is {HEADER[index]}"
    assert len(HEADER) == fs.EMPTY_COL


class TestRow:
    def test_addresses_columns_by_name(self) -> None:
        row = _row(form_name="X", type="worksheet")
        assert row[HEADER.index("Form Name")] == "X"
        assert row[HEADER.index("Type")] == "worksheet"

    def test_dont_ask_label_is_handled(self) -> None:
        row = _row(dont_ask="TRUE")
        assert row[HEADER.index("Don't Ask")] == "TRUE"

    def test_unset_cells_are_empty(self) -> None:
        assert _row(name="n").count("") == len(HEADER) - 1


class TestPredicateFor:
    def test_parent_present_gates_the_child(self) -> None:
        spec = {"name": "pain_intensity", "parent_field": "pain_present"}
        assert predicate_for(spec, {"pain_present", "pain_intensity"}) == (
            "self.pain_present == True"
        )

    def test_no_parent_is_ungated(self) -> None:
        assert predicate_for({"name": "cough", "parent_field": None}, {"cough"}) == ""

    def test_missing_parent_field_is_ungated(self) -> None:
        # Referencing a field that does not exist would fail at runtime, not load time.
        assert predicate_for({"name": "orphan", "parent_field": "gone"}, {"orphan"}) == ""

    def test_field_is_never_its_own_parent(self) -> None:
        assert predicate_for({"name": "p", "parent_field": "p"}, {"p"}) == ""


class TestBuildRows:
    def test_worksheet_row_comes_first(self) -> None:
        rows = build_rows(PLAN)
        assert rows[0][HEADER.index("Form Name")] == WORKSHEET_NAME
        assert rows[0][HEADER.index("Type")] == "worksheet"
        assert rows[0][HEADER.index("Form Actions")]

    def test_enum_values_follow_their_field_with_blank_type_and_name(self) -> None:
        rows = build_rows(PLAN)
        i = next(i for i, r in enumerate(rows) if r[HEADER.index("Name")] == "pain_character")
        for offset, value in enumerate(["burning", "sharp"], start=1):
            enum_row = rows[i + offset]
            assert enum_row[HEADER.index("Enum Values")] == value
            # Blankness is how the parser detects the end of the enum run.
            assert enum_row[HEADER.index("Type")] == ""
            assert enum_row[HEADER.index("Name")] == ""

    def test_types_map_to_genie_names(self) -> None:
        rows = build_rows(PLAN)
        types = {r[HEADER.index("Name")]: r[HEADER.index("Type")] for r in rows}
        assert types["pain_present"] == "bool"
        assert types["pain_intensity"] == "int"
        assert types["pain_character"] == "Enum"

    def test_differential_is_internal_and_never_asked(self) -> None:
        rows = build_rows(PLAN)
        row = next(r for r in rows if r[HEADER.index("Name")] == DIFFERENTIAL_FIELD)
        assert row[HEADER.index("Kind")] == "internal"
        assert row[HEADER.index("Don't Ask")] == "TRUE"
        assert row[HEADER.index("Required")] == ""

    def test_orphan_child_emits_no_predicate(self) -> None:
        rows = build_rows(PLAN)
        row = next(r for r in rows if r[HEADER.index("Name")] == "orphan")
        assert row[HEADER.index("Predicate")] == ""

    def test_every_input_field_is_required(self) -> None:
        rows = build_rows(PLAN)
        inputs = [r for r in rows if r[HEADER.index("Kind")] == "input"]
        assert len(inputs) == 4
        assert all(r[HEADER.index("Required")] == "TRUE" for r in inputs)


def test_generated_csv_loads_in_genie(tmp_path) -> None:
    """End-to-end: our CSV must survive Genie's own parser."""
    import json

    from ddx_genie.worksheet_gen import write_intake_csv
    from worksheets.specification.from_spreadsheet import specification_to_genie
    from worksheets.utils.field import get_genie_fields_from_ws

    plan_path = tmp_path / "field_list.json"
    plan_path.write_text(json.dumps(PLAN))
    out = tmp_path / "intake.csv"
    write_intake_csv(plan_path=plan_path, out_path=out)

    loaded = specification_to_genie(csv_path=str(out))
    sheets = [w for g in loaded for w in (g if isinstance(g, list) else [g])]
    assert len(sheets) == 1
    assert sheets[0].__name__ == WORKSHEET_NAME
    fields = get_genie_fields_from_ws(sheets[0])
    names = {f.name for f in fields}
    assert {"pain_present", "pain_intensity", "pain_character", "orphan",
            DIFFERENTIAL_FIELD} <= names
    gated = {f.name: f.predicate for f in fields if f.predicate}
    assert gated == {"pain_intensity": "self.pain_present == True",
                     "pain_character": "self.pain_present == True"}
    enum_field = next(f for f in fields if f.name == "pain_character")
    assert [e.name for e in enum_field.slottype] == ["burning", "sharp"]
