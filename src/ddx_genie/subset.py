"""Build the fixed evaluation subset from the DDXPlus test split.

Writes two files, both reproducible from ``SEED``:

``data/processed/subset.jsonl``
    One patient per line, carrying the original test-split row index so every result
    traces back to the source data.
``data/processed/field_list.json``
    The worksheet field plan: the union of evidences these patients actually have,
    already resolved to Genie field kinds. T4 turns this straight into ``intake.csv``.

Field mapping follows the decisions recorded in CLAUDE.md:

* ``B`` -> one ``bool``.
* ``C`` with integer ``possible-values`` -> one ``int`` (a 0-10 scale).
* ``C`` with ``V_`` codes -> one ``Enum`` over the decoded meanings.
* ``M`` -> one ``bool`` per *anatomical region*, not per raw location. DDXPlus offers
  165 locations; the 60-patient subset uses 21, and one bool each would dominate the
  worksheet. Regions are also closer to how a clinician charts pain. ``score.py``
  must map true evidences through :func:`region_for` so recall stays honest.
* An ``M`` field with a single observed value carries no information and is dropped
  (``E_57`` "does the pain radiate" is only ever "nowhere" in this subset).
"""

from __future__ import annotations

import ast
import json
import zipfile
from collections import Counter, defaultdict
from dataclasses import asdict, dataclass, field as dc_field
from pathlib import Path
from typing import Any, Iterator

import pandas as pd

REPO_ROOT = Path(__file__).resolve().parents[2]
RAW_DIR = REPO_ROOT / "data" / "raw"
PROCESSED_DIR = REPO_ROOT / "data" / "processed"

SEED = 0
PATIENTS_PER_CONDITION = 10

#: Three confusable pairs rather than six unrelated diseases, so the eval
#: discriminates: Pneumonia/Influenza (0.70 Jaccard), Bronchitis/URTI (0.71),
#: COPD/Bronchospasm (0.75). Names must match release_conditions.json exactly.
CONDITIONS: tuple[str, ...] = (
    "Pneumonia",
    "Influenza",
    "Bronchitis",
    "URTI",
    "Acute COPD exacerbation / infection",
    "Bronchospasm / acute asthma exacerbation",
)

#: ``code_question`` groups dropped from the worksheet entirely. ``E_129`` is the
#: skin-lesion group (rash colour, peeling, swelling, itching, affected region): 14
#: fields of dermatology in a respiratory differential, carrying almost no signal for
#: separating pneumonia from bronchitis. ``score.py`` must exclude these evidences
#: from the recall denominator, since the agent is given no field to record them in.
EXCLUDED_GROUPS: frozenset[str] = frozenset({"E_129"})

#: Anatomical regions that ``M`` location values collapse into. Order is the field
#: order in the worksheet. "nowhere" is kept because it is a real, informative answer.
REGIONS: tuple[str, ...] = (
    "nowhere",
    "head",
    "throat",
    "neck",
    "chest",
    "back",
    "breast",
    "abdomen",
    "limb",
    "other",
)

#: Longest-match-first keyword rules mapping a decoded location to a region. Order
#: matters: "posterior chest wall" must reach "back" before "chest" claims it.
_REGION_RULES: tuple[tuple[str, str], ...] = (
    ("nowhere", "nowhere"),
    ("posterior chest wall", "back"),
    ("thoracic spine", "back"),
    ("cervical spine", "back"),
    ("lumbar spine", "back"),
    ("dorsal spine", "back"),
    ("flank", "back"),
    ("back of the neck", "neck"),
    ("side of the neck", "neck"),
    ("back of head", "head"),
    ("top of the head", "head"),
    ("breast", "breast"),
    ("pharynx", "throat"),
    ("trachea", "throat"),
    ("larynx", "throat"),
    ("tonsil", "throat"),
    ("thyroid", "throat"),
    ("neck", "neck"),
    ("chest", "chest"),
    ("sternum", "chest"),
    ("rib", "chest"),
    ("belly", "abdomen"),
    ("epigastric", "abdomen"),
    ("hypochondrium", "abdomen"),
    ("iliac", "abdomen"),
    ("umbilic", "abdomen"),
    ("flank(", "abdomen"),
    ("groin", "abdomen"),
    ("forehead", "head"),
    ("temple", "head"),
    ("cheek", "head"),
    ("occiput", "head"),
    ("commissure", "head"),
    ("nose", "head"),
    ("ear", "head"),
    ("eye", "head"),
    ("jaw", "head"),
    ("mouth", "head"),
    ("tooth", "head"),
    ("scalp", "head"),
    ("shoulder", "limb"),
    ("arm", "limb"),
    ("elbow", "limb"),
    ("wrist", "limb"),
    ("hand", "limb"),
    ("finger", "limb"),
    ("hip", "limb"),
    ("thigh", "limb"),
    ("knee", "limb"),
    ("calf", "limb"),
    ("ankle", "limb"),
    ("foot", "limb"),
    ("toe", "limb"),
    ("leg", "limb"),
    ("buttock", "other"),
    ("back", "back"),
)


