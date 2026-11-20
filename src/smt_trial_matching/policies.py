"""Our question-asking policies (the CA's live in baselines/policies.py and stay untouched).

Signature, as the CA's: ``policy(states, asked, rng) -> (nct, var) | None``.

Answer-key access (leakage guard): ordinary policies never see the simulator's answer key, so they
cannot peek at which questions will be answered. A policy that deliberately cheats, to give an upper
bound, declares it with a ``for_patient(qid, sim)`` attribute; the harness then calls it once per
patient to build the policy actually used, and labels it an oracle. Nothing else gets the key.
"""

from __future__ import annotations

from collections.abc import Callable
from dataclasses import dataclass
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
    """ORACLE (reads the answer key): the answerable-greedy oracle reference.

    greedy_smt restricted to questions the key can answer: same choice and tie-breaking as
    greedy_smt, but questions whose answer would be unknown are skipped (an unknown answer never
    changes a trial's status). Stops when no answerable informative question is left.

    Not a ceiling for other policies: it keeps greedy_smt's scoring, and answerable_informative
    (a different scoring, no key) already beats it on dev AUC (0.700 vs 0.686). The matching
    reference for answerable_informative is ``answerable_informative_oracle``.
    """
    raise RuntimeError("oracle_answerable_greedy needs the answer key; run it through the harness")


def _bind_oracle(qid: str, sim: Any) -> Callable:
    return partial(_oracle_answerable_greedy,
                   answerable=lambda nct, var: sim.answer(qid, nct, var) is not None)


oracle_answerable_greedy.for_patient = _bind_oracle  # type: ignore[attr-defined]


# --------------------------------------------------------------------------------------------------
# Answerable-informative policy (Person A, Nov 18): informativeness weighted by predicted answerability


@dataclass(frozen=True)
class AnswerableConfig:
    """Weights for the value of a possible answer. Frozen as policy-v1 after dev tuning."""

    w_ineligible: float = 1.0  # the answer would make the trial ineligible (the only verdict flip)
    # Per share of the trial's open cohorts the answer would rule out. 1.0 (was 0.5, Nov 18): ruling out
    # every open cohort is then worth as much as making the trial ineligible, which it is. Chosen on
    # principle: the dev sweep (scripts/sweep_cohort_credit.py; 0.5/0.7/0.9/1.0) moved acc@30 by one pair.
    w_cohort: float = 1.0
    w_eligible: float = 0.2  # the answer would make the trial certainly eligible (ends its questions)
    w_numeric: float = 0.3  # fallback for a number with no value distribution (see _numeric_value)
    # Ablation switches (Nov 19, Person B; defaults = the policy as tuned):
    use_answerability: bool = True  # False: P(answered) = 1 for every variable (informativeness x value)
    use_value: bool = True  # False: value = 1 if some answer could decide something, else 0 (answerability only)


def _answer_value(state: Any, var: str, val: bool | float, open_cohorts: list[str],
                  cfg: AnswerableConfig) -> float:
    """Value of learning ``var = val`` (a Bool or a number) for one trial, from its cohort
    statuses after the answer."""
    after = state.cohort_status({**state.answers, var: val})
    if all(s == "ineligible" for s in after.values()):
        return cfg.w_ineligible
    if any(s == "eligible" for s in after.values()):
        return cfg.w_eligible
    knocked = sum(after[c] == "ineligible" for c in open_cohorts)
    return cfg.w_cohort * knocked / len(open_cohorts)


def _numeric_value(state: Any, var: str, open_cohorts: list[str], model: Any,
                   cfg: AnswerableConfig) -> float:
    """Expected value of asking a number, e.g. age.

    AGE SCORING (Nov 18): a number used to get the flat ``w_numeric``, so age (almost always
    answerable) outranked every Bool question even when no plausible age could change the trial
    (e.g. 18-65 for a typical adult). Now, when the model has a value distribution for the name
    (values from at least MIN_VALUE_PATIENTS training patients; cross-fitted like P(answered), so a
    dev patient's own age is never in it), we run each observed value through the solver exactly as
    a Bool answer and average: an 18-65 range scores only the share of patients outside it.
    Numbers without a distribution (everything but age today) keep the flat ``w_numeric``.
    """
    dist = model.value_distribution(var)
    if dist is None:
        return cfg.w_numeric
    return sum(p * _answer_value(state, var, v, open_cohorts, cfg) for v, p in dist)


def candidate_questions(state: Any) -> list[str]:
    """Unanswered variables of the trial's open cohorts (wider than informative(): it keeps
    questions that rule out one cohort of a multi-cohort trial without changing the trial status)."""
    open_c = [c for c, s in state.cohort_status().items() if s == "open"]
    names = {v for c in open_c for prog in state.cohorts[c] for v in prog.types}
    return sorted(v for v in names if state.answers.get(v) is None)


