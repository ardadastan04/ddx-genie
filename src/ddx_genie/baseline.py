"""The comparison system: a plain function-calling agent over the same field list.

This is the control. It gets the identical patient simulator, turn cap, model and
diagnosis prompt as the Genie arm; the only difference is that it has no worksheet.
Instead it sees two tools over the same 58 fields and decides for itself what to ask
and when to stop. Whatever difference the study measures should therefore be
attributable to the declarative specification, not to the surrounding harness.

Notably it is given the same field *descriptions* Genie gets, so it is not
handicapped by having to guess what is recordable.
"""

from __future__ import annotations

import json
from typing import Any

from ddx_genie.diagnosis import Differential, diagnose_findings
from ddx_genie.llm import LLMClient
from ddx_genie.subset import PROCESSED_DIR

SYSTEM_PROMPT = """You are a clinical intake assistant interviewing a patient. Build \
a structured record for a clinician.

Each turn you must do two things:
1. Call record_evidence for every finding the patient just reported, including \
denials (value false). A denial is information; omitting it loses that information.
2. Ask the patient exactly ONE new question, in plain everyday language.

Rules:
- One question per turn. A stacked question yields one answer and several gaps.
- Never ask about a field you have already recorded, including ones recorded false.
- Prioritise questions that discriminate between respiratory conditions. Ask about \
presenting symptoms before past medical history.
- Never state or hint at a diagnosis during the interview, and never give medical \
advice.
- Call diagnose only when you have enough to rank the conditions, or when told the \
interview is ending.
- Keep each utterance to one or two sentences.

These are the fields you may record. Use these names exactly:
{fields}"""

TOOLS: list[dict[str, Any]] = [
    {
        "type": "function",
        "function": {
            "name": "record_evidence",
            "description": (
                "Record one finding reported by the patient. Use it for denials too, "
                "with the value false or 'no'."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "name": {
                        "type": "string",
                        "description": "The field name, exactly as listed.",
                    },
                    "value": {
                        "type": "string",
                        "description": (
                            "true/false for yes-no fields, an integer 0-10 for scale "
                            "fields, or the exact option text for choice fields."
                        ),
                    },
                },
                "required": ["name", "value"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "diagnose",
            "description": "Produce the final differential diagnosis and end the interview.",
            "parameters": {"type": "object", "properties": {}},
        },
    },
]


def load_field_descriptions() -> str:
    """The same field list and descriptions the Genie worksheet exposes."""
    plan = json.loads((PROCESSED_DIR / "field_list.json").read_text())
    lines = []
    for spec in plan["fields"]:
        if spec["name"] == "differential":
            continue
        kind = spec["kind"]
        if kind == "enum":
            kind = f"one of: {', '.join(spec['enum_values'])}"
        elif kind == "int":
            kind = f"integer {spec.get('min_value', 0)}-{spec.get('max_value', 10)}"
        lines.append(f"- {spec['name']} ({kind}): {spec['description']}")
    return "\n".join(lines)


def coerce(value: str) -> Any:
    """Normalise a tool-call value the way the worksheet's types would."""
    text = str(value).strip()
    lowered = text.lower()
    if lowered in {"true", "yes", "y"}:
        return True
    if lowered in {"false", "no", "n"}:
        return False
    try:
        return int(text)
    except ValueError:
        return text


class BaselineSystem:
    """Function-calling intake agent, implementing the harness's System protocol."""

    name = "baseline"

    OPENING = (
        "Hello, I'm here to take some details about your symptoms before you see a "
        "clinician. What's been bothering you?"
    )

    def __init__(self, client: LLMClient, *, model: str = "cheap") -> None:
        self._client = client
        self._model = model
        self._findings: dict[str, Any] = {}
        self._differential: Differential | None = None
        self._messages: list[dict[str, Any]] = [
            {
                "role": "system",
                "content": SYSTEM_PROMPT.format(fields=load_field_descriptions()),
            },
            {"role": "assistant", "content": self.OPENING},
        ]

    def start(self) -> str:
        return self.OPENING

    async def respond(self, patient_utterance: str) -> str:
        self._messages.append({"role": "user", "content": patient_utterance})

        # Let the model record findings before it speaks: tool calls first, then the
        # question. Bounded so a model that loops on tool calls cannot stall a run.
        for _ in range(6):
            completion = self._client.complete(
                self._messages,
                model=self._model,
                tag="baseline",
                max_tokens=600,
                tools=TOOLS,
            )
            calls = completion.tool_calls or []
            if not calls:
                break
            self._messages.append(
                {
                    # Gemini's OpenAI-compatible layer rejects a null content here,
                    # unlike OpenAI itself; an empty string is accepted by both.
                    "role": "assistant",
                    "content": completion.text or "",
                    "tool_calls": calls,
                }
            )
            for call in calls:
                name = call["function"]["name"]
                try:
                    args = json.loads(call["function"].get("arguments") or "{}")
                except json.JSONDecodeError:
                    args = {}
                if name == "record_evidence" and args.get("name"):
                    self._findings[str(args["name"])] = coerce(args.get("value", ""))
                    result = "recorded"
                elif name == "diagnose":
                    self._differential = diagnose_findings(
                        self._findings, client=self._client, model=self._model
                    )
                    result = str(self._differential)
                else:
                    result = f"unknown tool {name}"
                self._messages.append(
                    {"role": "tool", "tool_call_id": call.get("id", ""), "content": result}
                )
            if self._differential is not None:
                break

        text = (completion.text or "").strip()
        if not text:
            # The model spent its turn on tool calls; prompt it for the question.
            follow_up = self._client.complete(
                [*self._messages, {"role": "user", "content": "Ask your next question."}],
                model=self._model,
                tag="baseline",
                max_tokens=200,
            )
            text = follow_up.text.strip() or "Is there anything else you've noticed?"
        self._messages.append({"role": "assistant", "content": text})
        return text

    def findings(self) -> dict[str, Any]:
        return dict(self._findings)

    def differential(self) -> Differential | None:
        return self._differential
