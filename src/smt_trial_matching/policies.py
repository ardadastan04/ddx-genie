"""Our question-asking policies (the CA's live in baselines/policies.py and stay untouched).

Signature, as the CA's: ``policy(states, asked, rng) -> (nct, var) | None``.

Answer-key access (leakage guard): ordinary policies never see the simulator's answer key, so they
cannot peek at which questions will be answered. A policy that deliberately cheats, to give an upper
bound, declares it with a ``for_patient(qid, sim)`` attribute; the harness then calls it once per
patient to build the policy actually used, and labels it an oracle. Nothing else gets the key.
"""

from __future__ import annotations

from collections.abc import Callable
from functools import partial
from typing import Any


def _undetermined(states: dict) -> list[str]:
    return [n for n, s in states.items() if s.status() == "undetermined"]


def _greedy_score(res: dict) -> int:
    """baselines.policies.greedy_smt's score: 2 per deciding Bool outcome, +1 for Bool."""
    outcomes = [r for k, r in res.items() if k in (True, False)]
    return 2 * sum(r != "undetermined" for r in outcomes) + (1 if outcomes else 0)


def _oracle_answerable_greedy(states: dict, asked: set, rng: Any, *,
                              answerable: Callable[[str, str], bool]) -> tuple[str, str] | None:
    best, best_score = None, -1
    for n in _undetermined(states):
        for v, res in states[n].informative():
            if (n, v) in asked or not answerable(n, v):
                continue
            score = _greedy_score(res)
            if score > best_score:
                best, best_score = (n, v), score
    return best


def oracle_answerable_greedy(states: dict, asked: set, rng: Any) -> tuple[str, str] | None:
    """ORACLE (reads the answer key): greedy_smt restricted to questions the key can answer.

    The upper bound for any "prefer answerable questions" policy: same choice and tie-breaking as
    greedy_smt, but questions whose answer would be unknown are skipped (an unknown answer never
    changes a trial's status). Stops when no answerable informative question is left.
    """
    raise RuntimeError("oracle_answerable_greedy needs the answer key; run it through the harness")


def _bind_oracle(qid: str, sim: Any) -> Callable:
    return partial(_oracle_answerable_greedy,
                   answerable=lambda nct, var: sim.answer(qid, nct, var) is not None)


oracle_answerable_greedy.for_patient = _bind_oracle  # type: ignore[attr-defined]
