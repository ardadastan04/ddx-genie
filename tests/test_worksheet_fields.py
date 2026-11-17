from ddx_genie.worksheet.fields import BY_NAME, FIELDS, applicable, demographics


def test_field_names_unique_and_sections_known() -> None:
    assert len(BY_NAME) == len(FIELDS)
    assert {f.section for f in FIELDS} == {"history", "exam", "investigations"}


def test_conditional_fields() -> None:
    adult_male = {f.name for f in applicable(demographics("45", "Male"))}
    girl = {f.name for f in applicable(demographics("16", "female"))}
    assert "obstetric_gynecologic" not in adult_male and "pediatric_history" not in adult_male
    assert {"obstetric_gynecologic", "pediatric_history"} <= girl


def test_demographics_tolerates_junk() -> None:
    assert demographics(None, "unknown") == {"age": None, "sex": None}
