"""The diagnosis step, shared by both systems under comparison.

Deliberately lives here rather than inside ``genie/agent.py``: the Genie agent and
the T8 function-calling baseline must use the *same* prompt and the *same* model to
produce their differential, or the comparison measures prompt differences instead of
architecture differences. The only thing that differs between systems is how the
evidence was elicited.
"""

from __future__ import annotations

import json
import os
import re
from dataclasses import dataclass
from typing import Any

from ddx_genie.llm import LLMClient
from ddx_genie.subset import CONDITIONS

TOP_K = 5

SYSTEM_PROMPT = """You are a diagnostic reasoning engine. Given the findings \
collected during a clinical interview, rank the most likely diagnoses.

You must choose ONLY from this closed list of conditions:
{conditions}

Rules:
- Return exactly {top_k} conditions, ordered most to least likely.
- Assign each a probability. The {top_k} probabilities must sum to 1.0.
- Use only the findings given. Do not invent findings.
- "not reported" means the question was never asked, which is not the same as a \
negative answer. Treat it as unknown, not as absent.
- Reply with JSON only, no prose, in exactly this form:
  {{"differential": [{{"condition": "<name>", "probability": 0.0}}]}}"""


@dataclass
class Differential:
    """A ranked differential restricted to the study's condition set."""

    ranked: list[tuple[str, float]]
    raw: str

    @property
    def top1(self) -> str | None:
        return self.ranked[0][0] if self.ranked else None

    @property
    def top3(self) -> list[str]:
        return [name for name, _ in self.ranked[:3]]

    def as_json(self) -> list[dict[str, Any]]:
        return [{"condition": c, "probability": p} for c, p in self.ranked]

    def __str__(self) -> str:
        if not self.ranked:
            return "no differential could be produced"
        return ", ".join(f"{c} ({p:.0%})" for c, p in self.ranked)


def format_findings(findings: dict[str, Any]) -> str:
    """Render collected findings for the prompt, marking unasked fields explicitly.

    The distinction matters: an agent that asked 12 of 58 questions should not have
    its 46 unasked fields read as 46 negative findings.
    """
    if not findings:
        return "No findings were collected."
    lines = []
    for name, value in findings.items():
        if value is None:
            continue
        lines.append(f"- {name}: {value}")
    return "\n".join(lines) if lines else "No findings were collected."


_QUOTES = str.maketrans({"‘": "'", "’": "'", "“": '"', "”": '"'})


def _norm_name(name: str) -> str:
    """Case-, whitespace- and curly-quote-insensitive key for matching names."""
    return " ".join(name.translate(_QUOTES).lower().split())


def _load_json(text: str) -> Any:
    """Parse JSON from LLM output, tolerating fences and surrounding prose. None on failure."""
    payload = text.strip()
    if match := re.search(r"```(?:json)?\s*(.*?)```", payload, re.DOTALL):
        payload = match.group(1).strip()
    try:
        return json.loads(payload)
    except json.JSONDecodeError:
        pass
    # Only carve out a JSON region when the whole payload is not already valid;
    # carving unconditionally turns a bare array into its first object.
    for opener, closer in (("[", "]"), ("{", "}")):
        start, end = payload.find(opener), payload.rfind(closer)
        if start != -1 and end > start:
            try:
                return json.loads(payload[start : end + 1])
            except json.JSONDecodeError:
                continue
    return None


def _parse_differential(text: str, conditions: tuple[str, ...]) -> list[tuple[str, float]]:
    """Extract and normalise the ranked list, tolerating fenced or chatty output."""
    parsed = _load_json(text)
    if parsed is None:
        return []
    entries = parsed.get("differential", parsed) if isinstance(parsed, dict) else parsed
    if not isinstance(entries, list):
        return []

    # Match loosely on name, since the model may vary punctuation or casing.
    lookup = {_norm_name(c): c for c in conditions}
    ranked: list[tuple[str, float]] = []
    for entry in entries:
        if not isinstance(entry, dict):
            continue
        name = str(entry.get("condition", "")).strip()
        canonical = lookup.get(_norm_name(name))
        if canonical is None and name:
            # Prefix fallback only when unambiguous: MCQ options often share a long
            # prefix ("Traveler's diarrhea due to ETEC" / "... due to Norovirus").
            prefix = _norm_name(name)[:12]
            hits = [c for c in conditions if _norm_name(c).startswith(prefix)]
            canonical = hits[0] if len(hits) == 1 else None
        if canonical is None or any(canonical == r[0] for r in ranked):
            continue
        try:
            probability = float(entry.get("probability", 0.0))
        except (TypeError, ValueError):
            probability = 0.0
        ranked.append((canonical, probability))

    total = sum(p for _, p in ranked)
    if total > 0:
        ranked = [(c, p / total) for c, p in ranked]
    return ranked[:TOP_K]


