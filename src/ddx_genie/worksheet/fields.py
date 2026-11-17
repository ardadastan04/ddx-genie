"""Clinical worksheet fields, independent of the state tracker that fills them.

Fields follow a standard history-and-physical template (HPI -> past history ->
exam -> investigations), in that order. The order is the fixed-order arm's policy.
They were chosen from the template and sanity-checked only on the 59 design cases
(``data/processed/mediq/dev.jsonl``), never on the 50 held-out test cases.

``applies`` gates a field on demographics (e.g. obstetric history only for female
patients); a field that does not apply is never asked.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Callable

Demographics = dict[str, object]  # {"age": int | None, "sex": "male" | "female" | None}


def _always(_: Demographics) -> bool:
    return True


def _female(d: Demographics) -> bool:
    return d.get("sex") == "female"


def _child(d: Demographics) -> bool:
    age = d.get("age")
    return isinstance(age, int) and age < 18


@dataclass(frozen=True)
class Field:
    name: str
    section: str  # history | exam | investigations
    description: str  # what the field holds; used by the chooser and the parser
    question: str  # template question for the patient / chart
    applies: Callable[[Demographics], bool] = _always


FIELDS: tuple[Field, ...] = (
    # --- history of present illness
    Field("onset_duration", "history", "When the main symptom started, how long it has lasted, "
          "sudden vs gradual onset, and how it has progressed",
          "When did this start, and how has it changed since?"),
    Field("symptom_character", "history", "Location, quality, severity, radiation and timing "
          "pattern of the main symptom", "Can you describe the main symptom in more detail?"),
    Field("modifying_factors", "history", "Triggers and what makes the symptom better or worse",
          "Does anything bring it on, or make it better or worse?"),
    Field("associated_symptoms", "history", "Other symptoms present or explicitly absent "
          "(fever, weight loss, nausea, cough, pain elsewhere, etc.)",
          "Have you had any other symptoms?"),
    Field("prior_episodes", "history", "Previous similar episodes and any evaluation or "
          "treatment already given for this complaint",
          "Has this happened before, and has anything been done for it?"),
    Field("function_mood_sleep", "history", "Mood, sleep, appetite, energy, behaviour, work "
          "or school function", "How have your mood, sleep, appetite and daily activities been?"),
    # --- past, family and social history
    Field("past_medical_history", "history", "Chronic conditions, prior diagnoses, surgeries, "
          "hospitalizations, psychiatric history", "What medical problems or surgeries have you had?"),
    Field("medications", "history", "Current and recent medications, including over-the-counter "
          "drugs and supplements, and recent changes", "What medications do you take?"),
    Field("allergies", "history", "Drug and other allergies", "Do you have any allergies?"),
    Field("obstetric_gynecologic", "history", "Last menstrual period, cycle, pregnancies, "
          "contraception", "When was your last period, and could you be pregnant?", _female),
    Field("pediatric_history", "history", "Birth history, development, growth, immunizations",
          "How was the birth, development and vaccination history?", _child),
    Field("family_history", "history", "Conditions in close relatives",
          "Does any illness run in your family?"),
    Field("social_history", "history", "Smoking, alcohol, drug use, occupation, living situation",
          "Do you smoke, drink or use drugs, and what do you do for work?"),
    Field("sexual_history", "history", "Sexual activity, partners, protection, STI history",
          "Are you sexually active, and do you use protection?"),
    Field("exposures_travel", "history", "Recent travel, sick contacts, animals, diet, "
          "environmental or occupational exposures",
          "Any recent travel, sick contacts or unusual exposures?"),
    # --- examination
    Field("general_appearance", "exam", "General appearance and level of distress",
          "How does the patient appear on examination?"),
    Field("vital_signs", "exam", "Temperature, pulse, blood pressure, respiratory rate, O2 "
          "saturation", "What are the vital signs?"),
    Field("heent_neck_exam", "exam", "Head, eyes, ears, nose, throat, neck, lymph nodes",
          "What does the head and neck examination show?"),
    Field("cardiovascular_exam", "exam", "Heart sounds, murmurs, pulses, JVP, edema",
          "What does the cardiovascular examination show?"),
    Field("respiratory_exam", "exam", "Breath sounds, crackles, wheeze, percussion",
          "What does the lung examination show?"),
    Field("abdominal_exam", "exam", "Tenderness, distension, organomegaly, masses, bowel sounds",
          "What does the abdominal examination show?"),
    Field("neurological_exam", "exam", "Mental status, cranial nerves, strength, reflexes, "
          "sensation, gait", "What does the neurological examination show?"),
    Field("skin_exam", "exam", "Rashes, lesions, color changes", "Is there anything on the skin?"),
    Field("musculoskeletal_exam", "exam", "Joints, back, extremities",
          "What does the musculoskeletal examination show?"),
    Field("genitourinary_exam", "exam", "Genital, pelvic, rectal, breast examination",
          "What does the genitourinary or pelvic examination show?"),
    # --- investigations
    Field("blood_counts", "investigations", "Hemoglobin, white cells, platelets, smear",
          "What does the complete blood count show?"),
    Field("chemistry", "investigations", "Electrolytes, renal and liver function, glucose",
          "What do the electrolytes, kidney and liver tests show?"),
    Field("other_blood_tests", "investigations", "Inflammatory markers, serology, hormones, "
          "cardiac enzymes, coagulation, blood gases", "Were any other blood tests done?"),
    Field("urine_fluids_micro", "investigations", "Urinalysis, CSF or other fluid analysis, "
          "cultures, biopsy", "Were urine, other fluids or cultures tested?"),
    Field("ecg", "investigations", "Electrocardiogram", "What does the ECG show?"),
    Field("imaging", "investigations", "X-ray, ultrasound, CT, MRI and other imaging",
          "Was any imaging done, and what did it show?"),
)

BY_NAME: dict[str, Field] = {f.name: f for f in FIELDS}


def applicable(demographics: Demographics) -> list[Field]:
    """Fields that apply to this patient, in fixed (H&P) order."""
    return [f for f in FIELDS if f.applies(demographics)]


def demographics(age: object, sex: object) -> Demographics:
    """Normalise MediQ's ``patient`` age/sex strings."""
    try:
        age_i: int | None = int(str(age).split()[0])
    except (TypeError, ValueError, IndexError):
        age_i = None
    s = str(sex or "").strip().lower()
    return {"age": age_i, "sex": s if s in ("male", "female") else None}
