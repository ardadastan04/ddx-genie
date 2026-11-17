# Conversational clinical-trial matching with SMT state (CS224V)

Our CS224V project, built on the trial-matching package the CA shared. The CA's README follows unchanged below
the setup section. See `CLAUDE.md` for project rules.

## Setup

```bash
uv sync                                   # installs z3-solver and the LLM client deps
uv run pytest                             # includes a turn-by-turn check against the CA's greedy_smt log
uv run python baselines/run_baselines.py greedy_smt --budget 30 --out logs/greedy_smt.jsonl
uv run python eval/evaluate.py logs/greedy_smt.jsonl --split dev
```

The CA's reference episode logs live in `logs/reference/` (the README below says `logs/`). For LLM work, copy
`.env.example` to `.env` and fill in the key; every call goes through `src/ddx_genie/llm.py`.

---

A self-contained student project. An agent talks with a patient and asks questions, keeping everything it learns as
**solver state over each trial's formal eligibility program**. The goal is to decide which of the patient's candidate
trials they are eligible for, accurately and with few questions.

The data are 363 patient–trial pairs from the TREC 2021 Clinical Trials track (57 patients, 263 trials). The package
includes trial criteria, compiled SMT-LIB programs, variable dictionaries, gold labels, answer keys, a state library, a
patient simulator, baselines, and an evaluator. Python ≥ 3.9 and `pip install z3-solver` are the only requirements.

## 1. The task

Each patient (a TREC topic) has 1–23 candidate trials (6.4 on average); 190 pairs are eligible and 173 ineligible.

The conversation works like this:
- At each turn the agent either asks about one patient fact or stops.
- The patient answers true, false, a number, or **unknown** ("I don't know"; the fact is not in their record).
- When the agent stops, it gives a verdict (eligible or ineligible) for every candidate trial.

Two settings:
- **Single-trial:** one patient and one trial (call the runner with a single NCT id).
- **Multi-trial ("find the right trials"):** one conversation per patient covers all of their candidate trials. This
  is the main setting.

## 2. What is in the package

| Path | Contents |
|---|---|
| `data/pairs.jsonl` | 363 pairs: `pair`, `qid` (patient), `nct` (trial), `gold` (eligible / ineligible), `trec_qrel` (2 / 1) |
| `data/patients.jsonl` | 57 patient notes (`qid`, `text`). The simulator's source of truth; do not show the note to your agent |
| `data/trials/<NCT>.json` | Title, conditions, phase, summary, inclusion and exclusion criteria text, cohort ids |
| `data/programs/<NCT><cohort>_<side>_program.smt2` | 695 SMT-LIB programs, one per trial × cohort × side (inclusion / exclusion) |
| `data/variables/<NCT>.json` | **Variable dictionary** per trial (see below) |
| `data/answer_keys/gpt5_oracle.jsonl` | Per pair, the value of every variable as read from the full note by GPT-5 (unknown = null) |
| `data/answer_keys/gpt5mini.jsonl` | The same, read by GPT-5-mini |
| `data/splits.json` | Patient split: `dev` (28 patients, 188 pairs) and `test` (29 patients, 175 pairs) |
| `smtstate/` | State library (`state.py`), simulator (`sim.py`), conversation runner (`runner.py`) |
| `baselines/` | Baseline policies and the script that runs them |
| `eval/evaluate.py` | Metrics |
| `logs/` | Episode logs of every baseline, for reference |
| `docs/` | Prompts for a natural-language patient simulator and for the LLM-only baseline |

### Variable dictionary

Each entry in `data/variables/<NCT>.json` has:
- `name` and `type` (`Bool`, `Real`, `Int`);
- `side` (inclusion / exclusion);
- `meaning`;
- `when_true`, `when_false`, `when_unknown` (or `when_value` for numbers);
- `polarity`, e.g. "criterion met when true".

Variable names follow a canonical scheme, such as `patient_has_diagnosis_of_<concept>_<timeframe>` with timeframes
`now`, `inthehistory`, `inthepastNmonths` and so on. Qualifiers are attached as `<stem>@@<qualifier>`. Names are
**trial-specific**: two trials may use the same name, and a variable is always answered within the trial that declares it.

