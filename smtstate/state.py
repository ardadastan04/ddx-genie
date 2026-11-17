"""SMT state for conversational trial matching.

A trial has one or more cohorts; each cohort has an inclusion program and an exclusion program (SMT-LIB). A program is
satisfiable exactly when the patient is eligible (exclusion criteria are already negated inside the program).

The state is a partial assignment of patient variables (answers so far). Unanswered variables are unknown.
For each program we split assertions into
  background B : definitional links (names containing AUXILIARY), e.g. qualifier => stem
  criteria   C : everything else
and compute a three-valued status under the current answers A:
  'violated'   : B & A & C is UNSAT                -> some criterion already fails
  'satisfied'  : B & A & not(C) is UNSAT           -> every way of filling the unknowns satisfies the criteria
  'open'       : otherwise
A cohort is ELIGIBLE (certain) if both sides are 'satisfied', INELIGIBLE if either side is 'violated', else OPEN.
A trial is ELIGIBLE if some cohort is eligible, INELIGIBLE if all cohorts are ineligible, else UNDETERMINED.

`informative(state)` lists unanswered variables whose answer could change the trial status (the useful questions).
"""
import json, os, re
import z3

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.path.join(ROOT, 'data')
DECL = re.compile(r'\(declare-const\s+(\|[^|]+\||\S+)\s+(\S+)\)')


def _top_level(text):
    """Top-level s-expressions of an SMT-LIB text (comments removed)."""
    clean = '\n'.join(l.split(';;')[0] for l in text.split('\n'))
    out, depth, start = [], 0, None
    for i, ch in enumerate(clean):
        if ch == '(':
            if depth == 0: start = i
            depth += 1
        elif ch == ')':
            depth -= 1
            if depth == 0 and start is not None:
                out.append(clean[start:i + 1]); start = None
    return out


class Program:
    """One side (inclusion or exclusion) of one cohort."""

    def __init__(self, text):
        self.text = text or ''
        self.types = {m.group(1).strip('|'): m.group(2) for m in DECL.finditer(self.text)}
        self.vars = {n: (z3.Bool(n) if s == 'Bool' else z3.Real(n) if s == 'Real' else z3.Int(n)) for n, s in self.types.items()}
        decls = '\n'.join(e for e in _top_level(self.text) if e.lstrip('(').lstrip().startswith(('declare', 'define')))
        self.background, self.criteria = [], []
        for e in _top_level(self.text):
            if not re.match(r'\(\s*assert\b', e): continue
            m = re.search(r':named\s+([^\s)]+)', e)
            try:
                f = z3.And(*z3.parse_smt2_string(decls + '\n' + e))
            except z3.Z3Exception:
                continue
            (self.background if m and 'AUXILIARY' in m.group(1) else self.criteria).append(f)
        self.C = z3.And(*self.criteria) if self.criteria else z3.BoolVal(True)
        self.B = z3.And(*self.background) if self.background else z3.BoolVal(True)
        # persistent solvers; answers are passed as assumptions (fast repeated checks)
        self._s_sat = z3.Solver(); self._s_sat.add(self.B, self.C)
        self._s_val = z3.Solver(); self._s_val.add(self.B, z3.Not(self.C))
        for s_ in (self._s_sat, self._s_val): s_.set('timeout', 5000)
        self._lits = {}

    def _lit(self, n, v):
        """Assumption literal for 'variable n has value v' (a fresh Boolean tied to the equality, cached)."""
        k = (n, v)
        if k not in self._lits:
            x = self.vars[n]
            if self.types[n] == 'Bool': eq = x == z3.BoolVal(v)
            elif self.types[n] == 'Real': eq = x == z3.RealVal(v)
            else: eq = x == z3.IntVal(int(v))
            a = z3.Bool(f'__ans__{len(self._lits)}__{id(self)}')
            for s_ in (self._s_sat, self._s_val): s_.add(z3.Implies(a, eq))
            self._lits[k] = a
        return self._lits[k]

    def _assumptions(self, answers):
        out = []
        for n, v in answers.items():
            if v is None or n not in self.vars: continue
            if self.types[n] == 'Bool' and not isinstance(v, bool): continue
            if self.types[n] != 'Bool' and (isinstance(v, bool) or not isinstance(v, (int, float))): continue
            out.append(self._lit(n, v))
        return out

    def status(self, answers):
        if not self.criteria: return 'satisfied'
        A = self._assumptions(answers)
        if self._s_sat.check(*A) == z3.unsat: return 'violated'
        return 'satisfied' if self._s_val.check(*A) == z3.unsat else 'open'


class TrialState:
    """All cohorts of one trial + the shared answer dictionary (pass the same dict to several trials to share state)."""

    def __init__(self, nct, answers=None):
        self.nct = nct
        meta = json.load(open(os.path.join(DATA, 'trials', f'{nct}.json')))
        self.cohorts = {}
        for c in meta['cohorts']:
            def load(side):
                p = os.path.join(DATA, 'programs', f'{nct}{c}_{side}_program.smt2')
                return Program(open(p).read() if os.path.exists(p) else '')
            self.cohorts[c] = (load('inclusion'), load('exclusion'))
        self.answers = answers if answers is not None else {}
        self.variables = sorted({v for inc, exc in self.cohorts.values() for v in list(inc.types) + list(exc.types)})
        self.types = {v: t for inc, exc in self.cohorts.values() for v, t in list(inc.types.items()) + list(exc.types.items())}

    def cohort_status(self, answers=None):
        a = self.answers if answers is None else answers
        out = {}
        for c, (inc, exc) in self.cohorts.items():
            si, se = inc.status(a), exc.status(a)
            out[c] = 'ineligible' if 'violated' in (si, se) else ('eligible' if si == se == 'satisfied' else 'open')
        return out

    def status(self, answers=None):
        cs = self.cohort_status(answers).values()
        if 'eligible' in cs: return 'eligible'
        if all(x == 'ineligible' for x in cs): return 'ineligible'
        return 'undetermined'

    def verdict(self):
        """Final decision when the conversation stops: undetermined counts as eligible (unknown facts do not disqualify),
        matching the rule used in the VERDICT paper."""
        return 'ineligible' if self.status() == 'ineligible' else 'eligible'

    def informative(self):
        """Unanswered variables whose answer could change this trial's status, with the statuses each answer would give.
        Bool: tries True and False. Numeric: listed as informative if it occurs in an open cohort (its value is needed)."""
        cur = self.status()
        if cur != 'undetermined': return []
        open_c = [c for c, st in self.cohort_status().items() if st == 'open']
        cand = sorted({v for c in open_c for p in self.cohorts[c] for v in p.types})
        out = []
        for v in cand:
            if v in self.answers and self.answers[v] is not None: continue
            if self.types[v] == 'Bool':
                res = {val: self.status({**self.answers, v: val}) for val in (True, False)}
                if any(r != cur for r in res.values()): out.append((v, res))
            else:
                out.append((v, {'value': 'needed'}))
        return out