#: Words carrying no discriminative meaning in a DDXPlus question stem. Dropped when
#: deriving a field name, so "Do you have a cough?" becomes ``cough``.
_NAME_STOPWORDS = frozenset(
    """a an and are any as at be been believe by can consultation consulting did do
    does ever felt feel feeling for from had has have how in is it its like
    measured more much new noticed of on or other recently related reason so that the
    their then there these this to today up usual usually was were what when where
    which who why with you your yourself either experiencing significant way""".split()
)

#: Field names that the derivation would otherwise make unhelpfully long or ambiguous.
_NAME_OVERRIDES = {
    "E_53": "pain_present",
    "E_55": "pain",
    "E_56": "pain_intensity",
    "E_57": "pain_radiates",
    "E_58": "pain_precision",
    "E_59": "pain_onset_speed",
    "E_54": "pain_character",
    "E_201": "cough",
    "E_77": "cough_productive_sputum",
    "E_91": "fever",
    "E_66": "shortness_of_breath",
    "E_214": "wheezing_on_exhale",
    "E_175": "fatigue_malaise",
    "E_204": "recent_foreign_travel",
}

MAX_NAME_WORDS = 4


class DataError(RuntimeError):
    """The raw DDXPlus files are missing or shaped unexpectedly."""


def field_name_for(code: str, question: str, region: str | None = None) -> str:
    """Derive a readable, valid-identifier field name from a question.

    Genie's semantic parser is an LLM that must emit ``PatientIntake(cough=True)``
    from a patient's utterance. Given 58 fields named ``e_101``..``e_227`` it has only
    the description to disambiguate; a meaningful name is far easier to target. The
    DDXPlus code is kept on every :class:`FieldSpec` as ``evidence_code``, so scoring
    still joins on the dataset's own identifier and nothing downstream depends on
    this label.
    """
    import keyword
    import re

    if code in _NAME_OVERRIDES:
        base = _NAME_OVERRIDES[code]
    else:
        text = re.sub(r"\([^)]*\)", " ", question).lower()  # drop parentheticals
        words = [w for w in re.findall(r"[a-z]+", text) if w not in _NAME_STOPWORDS]
        base = "_".join(words[:MAX_NAME_WORDS]) or code.lower()
    if region:
        base = f"{base}_{region}"
    if keyword.iskeyword(base) or not base.isidentifier():
        base = f"f_{base}"
    return base


def region_for(location_en: str) -> str:
    """Map a decoded DDXPlus location to one of :data:`REGIONS`.

    ``score.py`` must use this same function so predicted regions and true evidences
    are compared on identical terms.
    """
    text = location_en.strip().lower()
    for needle, region in _REGION_RULES:
        if needle in text:
            return region
    return "other"


# ------------------------------------------------------------------- loading raw data


def load_json(name: str) -> dict[str, Any]:
    path = RAW_DIR / name
    if not path.exists():
        raise DataError(
            f"{path} is missing. Download the English DDXPlus release into "
            f"{RAW_DIR} (research use only; the directory is gitignored)."
        )
    return json.loads(path.read_text())


def load_test_split() -> pd.DataFrame:
    """Load the test split, preserving the original row index as ``row_index``."""
    path = RAW_DIR / "release_test_patients.zip"
    if not path.exists():
        raise DataError(f"{path} is missing.")
    with zipfile.ZipFile(path) as archive:
        members = archive.namelist()
        if not members:
            raise DataError(f"{path} is empty")
        with archive.open(members[0]) as handle:
            frame = pd.read_csv(handle)
    required = {"AGE", "SEX", "PATHOLOGY", "EVIDENCES", "INITIAL_EVIDENCE"}
    if missing := required - set(frame.columns):
        raise DataError(f"test split is missing columns: {sorted(missing)}")
    return frame.reset_index(names="row_index")


