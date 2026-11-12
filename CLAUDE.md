# CLAUDE.md — DDXPlus × Genie Worksheets evaluation (CS224V)

## What this project is
We are evaluating a Genie Worksheets agent that interviews simulated patients and outputs a differential
diagnosis, compared against a plain function-calling baseline. Patients come from a small, fixed subset of the
DDXPlus dataset (synthetic, research use only). Total LLM budget for the whole project is $100 in Google Cloud
credits, so cost control is a first-class requirement.

Pipeline:
DDXPlus subset -> decoded patient cards -> simulated patient (LLM) <-> Genie agent (worksheet) -> final dialogue
state + differential -> scorer (vs. ground truth). The baseline swaps the Genie agent for a function-calling agent
using the same model, simulator and turn cap.

## Repo layout (create it this way)
```
ddx-genie/
  CLAUDE.md, TASKS.md, README.md, pyproject.toml
  .env                      # secrets, gitignored
  data/raw/                 # DDXPlus downloads, gitignored, never committed
  data/processed/           # subset.jsonl, field_list.json, patient_cards/
  genie/                    # intake.csv (worksheet spec), prompts/, config.yaml, agent.py
  src/ddx_genie/            # llm.py, subset.py, cards.py, worksheet_gen.py, simulator.py,
                            # harness.py, baseline.py, score.py, report.py
  runs/<run_id>/            # one JSON per patient + cost.jsonl + summary.json (gitignored except summary)
  tests/
```