### Labels

- **Gold labels** are the official TREC 2021 qrels: 2 → eligible, 1 → ineligible.
- **Why these 363 pairs:** they are the pairs of the TREC 2021 test split on which the compiled programs can reach the
  gold label. Fully informed by the GPT-5 answer key, the programs reproduce the gold label on 348 of 363 pairs
  (0.959). So **0.959 is the ceiling** for any agent that relies on the programs and this answer key. Errors below
  it come from the conversation, not from the programs.

## 3. SMT state (`smtstate/state.py`)

- **Programs:** a program is **satisfiable exactly when the patient is eligible**. Exclusion criteria are written as
  negations inside the exclusion program.
- **State:** the state is a partial assignment of patient variables (the answers so far). Unknowns are left free.
- **Three-valued status per program side:**
  - `violated`: the answers already falsify a criterion (UNSAT);
  - `satisfied`: every way of filling the unknowns satisfies all criteria;
  - `open`: otherwise.

  Definitional links named `AUXILIARY`, such as `qualifier ⇒ stem`, are background constraints, not criteria.
- **Cohort status:** ELIGIBLE if both sides are satisfied, INELIGIBLE if either is violated, otherwise OPEN.
- **Trial status:** ELIGIBLE if any cohort is eligible, INELIGIBLE if all are, otherwise UNDETERMINED.
- `TrialState.informative()` lists the unanswered variables whose answer could change the trial's status, with the
  status each answer would give. These are the questions worth asking.
- `TrialState.verdict()` is the final decision when the agent stops: UNDETERMINED counts as **eligible**, since
  unknown facts do not disqualify. This matches the VERDICT paper's rule.

```python
from smtstate import TrialState
s = TrialState('NCT04772456')            # empty state
s.status()                                # 'undetermined'
s.informative()[:3]                       # [(var, {True: status, False: status}), ...]
s.answers['patient_is_pregnant_now'] = False
s.verdict()
```

## 4. Patient simulators

- **Answer-key simulator (default; deterministic; no API):** `smtstate/sim.py`. A question about a variable returns
  that variable's value from `data/answer_keys/gpt5_oracle.jsonl`, or `None` ("unknown"). About two thirds of the
  values in a typical program are unknown, because notes do not mention them.
- **Natural-language simulator (extension):** an LLM role-plays the patient from the note and answers free-text
  questions. Your agent must then map each answer onto variables. See `docs/nl_simulator_prompt.md`. Keep the
  simulator model fixed across the systems you compare.

## 5. Evaluation

Run your policy with `smtstate/runner.py` (or log your own episodes in the same format), then:

```bash
python eval/evaluate.py logs/<run>.jsonl --split dev    # develop on dev
python eval/evaluate.py logs/<run>.jsonl --split test   # report test once, at the end
```

Metrics:
- **Pair-level verdict quality:** accuracy, and precision / recall / F1 with *eligible* as the positive class.
- **Cost:** questions per patient (mean and median) and per pair.
- **Accuracy at budget k** (k = 0, 5, 10, 20, 30): the verdicts the agent would give after k questions. Report this
  curve. It is the main way to compare policies with different stopping behavior.
- **Informative-question rate:** the share of questions that could change some trial's status when asked.
- **Patient-level eligible-set metrics:** precision, recall, F1 of the predicted set of eligible trials per patient,
  and exact match. This is the "find the right trials" view.

**Episode log format** (one JSON object per patient):
```json
{"qid": "...", "trials": ["NCT..."], "initial_verdicts": {"NCT...": "eligible"},
 "turns": [{"nct": "NCT...", "var": "...", "answer": true, "informative": true, "verdicts": {"NCT...": "eligible"}}],
 "final_verdicts": {"NCT...": "eligible"}, "final_status": {"NCT...": "undetermined"}}
```
`verdicts` in each turn are the verdicts after that turn. For free-text agents, `var` can be the question text;
`informative` is then optional.

**Good practice:**
- Choose methods on `dev` and report `test` once.
- Report questions and accuracy together; neither is meaningful alone.
- State which simulator and answer key you used.
- For LLM-based agents, report model, prompt and cost.