# --------------------------------------------------------------------------- parsing


def parse_evidences(raw: str | list[str]) -> list[tuple[str, str | None]]:
    """Parse an ``EVIDENCES`` cell into ``(code, value)`` pairs.

    Non-binary evidences are written ``<code>_@_<value>``; binaries are bare codes
    and yield a ``None`` value. Values keep their raw form (``V_12`` or ``"7"``)
    because decoding needs the evidence definition.
    """
    items = ast.literal_eval(raw) if isinstance(raw, str) else raw
    if not isinstance(items, list):
        raise DataError(f"expected a list of evidences, got {type(items).__name__}")
    parsed: list[tuple[str, str | None]] = []
    for item in items:
        code, _, value = str(item).partition("_@_")
        parsed.append((code, value if value else None))
    return parsed


def parse_differential(raw: str | list) -> list[tuple[str, float]]:
    """Parse ``DIFFERENTIAL_DIAGNOSIS`` into ``(pathology, probability)`` pairs."""
    items = ast.literal_eval(raw) if isinstance(raw, str) else raw
    return [(str(name), float(prob)) for name, prob in items]


def is_numeric_scale(evidence: dict[str, Any]) -> bool:
    """True for the 0-10 scale ``C`` evidences, false for the ``V_``-coded ones.

    ``data_type`` alone cannot tell these apart, so always inspect possible-values.
    """
    values = evidence.get("possible-values") or []
    return bool(values) and all(isinstance(v, int) for v in values)


#: DDXPlus renders some yes/no options as bare "Y"/"N", which reads as a code rather
#: than speech. Normalise them wherever a value is decoded.
_VALUE_ALIASES = {"Y": "yes", "N": "no", "NA": "not applicable"}


def decode_value(evidence: dict[str, Any], value: str) -> str:
    """Decode a raw evidence value into English, leaving scale values as digits."""
    meaning = evidence.get("value_meaning") or {}
    if value in meaning:
        decoded = str(meaning[value].get("en", value))
        return _VALUE_ALIASES.get(decoded, decoded)
    return _VALUE_ALIASES.get(value, value)


# ------------------------------------------------------------------- the field plan


@dataclass
class FieldSpec:
    """One Genie worksheet field derived from a DDXPlus evidence."""

    name: str
    evidence_code: str
    kind: str  # bool | int | enum
    question: str
    data_type: str  # B | C | M
    description: str
    enum_values: list[str] = dc_field(default_factory=list)
    parent_code: str | None = None  # code_question parent, for the Predicate column
    #: The parent's *field name*, resolved after naming. The Predicate column needs
    #: this, not the code, since names are no longer derived from codes.
    parent_field: str | None = None
    region: str | None = None  # set when this field is one region of an M evidence
    min_value: int | None = None
    max_value: int | None = None


def _ask_order(
    observed: dict[str, set[str]], evidences: dict[str, Any], prevalence: dict[str, int]
) -> list[str]:
    """Order evidence codes the way a clinician would ask about them.

    Field order in the CSV *is* the agent's question order: Genie walks unfilled
    fields in declaration order. Sorting by evidence code put "have you been
    hospitalised for an asthma attack" as the first follow-up to a cough, burning the
    turn budget on low-yield history before the presenting complaint was
    characterised.

    Three constraints:

    1. A parent always precedes its children, since a child's predicate reads the
       parent's value and a child asked first is simply skipped.
    2. Presenting symptoms before past history (``is_antecedent``).
    3. Within each, the findings most patients in the subset actually have come
       first; those carry the most discriminative signal per question asked.

    ``prevalence`` is a count of *patients* having each code, not of distinct values.
    The code is the final tie-break, so the order stays deterministic.
    """
    children: dict[str, list[str]] = defaultdict(list)
    roots: list[str] = []
    for code in observed:
        parent = evidences[code].get("code_question")
        if parent and parent != code and parent in observed:
            children[parent].append(code)
        else:
            roots.append(code)

    def rank(code: str) -> tuple:
        return (
            bool(evidences[code].get("is_antecedent")),
            -prevalence.get(code, 0),
            evidences[code]["data_type"] != "B",
            code,
        )

    # Screen, then drill down: all top-level questions of a group before any of its
    # follow-ups. Placing children immediately after their parent spent twelve of the
    # turn budget characterising pain before fever or breathlessness were ever asked.
    # Symptom roots come before every child, so parents still precede their children.
    order: list[str] = []
    for antecedent in (False, True):
        tier = [c for c in roots if bool(evidences[c].get("is_antecedent")) is antecedent]
        order.extend(sorted(tier, key=rank))
        follow_ups = [
            child
            for root in tier
            for child in children.get(root, [])
        ]
        order.extend(sorted(follow_ups, key=rank))
    return order