def diagnose_findings(
    findings: dict[str, Any],
    *,
    client: LLMClient,
    conditions: tuple[str, ...] = CONDITIONS,
    model: str = "cheap",
    tag: str = "diagnose",
) -> Differential:
    """One LLM call turning collected findings into a ranked differential."""
    return _diagnose(format_findings(findings), client=client, conditions=conditions,
                     model=model, tag=tag)


def format_facts(facts: list[str]) -> str:
    """Render free-text facts (MediQ) the way ``format_findings`` renders fields."""
    lines = [f"- {f}" for f in facts if f.strip()]
    return "\n".join(lines) if lines else "No findings were collected."


def diagnose_facts(
    facts: list[str],
    *,
    client: LLMClient,
    conditions: tuple[str, ...],
    model: str = "cheap",
    tag: str = "diagnose",
) -> Differential:
    """Same prompt and model as :func:`diagnose_findings`, for free-text facts.

    For MediQ, ``conditions`` is the question's answer options, so the closed list
    the prompt enforces is the multiple-choice set.
    """
    return _diagnose(format_facts(facts), client=client, conditions=conditions,
                     model=model, tag=tag)


def _diagnose(
    rendered: str,
    *,
    client: LLMClient,
    conditions: tuple[str, ...],
    model: str,
    tag: str,
) -> Differential:
    # Capped so a 4-option MCQ isn't asked for 5 conditions. For DDXPlus (6
    # conditions) this is still 5, so the prompt and its cache keys are unchanged.
    top_k = min(TOP_K, len(conditions))
    system = SYSTEM_PROMPT.format(
        conditions="\n".join(f"- {c}" for c in conditions), top_k=top_k
    )
    completion = client.complete(
        [
            {"role": "system", "content": system},
            {"role": "user", "content": f"Findings from the interview:\n{rendered}"},
        ],
        model=model,
        tag=tag,
        max_tokens=512,
    )
    return Differential(
        ranked=_parse_differential(completion.text, conditions), raw=completion.text
    )


# --------------------------------------------------- Genie worksheet entry point


_DEFAULT_CLIENT: LLMClient | None = None


def set_client(client: LLMClient) -> None:
    """Install the client the worksheet action should log against."""
    global _DEFAULT_CLIENT
    _DEFAULT_CLIENT = client


def _client() -> LLMClient:
    global _DEFAULT_CLIENT
    if _DEFAULT_CLIENT is None:
        _DEFAULT_CLIENT = LLMClient(os.getenv("DDX_RUN_ID", "manual"))
    return _DEFAULT_CLIENT


def worksheet_findings(worksheet: Any) -> dict[str, Any]:
    """Read the filled fields off a Genie worksheet instance.

    Unfilled fields are omitted rather than reported as negatives, so the diagnosis
    sees what was actually elicited.
    """
    from worksheets.utils.field import get_genie_fields_from_ws

    findings: dict[str, Any] = {}
    for field in get_genie_fields_from_ws(worksheet):
        if field.name == "differential" or getattr(field, "internal", False):
            continue
        value = getattr(field, "value", None)
        if value is None:
            continue
        # Enum members carry the decoded text on `.name`.
        findings[field.name] = getattr(value, "name", value)
    return findings


def diagnose(worksheet: Any) -> str:
    """The ``diagnose`` API registered with Genie and called from the Form Action."""
    differential = diagnose_findings(worksheet_findings(worksheet), client=_client())
    return str(differential)


# ------------------------------------------------- open-ended differential (MediQ)
#
# Clinicians are not handed four options. In this mode the model names its own
# differential, and a separate judge call decides which entry (if any) is the gold
# diagnosis. Both prompts are shared by every arm, like SYSTEM_PROMPT above.

OPEN_SYSTEM_PROMPT = """You are a diagnostic reasoning engine. Given the findings \
collected so far about a patient, give your differential diagnosis.

Rules:
- Return exactly {top_k} distinct diagnoses, ordered most to least likely.
- Name each as a specific disease or syndrome, as precisely as the findings allow \
(e.g. "Cerebral venous sinus thrombosis", not "Neurological disorder"). Include the \
cause or subtype when the findings support it.
- Assign each a probability. The {top_k} probabilities must sum to 1.0.
- Use only the findings given. Do not invent findings.
- Findings that are not mentioned are unknown, not negative.
- Reply with JSON only, no prose, in exactly this form:
  {{"differential": [{{"diagnosis": "<name>", "probability": 0.0}}]}}"""

