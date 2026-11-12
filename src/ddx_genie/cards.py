"""Decode each subset patient into a plain-English card.

The card is the only thing the simulated patient in T6 ever sees, so it must contain
every finding in plain language and no raw ``E_`` or ``V_`` codes — a leaked code is
an instant tell that the "patient" is a language model reading a spreadsheet. It must
also never name the pathology: the agent's job is to infer it.

Cards are written both as JSON (for the simulator) and as readable text (for a human
to play from by hand in T5).
"""

from __future__ import annotations

import json
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any

from ddx_genie.subset import (
    EXCLUDED_GROUPS,
    PROCESSED_DIR,
    REPO_ROOT,
    decode_value,
    is_numeric_scale,
    load_json,
)

CARDS_DIR = PROCESSED_DIR / "patient_cards"

SEX_WORDS = {"M": "male", "F": "female"}


@dataclass
class Finding:
    """One decoded evidence: the question a clinician asks and the patient's answer."""

    code: str
    question: str
    answer: str
    is_antecedent: bool
    is_chief_complaint: bool


@dataclass
class PatientCard:
    row_index: int
    age: int
    sex: str
    chief_complaint: str
    findings: list[Finding]
    #: Kept for scoring only. Never shown to the simulated patient.
    pathology: str
    differential: list[dict[str, Any]]

    def as_json(self) -> dict[str, Any]:
        return {
            "row_index": self.row_index,
            "age": self.age,
            "sex": self.sex,
            "chief_complaint": self.chief_complaint,
            "findings": [asdict(f) for f in self.findings],
            "pathology": self.pathology,
            "differential": self.differential,
        }

    def prompt_block(self) -> str:
        """The card as the simulator sees it: no pathology, no differential, no codes."""
        sex = SEX_WORDS.get(self.sex, self.sex)
        lines = [
            f"You are a {self.age}-year-old {sex} patient.",
            "",
            f"Why you came in: {self.chief_complaint}",
            "",
            "Everything that is true about you:",
        ]
        symptoms = [f for f in self.findings if not f.is_antecedent]
        history = [f for f in self.findings if f.is_antecedent]
        for finding in symptoms:
            lines.append(f"  - {finding.question} -> {finding.answer}")
        if history:
            lines.append("")
            lines.append("Your medical history and background:")
            for finding in history:
                lines.append(f"  - {finding.question} -> {finding.answer}")
        return "\n".join(lines)

    def human_text(self) -> str:
        """The readable card, including the answer key, for playing by hand."""
        header = f"PATIENT (DDXPlus test row {self.row_index})"
        key = [
            "",
            "-" * 70,
            "ANSWER KEY (do not reveal while role-playing)",
            f"  true pathology: {self.pathology}",
            "  ground-truth differential:",
        ]
        for entry in self.differential[:8]:
            key.append(f"    {entry['probability']:.3f}  {entry['pathology']}")
        if len(self.differential) > 8:
            key.append(f"    ... and {len(self.differential) - 8} more")
        return "\n".join([header, "=" * 70, "", self.prompt_block(), *key, ""])


def answer_text(evidence: dict[str, Any], value: str | None) -> str:
    """Render one evidence value as a patient-facing answer."""
    if value is None:
        return "yes"
    if is_numeric_scale(evidence):
        values = evidence.get("possible-values") or []
        return f"{value} out of {max(values)}" if values else str(value)
    return decode_value(evidence, value)


def build_card(record: dict[str, Any], evidences: dict[str, Any]) -> PatientCard:
    """Decode one subset record into a card."""
    initial = record["initial_evidence"]
    grouped: dict[str, list[str]] = {}
    order: list[str] = []
    for item in record["evidences"]:
        code = item["code"]
        if code not in grouped:
            grouped[code] = []
            order.append(code)
        rendered = answer_text(evidences[code], item["value"])
        if rendered not in grouped[code]:
            grouped[code].append(rendered)

    findings: list[Finding] = []
    for code in order:
        evidence = evidences[code]
        answers = [a for a in grouped[code] if a != "nowhere"] or grouped[code]
        findings.append(
            Finding(
                code=code,
                question=evidence["question_en"],
                answer=", ".join(answers),
                is_antecedent=bool(evidence.get("is_antecedent")),
                is_chief_complaint=(code == initial),
            )
        )

    chief = _pick_chief_complaint(findings, evidences)
    chief_text = _complaint_sentence(chief) if chief else "feeling unwell"

    return PatientCard(
        row_index=record["row_index"],
        age=record["age"],
        sex=record["sex"],
        chief_complaint=chief_text,
        findings=findings,
        pathology=record["pathology"],
        differential=record["differential"],
    )


