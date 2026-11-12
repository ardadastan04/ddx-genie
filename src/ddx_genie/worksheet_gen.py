"""Generate ``genie/intake.csv``, the Genie worksheet specification, from the field plan.

The CSV format is positional, not keyed, so the column order in :data:`HEADER` is the
contract. It is taken from the ``FORM_PREDICATE..FIELD_VALIDATION`` constants in
``worksheets/specification/from_spreadsheet.py``, which is the only authority: the
bundled example CSVs ship 13 columns and rely on ``fill_all_empty`` padding the 14th.

Two deviations from the original plan in TASKS.md, both forced by the source:

* The differential is an ``internal`` field, not an ``output`` one. The ``output``
  Kind feeds ``potential_outputs``, which resolves *knowledge-base query result
  types*; it is unused by every CSV in the upstream repo and is not a slot for a
  generated value. An internal field that a Form Action fills is the working path.
* Multi-select evidences are already collapsed to anatomical regions upstream in
  ``subset.build_field_plan``; see the note there.
"""

from __future__ import annotations

import csv
import json
from pathlib import Path
from typing import Any

from ddx_genie.subset import PROCESSED_DIR, REPO_ROOT

GENIE_DIR = REPO_ROOT / "genie"
INTAKE_CSV = GENIE_DIR / "intake.csv"

WORKSHEET_NAME = "PatientIntake"

#: Positional column order. Index = the FIELD_* constants in from_spreadsheet.py.
HEADER = [
    "Form Predicate",   # 0  FORM_PREDICATE
    "Form Name",        # 1  FORM_NAME
    "Predicate",        # 2  FIELD_PREDICATE
    "Kind",             # 3  KIND
    "Type",             # 4  FIELD_TYPE
    "Name",             # 5  FIELD_NAME
    "Enum Values",      # 6  VARIABLE_ENUMS
    "Description",      # 7  FIELD_DESCRIPTION
    "Don't Ask",        # 8  DONT_ASK
    "Required",         # 9  REQUIRED
    "Confirm",          # 10 FIELD_CONFIRMATION
    "Actions",          # 11 FIELD_ACTION
    "Form Actions",     # 12 FORM_ACTION
    "Validation",       # 13 FIELD_VALIDATION
]

#: Genie writes the differential here; T5 registers the ``diagnose`` API it calls.
DIFFERENTIAL_FIELD = "differential"

#: Runs when every applicable field is filled. The harness also forces a diagnosis
#: at the turn cap, since 58 fields will rarely all be filled inside it.
FORM_ACTION = f"self.{DIFFERENTIAL_FIELD} = diagnose(self)"


def _row(**kwargs: str) -> list[str]:
    """Build one CSV row, addressing columns by header name rather than index."""
    row = [""] * len(HEADER)
    for key, value in kwargs.items():
        label = key.replace("_", " ").title().replace("Dont Ask", "Don't Ask")
        row[HEADER.index(label)] = value
    return row


def predicate_for(spec: dict[str, Any], field_names: set[str]) -> str:
    """The Predicate cell: only ask a child once its parent evidence is confirmed.

    Returns empty when the parent has no field of its own, which would otherwise
    emit a predicate referencing a nonexistent attribute and fail at runtime.
    """
    parent_field = spec.get("parent_field")
    if not parent_field:
        return ""
    if parent_field not in field_names or parent_field == spec["name"]:
        return ""
    return f"self.{parent_field} == True"


def build_rows(plan: dict[str, Any]) -> list[list[str]]:
    """Turn the field plan into CSV rows, worksheet row first."""
    specs = plan["fields"]
    field_names = {spec["name"] for spec in specs}
    rows: list[list[str]] = [
        _row(form_name=WORKSHEET_NAME, type="worksheet", form_actions=FORM_ACTION)
    ]

    for spec in specs:
        kind = spec["kind"]
        genie_type = {"bool": "bool", "int": "int", "enum": "Enum"}[kind]
        rows.append(
            _row(
                predicate=predicate_for(spec, field_names),
                kind="input",
                type=genie_type,
                name=spec["name"],
                description=spec["description"],
                required="TRUE",
            )
        )
        if kind == "enum":
            # Enum values live on the rows immediately after the field, with Type and
            # Name left blank: that blankness is how the parser detects the run.
            for value in spec["enum_values"]:
                rows.append(_row(enum_values=value))

    rows.append(
        _row(
            kind="internal",
            type="str",
            name=DIFFERENTIAL_FIELD,
            description=(
                "The top-5 differential diagnosis with probabilities, produced by the "
                "diagnose action once the interview is complete. Never ask the patient "
                "for this."
            ),
            dont_ask="TRUE",
        )
    )
    return rows


def write_intake_csv(
    plan_path: Path | None = None, out_path: Path = INTAKE_CSV
) -> tuple[Path, list[list[str]]]:
    plan_path = plan_path or PROCESSED_DIR / "field_list.json"
    if not plan_path.exists():
        raise FileNotFoundError(
            f"{plan_path} is missing; run `python -m ddx_genie.subset` first"
        )
    plan = json.loads(plan_path.read_text())
    rows = build_rows(plan)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("w", newline="") as handle:
        writer = csv.writer(handle)
        writer.writerow(HEADER)
        writer.writerows(rows)
    return out_path, rows


def main() -> None:
    path, rows = write_intake_csv()
    print(f"wrote {path.relative_to(REPO_ROOT)}: {len(rows) + 1} lines "
          f"(1 header + {len(rows)} rows)\n")

    print("first 30 rows:")
    print(f"  {'#':>3}  {'Pred':<26} {'Kind':<9} {'Type':<6} {'Name':<22} Description/Enum")
    for i, row in enumerate(rows[:30], 1):
        pred = row[HEADER.index("Predicate")]
        kind = row[HEADER.index("Kind")]
        type_ = row[HEADER.index("Type")]
        name = row[HEADER.index("Name")] or row[HEADER.index("Form Name")]
        tail = row[HEADER.index("Description")] or f"[enum] {row[HEADER.index('Enum Values')]}"
        print(f"  {i:>3}  {pred:<26} {kind:<9} {type_:<6} {name:<22} {tail[:46]}")

    # Load it through Genie itself: the only check that matters.
    from worksheets.specification.from_spreadsheet import specification_to_genie
    from worksheets.utils.field import get_genie_fields_from_ws

    loaded = specification_to_genie(csv_path=str(path))
    worksheets = [w for group in loaded for w in (group if isinstance(group, list) else [group])]
    print(f"\nGenie parsed {len(worksheets)} worksheet(s):")
    for worksheet in worksheets:
        fields = get_genie_fields_from_ws(worksheet)
        gated = [f for f in fields if f.predicate]
        print(f"  {worksheet.__name__}: {len(fields)} fields, {len(gated)} predicate-gated")
        print(f"    actions: {getattr(worksheet, 'actions', None)}")


if __name__ == "__main__":
    main()
