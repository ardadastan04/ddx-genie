"""Turn-by-turn replays of one patient's conversation (for the demo and for failure analysis).

``build_replay(ep, ...)`` turns one episode (the CA's log format) into a self-contained dict: the
patient note, every trial's title and gold label, and per turn the question (with the variable's
``meaning``), the policy's score if it reported one, the answer, the waste label, and every trial's
status (eligible / ineligible / undetermined) and verdict after the turn. Statuses are recomputed by
replaying the answers into fresh ``TrialState`` objects, exactly as ``smtstate.runner`` builds them.

``format_replay(replay)`` prints it; ``scripts/demo_conversation.py`` is the command-line front end.
"""

from __future__ import annotations

import json
import textwrap
from functools import cache
from typing import Any

from . import metrics as M
from .policy_loading import ROOT

DATA = ROOT / "data"


@cache
def meanings(nct: str) -> dict[str, str]:
    path = DATA / "variables" / f"{nct}.json"
    rows = json.loads(path.read_text()) if path.exists() else []
    return {v["name"]: v.get("meaning", "") for v in rows}


@cache
def trial(nct: str) -> dict[str, Any]:
    return json.loads((DATA / "trials" / f"{nct}.json").read_text())


@cache
def _notes() -> dict[str, str]:
    return {p["qid"]: p["text"] for p in map(json.loads, (DATA / "patients.jsonl").open())}


def patient_note(qid: str) -> str:
    return _notes().get(qid, "")


def _statuses(ep: dict) -> tuple[dict[str, str], list[dict[str, str]]]:
    """Trial statuses before the first turn and after each turn."""
    from smtstate.state import TrialState

    states = {n: TrialState(n, {}) for n in ep["trials"]}
    current = {n: s.status() for n, s in states.items()}
    initial, after = dict(current), []
    for t in ep["turns"]:
        states[t["nct"]].answers[t["var"]] = t["answer"]
        current[t["nct"]] = states[t["nct"]].status()  # only the asked trial can change
        after.append(dict(current))
    return initial, after


def build_replay(ep: dict, policy: str, key: str, gold: dict[tuple[str, str], bool],
                 scores: list[float | None] | None = None) -> dict:
    """A replay dict for one episode (see module docstring). ``scores`` defaults to ``ep['scores']``."""
    qid = ep["qid"]
    scores = scores if scores is not None else ep.get("scores") or []
    initial, after = _statuses(ep)

    def trials_at(status: dict[str, str], verdicts: dict[str, str]) -> dict:
        return {n: {"status": status[n], "verdict": verdicts[n]} for n in ep["trials"]}

    turns = []
    for i, (t, st) in enumerate(zip(ep["turns"], after)):
        turns.append({
            "turn": i + 1, "nct": t["nct"], "var": t["var"],
            "meaning": meanings(t["nct"]).get(t["var"], ""),
            "score": scores[i] if i < len(scores) else None,
            "answer": t["answer"], "label": M.label(t),
            "trials": trials_at(st, t["verdicts"]),
        })
    final_status = after[-1] if after else initial
    return {
        "qid": qid, "policy": policy, "key": key,
        "patient_note": patient_note(qid),
        "trials": {n: {"title": trial(n).get("title", ""),
                       "gold": "eligible" if gold[(qid, n)] else "ineligible"}
                   for n in ep["trials"]},
        "initial": trials_at(initial, ep["initial_verdicts"]),
        "turns": turns,
        "final": trials_at(final_status, ep["final_verdicts"]),
    }


# ------------------------------------------------------------------ printing

_LABEL_TEXT = {"useful_answered": "useful, answered", "useful_unanswered": "useful, UNKNOWN",
               "not_useful": "not useful"}


def _mark(verdict: str, gold: str) -> str:
    return "✓" if verdict == gold else "✗"


def _trial_line(nct: str, t: dict, rp: dict) -> str:
    g = rp["trials"][nct]["gold"]
    return (f"  {nct}  {t['status']:<12} verdict {t['verdict']:<10} gold {g:<10} "
            f"{_mark(t['verdict'], g)}  {rp['trials'][nct]['title'][:60]}")