def _is_excluded(code: str, evidences: dict[str, Any]) -> bool:
    group = evidences.get(code, {}).get("code_question")
    return group in EXCLUDED_GROUPS or code in EXCLUDED_GROUPS


def _pick_chief_complaint(
    findings: list[Finding], evidences: dict[str, Any]
) -> Finding | None:
    """The opening complaint, preferring DDXPlus's own INITIAL_EVIDENCE.

    Three of the 60 patients have an initial evidence inside an excluded group, so
    they would open by volunteering something the worksheet has no field for and
    neither system could ever record. Those fall back to their first recordable
    symptom instead, keeping the conversation scorable.
    """
    initial = next((f for f in findings if f.is_chief_complaint), None)
    if initial is not None and not _is_excluded(initial.code, evidences):
        return initial
    for finding in findings:
        if not finding.is_antecedent and not _is_excluded(finding.code, evidences):
            return finding
    return initial or (findings[0] if findings else None)


def _complaint_sentence(finding: Finding) -> str:
    """Turn the initial evidence into something a patient would volunteer.

    The raw form is a clinician's yes/no question, which a patient would never say
    aloud, so strip the interrogative framing and keep the substance.
    """
    question = finding.question.rstrip("?").strip()
    for prefix in (
        "Do you have ",
        "Do you ",
        "Are you ",
        "Have you ",
        "Did you ",
        "Is your ",
        "Does your ",
    ):
        if question.startswith(prefix):
            question = question[len(prefix) :]
            break
    if finding.answer not in {"yes", "nowhere"}:
        return f"{question} ({finding.answer})"
    return question


def build_cards(
    subset_path: Path | None = None, out_dir: Path = CARDS_DIR
) -> list[PatientCard]:
    """Decode every subset patient and write JSON + text cards."""
    subset_path = subset_path or PROCESSED_DIR / "subset.jsonl"
    if not subset_path.exists():
        raise FileNotFoundError(
            f"{subset_path} is missing; run `python -m ddx_genie.subset` first"
        )
    evidences = load_json("release_evidences.json")
    records = [json.loads(line) for line in subset_path.read_text().splitlines() if line]

    out_dir.mkdir(parents=True, exist_ok=True)
    cards = [build_card(record, evidences) for record in records]
    for card in cards:
        stem = f"patient_{card.row_index:06d}"
        (out_dir / f"{stem}.json").write_text(
            json.dumps(card.as_json(), indent=2, ensure_ascii=False, sort_keys=True) + "\n"
        )
        (out_dir / f"{stem}.txt").write_text(card.human_text())
    return cards


def assert_no_codes(cards: list[PatientCard]) -> None:
    """Fail loudly if any raw DDXPlus code survived into a card's prompt block."""
    import re

    pattern = re.compile(r"\b[EV]_\d+\b")
    for card in cards:
        if leaked := pattern.findall(card.prompt_block()):
            raise AssertionError(
                f"patient {card.row_index} leaks raw codes into its prompt: "
                f"{sorted(set(leaked))}"
            )


def main() -> None:
    cards = build_cards()
    assert_no_codes(cards)
    print(f"wrote {len(cards) * 2} files to {CARDS_DIR.relative_to(REPO_ROOT)}/")
    print(f"  {len(cards)} patients, no raw E_/V_ codes in any prompt block")
    counts = [len(c.findings) for c in cards]
    print(f"  findings per card: min {min(counts)}, median "
          f"{sorted(counts)[len(counts) // 2]}, max {max(counts)}")

    for card in cards[:3]:
        print("\n" + "=" * 72)
        print(card.human_text())


if __name__ == "__main__":
    main()