## Hard rules
- Never commit `data/raw/`, `.env`, or full `runs/` directories. Add them to `.gitignore` first.
- Every LLM call (Genie's included, where possible) goes through `src/ddx_genie/llm.py`, which logs model, input
  tokens, output tokens and USD cost to `runs/<run_id>/cost.jsonl`.
- Budget guard: read `MAX_RUN_USD` from env. Before a batch, estimate cost from the first patients; abort the run
  if spend exceeds the cap. Print running total after every patient.
- Cache every LLM response on disk keyed by (model, messages, params) so reruns are free.
- Runs are resumable: skip patients whose result JSON already exists.
- Random seed is 0 everywhere. Keep the DDXPlus row index with every patient.
- Default to the cheapest configured model. Never switch to a more expensive model unless I ask.
- Develop and test on N=1–5 patients. Never launch a run over 5 patients without me confirming.
- Do not edit the genie-worksheets package source. If a patch is unavoidable (e.g. its hardcoded timeout),
  monkeypatch from our code and note it in README.md.
- Python >= 3.11, managed with uv. Type hints, small functions, pytest tests for parsing and scoring logic.

## LLM backend: Gemini on Vertex AI (Google Cloud credits)
CORRECTED (2026-11-05): the backend actually in use is `LLM_BACKEND=gemini_api` (AI Studio key,
`generativelanguage.googleapis.com/v1beta/openai/`, CHEAP_MODEL `gemini-3.1-flash-lite`, $5 prepay).
The Vertex route below is supported by `llm.py` but unverified against the edu-credit billing account.
- Vertex exposes an OpenAI-compatible Chat Completions endpoint:
  `https://{REGION}-aiplatform.googleapis.com/v1/projects/{PROJECT_ID}/locations/{REGION}/endpoints/openapi`
  Model names look like `google/gemini-2.5-flash` (confirm the current Flash model name in the Vertex console).
- Auth is a short-lived OAuth access token (about 1 hour), not a static key. Get it via Application Default
  Credentials (`google.auth.default(scopes=["https://www.googleapis.com/auth/cloud-platform"])`, then refresh).
  Long runs must refresh the token before it expires.
- Env vars in `.env`: `GCP_PROJECT_ID`, `GCP_REGION` (default us-central1), `CHEAP_MODEL`, `STRONG_MODEL`,
  `MAX_RUN_USD`, plus price-per-million-token settings for each model (I fill these in from the pricing page).

## Genie Worksheets: facts verified in the repo (github.com/stanford-oval/genie-worksheets)
- Install as an editable dependency from a local clone: `uv add --editable ../genie-worksheets`.
  Two upstream packaging bugs are worked around in our `pyproject.toml`: it imports `overrides` and
  `tiktoken` at module scope without declaring them (we declare them), and `suql` drags in plain
  `psycopg2`, whose macOS sdist dies on `libpq.5.dylib` (we override it out so only `psycopg2-binary`
  is installed). A stale `VIRTUAL_ENV` silently redirects `uv pip install`; use `env -u VIRTUAL_ENV uv …`.
- The online docs show an older `Agent(...)` API. The current code uses `AgentBuilder`. Use
  `experiments/domain_agents/course_enroll/course_enroll.py` as the structural template:
  `AgentBuilder(name=..., description=..., starting_prompt=...)` -> `.with_csv_specification(path)` ->
  `.build(Config.load_from_yaml(path))`. The knowledge base and parser are optional (only built if configured);
  we do not use them in v1.
- Turn API: `await agent.generate_next_turn(user_utterance)`; history is `agent.dlg_history`;
  `agent.starting_prompt` is the agent's first message. `conversation_loop` in
  `src/worksheets/utils/interface.py` is just a loop over these.
- LLM client (`src/worksheets/llm/llm.py`): model names WITHOUT an `azure/` prefix go to LangChain `ChatOpenAI`
  with `api_key=os.getenv("LLM_API_KEY")` and `base_url=os.getenv("LLM_API_BASE_URL")`. So set those two env vars
  to the Vertex endpoint and a fresh token. It hardcodes `timeout=10` and `max_retries=3`. It optionally caches in
  Redis at localhost:6379 and silently disables caching if Redis is absent.
- `config.yaml` (see `Config` in `src/worksheets/agent/config.py`) needs `semantic_parser`,
  `response_generator`, `knowledge_parser`, `knowledge_base` blocks, each with at least `model_name`.
  CORRECTED: `Config` has NO `prompt_dir` field. It is a pydantic model with the default
  `extra="ignore"`, so a `prompt_dir:` key in the YAML (the bundled `course_enroll/config.yaml` has
  one) is accepted and silently discarded. Register our prompt directory instead with
  `init_llm(prompt_dir=..., dotenv_path=...)` from `worksheets.llm.prompts`, called after importing
  `worksheets` -- the package calls it at import time pointing at its own bundled prompts. Get this
  wrong and the agent runs on Genie's default prompts with no error of any kind.
- Spec CSV header, in this exact order:
  `Form Predicate,Form Name,Predicate,Kind,Type,Name,Enum Values,Description,Don't Ask,Required,Confirm,Actions,Form Actions,Validation`
  CORRECTED: there are 14 columns, not 13 -- `Validation` follows `Form Actions` (`FIELD_VALIDATION = 13`
  in `src/worksheets/specification/from_spreadsheet.py`). Short rows are padded by `fill_all_empty`, so
  13 columns happens to parse, but write the header in full. Verified: a hand-written 14-column CSV
  loads as `PatientIntake(cough: bool, cough_type: Enum['dry','productive'], pain_intensity: int)`.
  - A worksheet row has `Form Name` set and `Type` = `worksheet`; following rows are its fields.
  - Field Kind: `input` / `internal` / `output`. Types: `str`, `bool`, `int`, `float`, `Enum`, `confirm`
    (`list` is NOT implemented).
  - Enum values go on the rows right after the Enum field, in the `Enum Values` column, with `Type` and `Name` blank.
  - `Don't Ask`, `Required`, `Confirm` are the literal string `TRUE` when set.
  - Actions are Python using `self.<field>`; built-ins include `say("...")`. Registered APIs (via
    `AgentBuilder.add_api(func, description)`) can be called from actions.
- Prompt templates: copy `experiments/domain_agents/course_enroll/prompts/` and adapt; check which files the
  semantic parser and response generator actually load before trimming.

## DDXPlus facts (English release)
- Files: `release_evidences.json`, `release_conditions.json`, `release_{train,validate,test}_patients` (zipped CSV).
- Patient columns: AGE, SEX, PATHOLOGY, EVIDENCES, INITIAL_EVIDENCE, DIFFERENTIAL_DIAGNOSIS. EVIDENCES and
  DIFFERENTIAL_DIAGNOSIS are stringified Python lists: parse with `ast.literal_eval`.
- Non-binary evidences are written `<evidence-name>_@_<value>`. English evidence names are codes like `E_91`;
  decode them with `question_en` and `value_meaning` in `release_evidences.json`.
  VERIFIED (223 evidences, 49 conditions, test split = 134,529 rows; zip member is `release_test_patients`
  with no file extension):
  - `data_type` has exactly three values: `B` binary (208), `C` (10), `M` multi-select (5).
  - CORRECTED: `C` is NOT a single kind. 6 of the 10 are 0-10 numeric scales (`possible-values` is
    `[0..10]`, `value_meaning` empty) and 4 are categorical with `V_` codes (rash colour, two Y/N pairs,
    travel region). Decide int-vs-Enum by inspecting `possible-values`, never by `data_type` alone.
  - `M` fields carry up to **165** options (`E_55`/`E_57`/`E_133` pain and region locations, `E_54` has 16).
    One bool per possible value is not viable; expand only over values observed in the subset, or group them.
- `code_question` groups related evidences: the parent evidence must be present for children to apply.
  CORRECTED: only **3** groups have more than one member, out of 209 groups. They are `E_53` (pain, 7
  members), `E_129` (skin lesions, 8) and `E_151` (swelling, 2); the parent is itself a member of its own
  group. So predicate-gating applies to ~17 evidences, not pervasively as the worksheet plan assumed.
- DIFFERENTIAL_DIAGNOSIS is a list of [pathology, probability] pairs.
- Use the TEST split only. Pathology names must match `release_conditions.json` exactly; check them, don't assume.

## MediQ facts (verified 2026-11-05, github.com/stellalisy/mediQ, CC BY 4.0)
- Cloned to `data/raw/mediq/repo/`. Two files in `data/`: `all_dev_good.jsonl` (1272 MedQA-derived
  items, all specialties) and `all_craft_md.jsonl` (140 dermatology items, all diagnosis questions).
- Record fields: `id, question, context (list of sentences), options {A-D}, answer, answer_idx, facts
  (list, "1. ..." numbered, ordered history -> exam -> labs), patient {age, gender, gpt_specialty}`.
- Only ~9% of MedQA items ask for the diagnosis; the rest are treatment / mechanism / next test.
  `src/ddx_genie/mediq.py` filters to 109 pure diagnosis stems (drops "next step in diagnosis",
  "associated with the diagnosis", "risk factor for", stems carrying lab tables) and samples 50 with
  seed 0 -> `data/processed/mediq/subset.jsonl`. 3 records (ids 224, 298, 779) have empty facts and
  are skipped. Some facts are truncated mid-sentence in the source (e.g. id 7's last fact).
- Partial views (`src/ddx_genie/reveal.py` -> `data/processed/mediq/views.jsonl`, 500 views): anchor
  (`n_initial`, MediQ's `context[0]` = demographics + complaint, 1-4 facts) always shown, plus a fraction
  p in {0,.2,.4,.6,.8,1} of the rest, as `prefix` (source order) or `gaps` (random, seeded per case).
  Modes are matched on fact count and nested across p. p=0 = MediQ initial-info setting; p=1 = oracle.
- Answer space (`partial_eval.py --answer-space`): `open` is the default and the headline setting
  (clinicians are not shown options). The model names a free-text top-5; a judge call labels EACH
  candidate `same / more_specific / broader / different` vs gold. Strict = same|more_specific;
  lenient also accepts broader. Don't go back to "return the matching rank": that judge was
  inconsistent (same candidate matched or not depending on its neighbours). `mcq4` leaks: the
  options alone give one-shot 0.50 at p=0 and 0.92 by p=0.4 (run `mediq_oneshot_v1`).
  Validate the judge by hand via `runs/<run>/judge_review.csv` before trusting open-mode numbers.

## MediQ benchmark code (stellalisy/mediQ @ faa2ce6, verified 2026-11-05) -- broken as shipped
- `helper.ModelCache.generate` drops the return value of `openai_generate`; that function also
  subscripts the pydantic response (`response["usage"]`) and reads `choices[0].text` (completions
  API, not chat). The API path cannot work; only local HF/vLLM runs. No `base_url`, so no non-OpenAI
  provider. Route calls through our `llm.py` by monkeypatching `helper.get_response`; don't edit vendor code.
- `ModelCache` is keyed by model name only, so Expert and Patient on the same model share the first
  caller's params; Patient's `max_length` is ignored (decomposition would truncate at 256 tokens).
- `expert_basics.parse_likert_scale` has no `return` -> ScaleExpert (the paper's best) crashes.
- `--abstain_threshold` defaults to 0.8 and overrides `SCALE_THRESHOLD=4.0`; on the 1-5 scale it
  never abstains. Pass the scale threshold explicitly.
- FactSelectPatient reads `sample["atomic_facts"]`; the data's key is `facts`, so it silently
  re-decomposes with the Patient LLM. Map `facts` -> `atomic_facts` to use the released facts.
- No Full / Initial / None runner exists (prompts.py has unused `non_interactive` prompts).
  `Patient` honours `sample["initial_info"]`, so the settings are data variants + FixedExpert, max_questions=0.
- Repo defaults temperature 0.6 / top_p 0.9; the paper (App. C) uses 0.5 / 1.0. No seeding.
- Paper Table 2: Basic beats Initial in 3/8 rows (incl. GPT-4 on both datasets). The "11.3% drop"
  is not reproducible from Table 2 (row mean ~8.8%). Max questions and thresholds are not stated.

## Measured ceilings (run 2026-10-30, all 60 subset patients)

These bound what the eval can show and must appear in the paper beside any accuracy
number.

- **Diagnosis-step oracle**: given each patient's COMPLETE true evidence, the same
  diagnosis prompt achieves **top-1 0.650, top-3 0.950**. So no interview, however
  perfect, can exceed ~0.65 top-1 here.
- **DDXPlus's own differential**, restricted to our 6 conditions, ranks the true
  PATHOLOGY first only **0.617** of the time (top-3 0.967). The oracle therefore
  slightly *beats* the dataset's own answer key: the ceiling is intrinsic to DDXPlus,
  not a weakness of our prompt.
- **Consequence**: top-1 accuracy against PATHOLOGY is not a valid discriminator for
  these conditions. Lead with evidence recall/precision; report top-3 accuracy and
  differential overlap as the diagnosis metrics. Say this explicitly in the paper.
- **Our prompt does have a calibration bias worth fixing**: its errors are bimodal
  (Bronchitis 0.00, URTI 0.10, everything else 0.90-1.00), collapsing
  Bronchitis -> COPD exacerbation 9/10 and URTI -> Influenza 9/10, whereas DDXPlus's
  own errors are diffuse across all six. Reproduce with
  `uv run python scripts/oracle_ceiling.py`.

## How to work with me
- Before writing a large component, show a short plan and wait for my OK.
- After each task, tell me what you ran, what passed, and the exact command I should run to check it myself.
- If something in this file turns out to be wrong when you read the actual code or data, tell me and update this
  file.

## Frozen baselines (2026-11-05)
`baseline_scores.md` holds the MediQ open-ended baseline numbers (runs `mediq_open_v1`, `baselines_v1`,
$0.88 total). Every new system is compared on the same 50 cases, views, prompts, judge and model.
Don't overwrite those run dirs; use new run ids. Regenerate tables with `scripts/baseline_report.py`.