def build_field_plan(
    observed: dict[str, set[str]],
    evidences: dict[str, Any],
    prevalence: dict[str, int] | None = None,
) -> list[FieldSpec]:
    """Turn the observed evidence codes into the worksheet field plan.

    ``prevalence`` maps an evidence code to how many subset patients have it; it only
    affects question order. Omitted, every code ranks equally and order falls back to
    the deterministic tie-breaks in :func:`_ask_order`.
    """
    prevalence = prevalence or {}
    specs: list[FieldSpec] = []
    for code in _ask_order(observed, evidences, prevalence):
        evidence = evidences[code]
        data_type = evidence["data_type"]
        question = evidence["question_en"]
        group = evidence.get("code_question")
        if group in EXCLUDED_GROUPS or code in EXCLUDED_GROUPS:
            continue
        # A parent is only meaningful when its group has more than one member and the
        # parent is not the field itself.
        parent = group if group and group != code and group in evidences else None

        if data_type == "B":
            specs.append(
                FieldSpec(
                    name=field_name_for(code, question),
                    evidence_code=code,
                    kind="bool",
                    question=question,
                    data_type=data_type,
                    description=question,
                    parent_code=parent,
                )
            )
        elif data_type == "C":
            if is_numeric_scale(evidence):
                values = evidence["possible-values"]
                specs.append(
                    FieldSpec(
                        name=field_name_for(code, question),
                        evidence_code=code,
                        kind="int",
                        question=question,
                        data_type=data_type,
                        description=f"{question} Answer on a scale from "
                        f"{min(values)} to {max(values)}.",
                        parent_code=parent,
                        min_value=min(values),
                        max_value=max(values),
                    )
                )
            else:
                decoded = [
                    decode_value(evidence, v) for v in evidence["possible-values"]
                ]
                specs.append(
                    FieldSpec(
                        name=field_name_for(code, question),
                        evidence_code=code,
                        kind="enum",
                        question=question,
                        data_type=data_type,
                        description=question,
                        enum_values=decoded,
                        parent_code=parent,
                    )
                )
        else:  # M
            observed_regions = sorted(
                {region_for(decode_value(evidence, v)) for v in observed[code]},
                key=REGIONS.index,
            )
            # One observed value carries no signal: every patient answers the same.
            if len(observed[code]) <= 1:
                continue
            if len(evidence.get("possible-values") or []) <= 16:
                # A short option list (E_54 "characterize your pain") stays a single
                # Enum; collapsing it into regions would be meaningless.
                decoded = [
                    decode_value(evidence, v) for v in evidence["possible-values"]
                ]
                specs.append(
                    FieldSpec(
                        name=field_name_for(code, question),
                        evidence_code=code,
                        kind="enum",
                        question=question,
                        data_type=data_type,
                        description=question,
                        enum_values=decoded,
                        parent_code=parent,
                    )
                )
                continue
            for region in observed_regions:
                specs.append(
                    FieldSpec(
                        name=field_name_for(code, question, region),
                        evidence_code=code,
                        kind="bool",
                        question=question,
                        data_type=data_type,
                        description=(
                            "Is the answer 'nowhere'?"
                            if region == "nowhere"
                            else f"{question} Specifically, the {region}?"
                        ),
                        parent_code=parent,
                        region=region,
                    )
                )
    _dedupe_names(specs)
    _resolve_parent_fields(specs)
    return specs


def _resolve_parent_fields(specs: list[FieldSpec]) -> None:
    """Fill in each gated field's parent *field name* from its parent evidence code."""
    by_code = {spec.evidence_code: spec.name for spec in specs if spec.region is None}
    for spec in specs:
        if spec.parent_code and spec.parent_code != spec.evidence_code:
            spec.parent_field = by_code.get(spec.parent_code)


def _dedupe_names(specs: list[FieldSpec]) -> None:
    """Make field names unique, since two questions can reduce to the same words."""
    seen: dict[str, int] = {}
    for spec in specs:
        if spec.name in seen:
            seen[spec.name] += 1
            spec.name = f"{spec.name}_{spec.evidence_code.lower()}"
        else:
            seen[spec.name] = 1