JUDGE_SYSTEM_PROMPT = """You grade a differential diagnosis against the correct \
answer. You are not diagnosing. For EACH candidate, independently of the others, \
state how it relates to the correct diagnosis:

- "same": the same condition (synonym, abbreviation, eponym, alternative name).
- "more_specific": a specific form, subtype or cause of the correct diagnosis \
(correct "Cerebral venous thrombosis", candidate "Lateral sinus thrombosis").
- "broader": a wider category that loses what makes the correct diagnosis distinct \
(correct "Non-exertional heat stroke", candidate "Heat stroke"; correct "Traveler's \
diarrhea due to ETEC", candidate "Infectious diarrhea").
- "different": any other condition, including related or similar ones.

Judge every candidate on its own; another candidate in the list never changes a \
verdict. Reply with JSON only, one entry per candidate, in order:
{"verdicts": [{"candidate": 1, "relation": "same|more_specific|broader|different"}], \
"reason": "<one short sentence about the best match>"}"""


RELATIONS = ("same", "more_specific", "broader", "different")
#: Relations that count as naming the gold diagnosis (strict scoring).
MATCHING = frozenset({"same", "more_specific"})


@dataclass
class Judgement:
    #: Per-candidate relation to gold, in differential order.
    relations: list[str]
    reason: str
    raw: str
    parse_ok: bool = True

    def _first(self, accepted: frozenset[str]) -> int | None:
        return next((i for i, r in enumerate(self.relations, 1) if r in accepted), None)

    @property
    def match_rank(self) -> int | None:
        """Strict: 1-based rank of the first same / more-specific candidate."""
        return self._first(MATCHING)

    @property
    def lenient_rank(self) -> int | None:
        """Also accepts a broader category (e.g. "Heat stroke" for non-exertional)."""
        return self._first(MATCHING | {"broader"})


def _parse_open_differential(text: str) -> list[tuple[str, float]]:
    """Free-text names, deduplicated, probabilities renormalised."""
    parsed = _load_json(text)
    entries = parsed.get("differential", parsed) if isinstance(parsed, dict) else parsed
    if not isinstance(entries, list):
        return []
    ranked: list[tuple[str, float]] = []
    seen: set[str] = set()
    for entry in entries:
        if not isinstance(entry, dict):
            continue
        name = str(entry.get("diagnosis") or entry.get("condition") or "").strip()
        if not name or _norm_name(name) in seen:
            continue
        seen.add(_norm_name(name))
        try:
            probability = float(entry.get("probability", 0.0))
        except (TypeError, ValueError):
            probability = 0.0
        ranked.append((name, max(probability, 0.0)))
    total = sum(p for _, p in ranked)
    if total > 0:
        ranked = [(c, p / total) for c, p in ranked]
    return ranked[:TOP_K]


def _parse_judgement(text: str, n_candidates: int) -> Judgement:
    """Read per-candidate verdicts. Missing or unknown verdicts become "different"."""
    parsed = _load_json(text)
    verdicts = parsed.get("verdicts") if isinstance(parsed, dict) else None
    if not isinstance(verdicts, list):
        return Judgement(relations=["different"] * n_candidates,
                         reason="unparseable judge output", raw=text, parse_ok=False)
    relations = ["different"] * n_candidates
    seen = 0
    for position, entry in enumerate(verdicts, 1):
        if not isinstance(entry, dict):
            continue
        try:
            idx = int(entry.get("candidate", position))
        except (TypeError, ValueError):
            idx = position
        relation = str(entry.get("relation", "")).strip().lower().replace("-", "_")
        if 1 <= idx <= n_candidates and relation in RELATIONS:
            relations[idx - 1] = relation
            seen += 1
    return Judgement(relations=relations, reason=str(parsed.get("reason", "")), raw=text,
                     parse_ok=seen == n_candidates)


def diagnose_open(
    facts: list[str], *, client: LLMClient, model: str = "cheap", tag: str = "diagnose_open"
) -> Differential:
    """Open-ended top-``TOP_K`` differential from free-text facts. No option list."""
    completion = client.complete(
        [
            {"role": "system", "content": OPEN_SYSTEM_PROMPT.format(top_k=TOP_K)},
            {"role": "user", "content": f"Findings so far:\n{format_facts(facts)}"},
        ],
        model=model,
        tag=tag,
        max_tokens=512,
    )
    return Differential(ranked=_parse_open_differential(completion.text), raw=completion.text)


def judge_differential(
    candidates: list[str], gold: str, *, client: LLMClient, model: str = "cheap", tag: str = "judge"
) -> Judgement:
    """One call: each candidate's relation to the gold diagnosis."""
    if not candidates:
        return Judgement(relations=[], reason="empty differential", raw="", parse_ok=False)
    listing = "\n".join(f"{i}. {c}" for i, c in enumerate(candidates, 1))
    completion = client.complete(
        [
            {"role": "system", "content": JUDGE_SYSTEM_PROMPT},
            {"role": "user", "content": f"Correct diagnosis: {gold}\n\nCandidates:\n{listing}"},
        ],
        model=model,
        tag=tag,
        max_tokens=400,
    )
    return _parse_judgement(completion.text, len(candidates))
