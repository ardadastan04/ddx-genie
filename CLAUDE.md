# CLAUDE.md — Conversational clinical-trial matching with SMT state (CS224V)

## What this project is
An agent talks with a patient, asking about one fact at a time, and keeps what it learns as solver state over
each candidate trial's formal eligibility program (Z3). It must decide which of the patient's trials they are
eligible for, accurately and with few questions. Built on the package the CA shared (TREC 2021 Clinical Trials:
57 patients, 263 trials, 363 patient–trial pairs). Switched from MediQ diagnosis on 2026-11-17; MediQ, DDXPlus and
Genie Worksheets are gone from the code (git history has them; old numbers in `docs/archive/`).

Main research angle: "informative" questions (ones that could change a trial's status) are often unanswerable
(about two thirds of program variables are unknown in the notes). Our MediQ baselines found the same thing
(57% of questions wasted). Policies should weigh informativeness by how likely the question is to get an answer.

## Repo layout
```
smt-trial-matching/
  CLAUDE.md, README.md, pyproject.toml
  .env                      # secrets, gitignored
  smtstate/                 # CA's state library (state.py), answer-key simulator (sim.py), runner (runner.py)
  baselines/                # CA's baseline policies + run_baselines.py
  eval/evaluate.py          # CA's metrics
  data/                     # pairs, patients, trials, programs (SMT-LIB), variables, answer_keys, splits.json
  docs/                     # NL simulator + LLM-only baseline prompts; archive/ for retired results
  logs/reference/           # CA's reference baseline episode logs (our own logs/ output is gitignored)
  src/smt_trial_matching/llm.py      # the one LLM client (cache, cost log, budget guard)
  src/smt_trial_matching/experiment.py  # harness: policies x split -> curves, paired tests, plots
  src/smt_trial_matching/policies.py    # our policies: answerable_informative = P(answered) x value (Person A),
                                        #   its two ablations, and two oracle references (read the key; not ceilings)
  src/smt_trial_matching/replay.py      # turn-by-turn replays (demo, failure analysis); cohort-level usefulness
  src/smt_trial_matching/diagnostics.py # why predicted answerability helps little (calibration, decision impact)
  configs/                  # run configs for the harness (main / ablations, dev / test)
  scripts/demo_conversation.py, scripts/failure_sample.py
  src/smt_trial_matching/answerability.py  # P(answered), P(true) from variable names; fit on dev only,
                                        #   5-fold cross-fit by patient for dev patients
  scripts/smoke_llm.py, tests/
```

## Facts verified (2026-11-17)
- `python baselines/run_baselines.py greedy_smt --budget 30` reproduces `logs/reference/greedy_smt_gpt5_oracle.jsonl`
  exactly (test acc 0.646, F1 0.737, 20.8 questions/patient); `no_questions` gives 0.514. `tests/test_smtstate.py`
  checks one patient turn by turn.
- Split is by patient: `data/splits.json` dev (28 patients, 188 pairs) / test (29 patients, 175 pairs).
- Variable names are trial-specific; the simulator answers per (patient, trial) pair.
- Verdict rule: undetermined counts as eligible. Ceiling with the full GPT-5 answer key is 0.959 (348/363).

## Hard rules
- Choose methods on `dev`; run `test` once per final system, and only after I confirm.
- Do not edit the CA's files in `smtstate/`, `baselines/`, `eval/`, `data/` unless I ask; add our code alongside.
- Never commit `.env` or our own `logs/` / `runs/` output. Follow the TREC terms when sharing the data.
- Every LLM call goes through `src/smt_trial_matching/llm.py`, which logs model, tokens and USD cost to
  `runs/<run_id>/cost.jsonl`, caches responses on disk, and enforces `MAX_RUN_USD`. Print the running total per patient.
- Runs are resumable. Random seed is 0 everywhere.
- Default to the cheapest configured model. Never switch to a more expensive model unless I ask.
- LLM-based runs: develop on 1–5 patients. Never launch an LLM run over 5 patients without me confirming.
  Solver-only runs (no LLM) are free and can run on the full dev split.
- Python >= 3.11, managed with uv. Type hints, small functions, pytest tests for parsing and scoring logic.

## LLM backend
`LLM_BACKEND=gemini_api` (AI Studio key, `generativelanguage.googleapis.com/v1beta/openai/`, CHEAP_MODEL
`gemini-3.1-flash-lite`). A Vertex route via ADC is supported by `llm.py` but unverified. Settings in `.env`
(see `.env.example`). Cloud Claude sessions have no key; LLM runs happen on Arda's Mac.

## How to work with me
- Before writing a large component, show a short plan and wait for my OK.
- After each task, tell me what you ran, what passed, and the exact command I should run to check it myself.
- If something in this file turns out to be wrong when you read the actual code or data, tell me and update this
  file.