# ------------------------------------------------------------------------- the subset


def sample_patients(frame: pd.DataFrame) -> pd.DataFrame:
    """Ten patients per condition at ``SEED``, in :data:`CONDITIONS` order."""
    chunks = []
    for condition in CONDITIONS:
        pool = frame[frame.PATHOLOGY == condition]
        if len(pool) < PATIENTS_PER_CONDITION:
            raise DataError(
                f"{condition!r} has only {len(pool)} test patients, "
                f"need {PATIENTS_PER_CONDITION}"
            )
        chunks.append(pool.sample(n=PATIENTS_PER_CONDITION, random_state=SEED))
    return pd.concat(chunks)


def patient_records(frame: pd.DataFrame) -> Iterator[dict[str, Any]]:
    for row in frame.itertuples():
        yield {
            "row_index": int(row.row_index),
            "pathology": row.PATHOLOGY,
            "age": int(row.AGE),
            "sex": row.SEX,
            "initial_evidence": row.INITIAL_EVIDENCE,
            "evidences": [
                {"code": code, "value": value}
                for code, value in parse_evidences(row.EVIDENCES)
            ],
            "differential": [
                {"pathology": name, "probability": prob}
                for name, prob in parse_differential(row.DIFFERENTIAL_DIAGNOSIS)
            ],
        }


def build_subset(out_dir: Path = PROCESSED_DIR) -> tuple[Path, Path]:
    """Build and write the subset and the field plan. Returns both paths."""
    evidences = load_json("release_evidences.json")
    conditions = load_json("release_conditions.json")
    if unknown := set(CONDITIONS) - set(conditions):
        raise DataError(f"conditions not in release_conditions.json: {sorted(unknown)}")

    sample = sample_patients(load_test_split())
    records = list(patient_records(sample))

    observed: dict[str, set[str]] = defaultdict(set)
    prevalence: Counter[str] = Counter()
    for record in records:
        for code in {item["code"] for item in record["evidences"]}:
            prevalence[code] += 1
        for item in record["evidences"]:
            if item["value"] is not None:
                observed[item["code"]].add(item["value"])
            else:
                observed[item["code"]]  # register bare binaries
    if unknown_codes := set(observed) - set(evidences):
        raise DataError(f"evidence codes absent from the release: {sorted(unknown_codes)}")

    specs = build_field_plan(observed, evidences, prevalence)

    out_dir.mkdir(parents=True, exist_ok=True)
    subset_path = out_dir / "subset.jsonl"
    with subset_path.open("w") as handle:
        for record in records:
            handle.write(json.dumps(record, ensure_ascii=False, sort_keys=True) + "\n")

    field_path = out_dir / "field_list.json"
    field_path.write_text(
        json.dumps(
            {
                "seed": SEED,
                "conditions": list(CONDITIONS),
                "patients_per_condition": PATIENTS_PER_CONDITION,
                "regions": list(REGIONS),
                "excluded_groups": sorted(EXCLUDED_GROUPS),
                "observed_evidence_codes": sorted(observed),
                "fields": [asdict(spec) for spec in specs],
            },
            indent=2,
            ensure_ascii=False,
            sort_keys=True,
        )
        + "\n"
    )
    return subset_path, field_path


def main() -> None:
    subset_path, field_path = build_subset()
    records = [json.loads(line) for line in subset_path.read_text().splitlines()]
    plan = json.loads(field_path.read_text())

    by_condition: dict[str, int] = defaultdict(int)
    for record in records:
        by_condition[record["pathology"]] += 1

    print(f"{subset_path.relative_to(REPO_ROOT)}: {len(records)} patients")
    for condition in CONDITIONS:
        print(f"    {by_condition[condition]:>3}  {condition}")

    kinds: dict[str, int] = defaultdict(int)
    for spec in plan["fields"]:
        kinds[spec["kind"]] += 1
    print(f"\n{field_path.relative_to(REPO_ROOT)}: {len(plan['fields'])} worksheet fields")
    for kind, count in sorted(kinds.items()):
        print(f"    {count:>3}  {kind}")
    print(f"    from {len(plan['observed_evidence_codes'])} distinct evidence codes")

    gated = [s for s in plan["fields"] if s["parent_code"]]
    print(f"    {len(gated)} fields are predicate-gated behind a parent evidence")


if __name__ == "__main__":
    main()