## 6. Baselines (`baselines/`)

```bash
python baselines/run_baselines.py greedy_smt --budget 30      # writes logs/greedy_smt_gpt5_oracle.jsonl
python baselines/run_baselines.py read_note --key gpt5mini    # no conversation: every value at once
```

| Baseline | What it does |
|---|---|
| `no_questions` | Stop immediately; every trial is eligible by the default rule |
| `random_stop` | Random unanswered variable of an undetermined trial; stop when all trials are determined |
| `greedy_smt` | Ask an **informative** variable, preferring answers that would decide a trial; stop when none is left |
| `ask_all` | Ask every variable of every trial (cost upper bound) |
| `read_note` | No conversation: use a whole answer key at once (`gpt5_oracle` = ceiling; `gpt5mini` = the paper's reader) |
| LLM-only conversation | An LLM asks free-text questions and decides from the criteria text, without SMT state. Prompt in `docs/llm_only_baseline_prompt.md` (needs an API) |

Reference results (answer-key simulator `gpt5_oracle`; question budget 30 per patient):

| Baseline | Split | Accuracy | F1 | Questions / patient | Accuracy @10 | Set exact match |
|---|---|---|---|---|---|---|
| no_questions | dev / test | 0.53 / 0.51 | 0.69 / 0.68 | 0 | 0.53 / 0.51 | 0.14 / 0.28 |
| random_stop | dev / test | 0.61 / 0.65 | 0.72 / 0.74 | 29.1 / 25.5 | 0.56 / 0.55 | 0.29 / 0.45 |
| greedy_smt | dev / test | 0.69 / 0.65 | 0.77 / 0.74 | 28.0 / 20.8 | 0.56 / 0.59 | 0.36 / 0.52 |
| ask_all (no budget) | dev / test | 0.96 / 0.96 | 0.96 / 0.96 | 210 / 197 | 0.59 / 0.55 | 0.71 / 0.76 |
| read_note, gpt5mini | dev / test | 0.82 / 0.85 | 0.82 / 0.84 | 0 | – | 0.36 / 0.48 |
| read_note, oracle (ceiling) | dev / test | 0.96 / 0.96 | 0.96 / 0.96 | 0 | – | 0.71 / 0.76 |

What the numbers say:
- **The headroom is large.** The best cheap policy reaches about 0.67 with 20–30 questions per patient; full
  information gives 0.96.
- **"Informative" isn't enough.** `greedy_smt` asks only informative questions, yet many answers are unknown,
  because the patient cannot answer most fine-grained criteria. Predicting which questions are *answerable* (and
  likely to decide a trial) is the main opportunity.

## 7. Suggested project directions

1. **Better question selection:** expected information gain or value of information over trial statuses, using a
   model of how likely each answer is (true / false / unknown) for this patient so far.
2. **Sharing across trials:** pick questions that settle many of the patient's trials at once (shared concepts,
   SNOMED-like hierarchy, similar variable names).
3. **Stopping and ranking:** decide when to stop and present a ranked list of likely-eligible trials with confidence;
   evaluate set F1 and accuracy at budget.
4. **Natural-language conversations:** generate patient-friendly questions, map free-text answers to variables, and
   measure the mapping error separately.
5. **SMT state versus LLM-only:** compare against the LLM-only conversation baseline at equal question budgets; also
   report what the SMT state adds in explanations (which criterion decided each verdict).
6. **Robustness:** noisy or contradictory answers, patients who answer "unknown" more often, and the `gpt5mini` key
   as a noisier simulator.

## 8. Notes and caveats

- These 363 pairs are those where the programs can reach the gold label, so they measure the *conversation and
  reading* layer, not program quality. Do not compare absolute numbers with end-to-end matching results on the full
  TREC 2021 test split.
- Gold labels come from TREC assessors and contain some noise.
- The answer key is a model's reading of the note, not a human annotation.
- **Sources:** patient topics and qrels are from the TREC 2021 Clinical Trials track (NIST); trial criteria are from
  ClinicalTrials.gov. Programs were compiled from the criteria by the SatIR trial compiler. Follow the TREC terms when
  sharing the data.