def _could_decide(state: Any, var: str, open_cohorts: list[str], model: Any,
                  cfg: AnswerableConfig) -> float:
    """1.0 if some possible answer has value (rules out a cohort, the trial, or makes it eligible),
    else 0.0. The ``use_value=False`` ablation. Numbers without a value distribution count as 1."""
    if state.types[var] == "Bool":
        answers: list = [True, False]
    else:
        dist = model.value_distribution(var)
        if dist is None:
            return 1.0
        answers = [v for v, _ in dist]
    return float(any(_answer_value(state, var, a, open_cohorts, cfg) > 0 for a in answers))


def score_question(state: Any, var: str, model: Any, cfg: AnswerableConfig,
                   p_ans: float | None = None) -> float:
    """P(answered) x expected value of the answer, for one (trial, variable).

    ``p_ans`` overrides the model's P(answered) (the ablation passes 1, the oracle 0 or 1)."""
    open_c = [c for c, s in state.cohort_status().items() if s == "open"]
    if not open_c:
        return 0.0
    vtype = state.types[var]
    p_pred, p_true = model.predict(var, vtype)
    if p_ans is None:
        p_ans = p_pred if cfg.use_answerability else 1.0
    if p_ans == 0:
        return 0.0
    if not cfg.use_value:
        return p_ans * _could_decide(state, var, open_c, model, cfg)
    if vtype != "Bool":
        # Age scoring: expected value over observed values, not a flat weight (see _numeric_value).
        return p_ans * _numeric_value(state, var, open_c, model, cfg)
    value = (p_true * _answer_value(state, var, True, open_c, cfg)
             + (1 - p_true) * _answer_value(state, var, False, open_c, cfg))
    return p_ans * value


class AnswerableInformative:
    """Ask the question with the highest P(answered) x value across all undetermined trials.

    Signature as the CA's policies: ``policy(states, asked, rng) -> (nct, var) | None``. It never
    reads the answer key; P(answered) comes from ``answerability.model_for`` (dev-fit, cross-fitted
    for dev patients). It stops only when no question has any value (as greedy_smt does); otherwise
    it uses the whole budget. Ties go to the higher P(answered), then trial and variable name.

    ``answered`` (oracle only, see ``answerable_informative_oracle``) replaces the predicted
    P(answered) with the answer key's truth (1 answered, 0 unknown). ``last_score`` holds the score
    of the last question chosen (the harness records it in replays).
    """

    def __init__(self, cfg: AnswerableConfig | None = None,
                 answered: Callable[[str, str], bool] | None = None) -> None:
        self.cfg = cfg or AnswerableConfig()
        self.answered = answered
        self.last_score: float | None = None

    def _p_answered(self, model: Any, nct: str, var: str, vtype: str) -> float:
        if self.answered is not None:
            return float(self.answered(nct, var))
        return model.p_answered(var, vtype) if self.cfg.use_answerability else 1.0

    def __call__(self, states: dict, asked: set, rng: Any) -> tuple[str, str] | None:
        from smt_trial_matching.answerability import model_for

        model = model_for(states)
        best, best_key = None, (0.0, 0.0, "", "")
        for n in _undetermined(states):
            for v in candidate_questions(states[n]):
                if (n, v) in asked:
                    continue
                # The tie-break uses the same P(answered) as the score, so the no-answerability
                # ablation cannot get answerability back through ties.
                p = self._p_answered(model, n, v, states[n].types[v])
                score = score_question(states[n], v, model, self.cfg, p_ans=p)
                key = (score, p, _neg(n), _neg(v))
                if score > 0 and (best is None or key > best_key):
                    best, best_key = (n, v), key
        self.last_score = best_key[0] if best else None
        return best


def _neg(s: str) -> str:
    """Sort key that makes smaller strings win a max() tie-break."""
    return "".join(chr(0x10FFFF - ord(ch)) for ch in s)


answerable_informative = AnswerableInformative()


# Ablations (Nov 19): the same policy with one factor switched off.
answerable_informative_no_answerability = AnswerableInformative(AnswerableConfig(use_answerability=False))
answerable_informative_no_value = AnswerableInformative(AnswerableConfig(use_value=False))


def answerable_informative_oracle(states: dict, asked: set, rng: Any) -> tuple[str, str] | None:
    """ORACLE (reads the answer key): answerable_informative with perfect answerability.

    The same scoring, value weights and tie-breaking, but P(answered) is the key's truth (1 if the
    answer is known, 0 if unknown) instead of the name model's prediction. P(true) and the age
    distribution still come from the model. The reference for how much better answerability
    prediction could make answerable_informative.
    """
    raise RuntimeError("answerable_informative_oracle needs the answer key; run it through the harness")


def _bind_informative_oracle(qid: str, sim: Any) -> AnswerableInformative:
    return AnswerableInformative(answered=lambda nct, var: sim.answer(qid, nct, var) is not None)


answerable_informative_oracle.for_patient = _bind_informative_oracle  # type: ignore[attr-defined]
