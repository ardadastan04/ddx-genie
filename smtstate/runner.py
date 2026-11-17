"""Run conversations between a questioning policy and a simulated patient, over one patient's candidate trials.

A policy is a function  policy(states, asked, rng) -> (nct, variable) or None (stop), where `states` maps NCT id to a
TrialState sharing the conversation's answers, and `asked` is the set of (nct, variable) already asked.
Answers are recorded per trial (variables are trial-specific names; the same name in two trials is answered once per
trial so that the simulator's per-pair key is respected).
Each episode logs every turn (question, answer, whether it was informative when asked, verdicts after the turn) so that
evaluate.py can compute accuracy at any question budget."""
import json, random
from .state import TrialState
from .sim import AnswerKeySimulator

def run_patient(qid, ncts, policy, sim, budget=30, seed=0):
    rng = random.Random(seed)
    states = {n: TrialState(n, {}) for n in ncts}
    asked, turns = set(), []
    verdicts0 = {n: s.verdict() for n, s in states.items()}
    for _ in range(budget):
        q = policy(states, asked, rng)
        if q is None: break
        nct, var = q
        informative = any(v == var for v, _ in states[nct].informative())
        ans = sim.answer(qid, nct, var)
        states[nct].answers[var] = ans
        asked.add((nct, var))
        turns.append(dict(nct=nct, var=var, answer=ans, informative=informative,
                          verdicts={n: s.verdict() for n, s in states.items()}))
    return dict(qid=qid, trials=list(ncts), initial_verdicts=verdicts0, turns=turns,
                final_status={n: s.status() for n, s in states.items()},
                final_verdicts={n: s.verdict() for n, s in states.items()})
