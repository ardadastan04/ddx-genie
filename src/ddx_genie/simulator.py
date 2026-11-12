"""An LLM standing in for a DDXPlus patient.

The simulator is the measurement instrument, so its failure modes are the study's
failure modes. Three matter:

leakage
    Volunteering findings it was not asked about inflates evidence recall for both
    systems and destroys the comparison. The prompt forbids it and
    :func:`ddx_genie.harness` checks transcripts for it.
false positives
    Saying yes to something absent from the card creates findings that are not in the
    ground truth, which shows up as precision loss attributed to the agent.
breaking character
    17% of the subset's cards are clinically impossible (an 8-year-old with COPD,
    Parkinson's and alcohol addiction; three newborns who smoke). An LLM asked
    whether an infant smokes will tend to object or hedge. The prompt therefore tells
    it to answer from the card and never reason about plausibility.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any

from ddx_genie.cards import PatientCard
from ddx_genie.llm import LLMClient

MAX_REPLY_TOKENS = 120

SYSTEM_PROMPT = """You are role-playing a patient talking to a medical \
professional who is taking your history. Stay in character for the whole \
conversation.

{card}

HOW TO ANSWER

1. Answer ONLY what you are asked. Never volunteer a symptom you were not asked \
about, even if it is on your list above. If you are asked an open question like \
"what's bothering you?", give only your reason for coming in.

2. If you are asked about something that IS on your list, confirm it and give the \
detail shown.

3. If you are asked about something that is NOT on your list, say no. You do not \
have it. Do not hedge, do not say "maybe", do not speculate.

4. Speak like an ordinary person, in one or two short sentences. Use everyday words, \
not medical terms. Say "I can't catch my breath", not "I have dyspnoea".

5. Never name a disease or diagnosis, never guess what you have, and never use \
medical codes or numbers from your list. If asked what you think it is, say you \
don't know and that's why you came in.

6. For a 0-to-10 rating, just give the number shown on your list.

7. Your list is the complete and literal truth about you. Do not question whether it \
is medically realistic, do not point out anything surprising about your age or your \
conditions, and never break character to comment on it. If a question seems odd for \
someone like you, answer it from the list anyway, plainly.

8. If you are told the interview is over, reply briefly and naturally."""


@dataclass
class SimulatedPatient:
    """A patient driven by one decoded card. Holds its own conversation history."""

    card: PatientCard
    client: LLMClient
    model: str = "cheap"
    history: list[dict[str, str]] = field(default_factory=list)

    @property
    def system_prompt(self) -> str:
        return SYSTEM_PROMPT.format(card=self.card.prompt_block())

    def reply(self, agent_utterance: str) -> str:
        """Answer one question from the interviewer."""
        self.history.append({"role": "user", "content": agent_utterance})
        completion = self.client.complete(
            [{"role": "system", "content": self.system_prompt}, *self.history],
            model=self.model,
            tag="simulator",
            max_tokens=MAX_REPLY_TOKENS,
        )
        text = completion.text.strip() or "Sorry, I'm not sure."
        self.history.append({"role": "assistant", "content": text})
        return text

    def as_json(self) -> dict[str, Any]:
        return {"row_index": self.card.row_index, "turns": len(self.history) // 2}


def _main() -> None:
    """Ask one card five scripted questions, to eyeball it before any batch run."""
    import argparse
    import json
    from pathlib import Path

    from ddx_genie.cards import CARDS_DIR, PatientCard
    from ddx_genie.cards import Finding

    parser = argparse.ArgumentParser(description="Smoke-test the patient simulator.")
    parser.add_argument("--card", help="path to a patient card JSON")
    parser.add_argument("--run-id", default="simtest")
    args = parser.parse_args()

    path = Path(args.card) if args.card else sorted(CARDS_DIR.glob("*.json"))[0]
    raw = json.loads(path.read_text())
    card = PatientCard(
        row_index=raw["row_index"], age=raw["age"], sex=raw["sex"],
        chief_complaint=raw["chief_complaint"],
        findings=[Finding(**f) for f in raw["findings"]],
        pathology=raw["pathology"], differential=raw["differential"],
    )

    questions = [
        "Hello, what's been bothering you?",
        "Do you have a cough?",
        "Have you had any pain in your knees?",      # absent -> must be denied
        "If 0 is none and 10 is the worst, how bad is any pain?",
        "Do you think you might have pneumonia?",    # must refuse to diagnose
    ]

    patient = SimulatedPatient(card=card, client=LLMClient(args.run_id))
    print(f"card: {path.name}  (true pathology: {card.pathology}, age {card.age})")
    print(f"chief complaint on card: {card.chief_complaint}\n")
    for question in questions:
        print(f"Doctor : {question}")
        print(f"Patient: {patient.reply(question)}\n")
    print(patient.client.summary())


if __name__ == "__main__":
    _main()