def _correct(trials: dict, rp: dict) -> int:
    return sum(t["verdict"] == rp["trials"][n]["gold"] for n, t in trials.items())


def format_replay(rp: dict, note_chars: int = 600) -> str:
    """Human-readable turn-by-turn view of a replay dict."""
    n = len(rp["trials"])
    out = [f"Patient {rp['qid']}: {n} candidate trials. Policy {rp['policy']}, answer key {rp['key']}.", ""]
    note = rp.get("patient_note", "")
    if note:
        short = note if len(note) <= note_chars else note[:note_chars].rsplit(" ", 1)[0] + " …"
        out += textwrap.wrap(short, 100, initial_indent="  ", subsequent_indent="  ") + [""]
    out += [f"Before any question ({_correct(rp['initial'], rp)}/{n} correct; undetermined counts as eligible):"]
    out += [_trial_line(c, t, rp) for c, t in rp["initial"].items()] + [""]
    prev = rp["initial"]
    for t in rp["turns"]:
        score = "" if t["score"] is None else f"  (score {t['score']:.3f})"
        ans = "unknown" if t["answer"] is None else json.dumps(t["answer"])
        out.append(f"Turn {t['turn']:>2}  [{t['nct']}] {t['meaning'] or t['var']}{score}")
        out.append(f"         var {t['var']}")
        out.append(f"         answer: {ans}   -> {_LABEL_TEXT[t['label']]}")
        for c, now in t["trials"].items():
            if now != prev[c]:
                g = rp["trials"][c]["gold"]
                out.append(f"         {c}: {prev[c]['status']} -> {now['status']} "
                           f"(verdict {now['verdict']}, gold {g} {_mark(now['verdict'], g)})")
        prev = t["trials"]
    out += ["", f"Final ({_correct(rp['final'], rp)}/{n} correct after {len(rp['turns'])} questions):"]
    out += [_trial_line(c, t, rp) for c, t in rp["final"].items()]
    return "\n".join(out)


# ------------------------------------------------------------------ criteria text lookup

_GENERIC = frozenset("""patient has have is are was the a an of in on to for with by at or and not now
value values recorded withunit diagnosis diagnosed finding findings undergone undergoing taking exposed
inthehistory inthepast history past current currently boolean indicating whether numeric number
documented known any other than more less who which that this their been being from within during prior
months month years year days day weeks week time""".split())  # noqa: SIM905


def _terms(text: str) -> set[str]:
    import re

    return {w for w in re.split(r"[^a-z0-9]+", text.lower()) if len(w) > 2 and w not in _GENERIC}


def _hit(term: str, words: set[str]) -> bool:
    """A term matches a word exactly, or by its first 5 letters for longer words (crude stemming)."""
    return term in words or (len(term) >= 5 and any(w[:5] == term[:5] for w in words))


def criteria_line(nct: str, var: str, meaning: str = "") -> tuple[str, str] | None:
    """The trial's criteria line that best mentions a variable: (section, line), or None.

    Scores each line of the inclusion and exclusion text by the variable-name terms it contains
    (weight 2) plus the ``meaning`` terms (weight 1); generic words (patient, has, now, ...) are
    ignored. Needs at least one name term to match.
    """
    name_terms = _terms(var.replace("@@", " "))
    meaning_terms = _terms(meaning) - name_terms
    best, best_score = None, 0
    for section in ("inclusion_criteria", "exclusion_criteria"):
        for line in str(trial(nct).get(section, "")).split("\n"):
            line = " ".join(line.split())
            words = _terms(line)
            if len(line.split()) < 3 or not words:
                continue
            n_name = sum(_hit(t, words) for t in name_terms)
            score = 2 * n_name + sum(_hit(t, words) for t in meaning_terms)
            if n_name and score > best_score:
                best, best_score = (section.split("_")[0], line), score
    return best
