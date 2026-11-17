"""Baseline questioning policies (no LLM needed). Each returns (nct, variable) or None to stop."""

def _undetermined(states):
    return [n for n, s in states.items() if s.status() == 'undetermined']

def no_questions(states, asked, rng):
    return None

def ask_all(states, asked, rng):
    """Ask every variable of every trial in dictionary order, never stopping early (upper bound on questions)."""
    for n, s in states.items():
        for v in s.variables:
            if (n, v) not in asked: return (n, v)
    return None

def random_stop(states, asked, rng):
    """Random unanswered variable of an undetermined trial; stop when every trial is determined."""
    cand = [(n, v) for n in _undetermined(states) for v in states[n].variables if (n, v) not in asked]
    return rng.choice(cand) if cand else None

def greedy_smt(states, asked, rng):
    """SMT-guided: ask an INFORMATIVE variable (one whose answer can change a trial's status), preferring answers that
    would decide the trial (eligible/ineligible) and Bool over numeric; stop when no trial has an informative question."""
    best, best_score = None, -1
    for n in _undetermined(states):
        for v, res in states[n].informative():
            if (n, v) in asked: continue
            outcomes = [r for k, r in res.items() if k in (True, False)]
            score = 2 * sum(r != 'undetermined' for r in outcomes) + (1 if outcomes else 0)
            if score > best_score: best, best_score = (n, v), score
    return best

POLICIES = dict(no_questions=no_questions, ask_all=ask_all, random_stop=random_stop, greedy_smt=greedy_smt)
