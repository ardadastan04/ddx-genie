# TASKS.md — prompts to paste into Claude Code, one at a time

Run them in order. Each task lists the prompt to paste, what "done" means, and what you check yourself before
moving on. Claude Code reads CLAUDE.md automatically, so the prompts stay short.

---

## T0. Scaffold the repo
**Prompt:**
> Read CLAUDE.md. Scaffold the repo layout it describes: pyproject.toml (uv, Python 3.11+), .gitignore
> (data/raw, .env, runs/* except summaries), README.md with setup steps, empty modules in src/ddx_genie/, and
> tests/. Add genie-worksheets as an editable dependency from ../genie-worksheets. Create .env.example with every
> env var CLAUDE.md mentions. Don't write any logic yet.

**Done when:** `uv sync` works and `python -c "import worksheets, ddx_genie"` runs.
**You check:** .gitignore really excludes data/raw and .env.

## T1. Vertex LLM wrapper with cost logging
**Prompt:**
> Implement src/ddx_genie/llm.py per CLAUDE.md: an OpenAI-compatible client for Vertex AI using ADC tokens with
> automatic refresh, a disk cache, per-call token and USD logging to runs/<run_id>/cost.jsonl, and a budget guard
> using MAX_RUN_USD. Also add a function that sets LLM_API_BASE_URL and a fresh LLM_API_KEY in os.environ so
> Genie's own client works, and refreshes it before expiry. Write a smoke test script that sends one short
> prompt with CHEAP_MODEL and prints the reply, tokens and cost.

**Done when:** the smoke test prints a reply and a cost line under $0.01.
**You check:** the cost appears in cost.jsonl; the Google Cloud billing page shows the charge within a day.

## T2. DDXPlus subset
**Prompt:**
> Inspect data/raw/release_conditions.json and release_evidences.json and print the exact pathology names and
> the evidence JSON schema. Then propose 6 respiratory conditions that share many symptoms and wait for my OK.
> After I approve, implement src/ddx_genie/subset.py: load the test split, filter to those conditions, sample 10
> patients per condition with seed 0, keep the original row index, and write data/processed/subset.jsonl and
> data/processed/field_list.json (the union of evidences those patients have). Add tests for evidence parsing.

**Done when:** 60 patients, 10 per condition, and rerunning gives identical files.
**You check:** the condition list makes clinical sense to you.

## T3. Patient cards
**Prompt:**
> Implement src/ddx_genie/cards.py: for each patient in subset.jsonl, decode every evidence code into a plain
> English question and answer (using question_en and value_meaning), mark the initial evidence as the chief
> complaint, and write one readable card per patient to data/processed/patient_cards/. Print 3 cards.

**Done when:** cards read like plausible patients with no raw E_ codes left.
**You check:** read the 3 printed cards yourself.

## T4. Worksheet spec generator
**Prompt:**
> Implement src/ddx_genie/worksheet_gen.py to write genie/intake.csv in the exact CSV format in CLAUDE.md. One
> worksheet named PatientIntake. Map evidences: binary -> bool, categorical -> Enum (decoded values),
> 0–10 scales -> int, multi-choice -> one bool per option. Use code_question to set each child field's
> Predicate so it is only asked after its parent is True. Descriptions should read like a clinician's
> question. Also add an output-style field for the differential. Show me the first 30 rows, then confirm it
> loads with AgentBuilder(...).with_csv_specification(...) without errors.

**Done when:** Genie parses the CSV; field count is roughly 40–60.
**You check:** skim descriptions; delete fields you think are pointless.

## T5. Genie agent you can talk to
**Prompt:**
> Build genie/agent.py and genie/config.yaml following the course_enroll example (no knowledge base). Copy and
> adapt its prompts into genie/prompts/ for a clinical intake: one question at a time, follow-ups only when the
> parent symptom is present, plain language. Register a diagnose(...) API with AgentBuilder.add_api that sends
> the filled fields to CHEAP_MODEL and returns a top-5 differential with probabilities restricted to our 6
> conditions, and call it from the worksheet's Form Actions. Make it runnable with
> `uv run python genie/agent.py` using Genie's conversation_loop. Raise Genie's 10s timeout via a monkeypatch if
> calls time out.

**Done when:** you can chat with it and it ends with a differential.
**You check:** play the patient 3–5 times from printed cards. Paste transcripts and saved state back to Claude
Code (or to me) for fixes.

## T6. Patient simulator
**Prompt:**
> Implement src/ddx_genie/simulator.py: an LLM patient (CHEAP_MODEL) given one patient card. Rules: open with
> the chief complaint in plain words; answer only what is asked; say no to symptoms not on the card; never name
> a diagnosis or use codes; keep answers short. Write a tiny manual test that has it answer 5 scripted doctor
> questions for one card.

**Done when:** answers match the card and nothing extra leaks.
**You check:** read the 5 answers.

## T7. Batch harness
**Prompt:**
> Implement src/ddx_genie/harness.py: for each patient, build a fresh Genie agent, then loop: simulator reply ->
> `await agent.generate_next_turn(reply)` -> agent reply from agent.dlg_history, until the differential is
> produced or 20 turns. Save per patient: transcript, final worksheet field values, differential, turns, tokens,
> cost. Resumable, cached, budget-guarded. CLI: `--system genie --n 5 --run-id dev1`. Run it on 5 patients.

**Done when:** 5 result files plus a cost summary.
**You check:** read 2 full transcripts for leakage; note cost per patient and multiply by 60.

## T8. Function-calling baseline
**Prompt:**
> Implement src/ddx_genie/baseline.py: same model, same simulator, same 20-turn cap, but a plain
> function-calling agent with record_evidence(name, value) and diagnose() tools over the same field list.
> Plug it into the harness as `--system baseline`. Run 5 patients.

**Done when:** baseline results have the same file format as Genie's.

## T9. Scoring
**Prompt:**
> Implement src/ddx_genie/score.py over a run directory: evidence recall and precision (captured fields vs. the
> patient's true evidences, mapped through field_list), turns, top-1 and top-3 accuracy vs. PATHOLOGY, overlap
> between predicted and ground-truth top-5 differential, cost per patient. Report overall and per condition and
> write summary.json. Add pytest tests on a hand-made example.

**Done when:** tests pass and the 5-patient runs produce summaries.
**You check:** compute one patient's metrics by hand and compare.

## T10. Full runs and report
**Prompt (only after T9 and a cost check):**
> Run genie and baseline on all 60 patients with CHEAP_MODEL (MAX_RUN_USD=15 each). Then implement
> src/ddx_genie/report.py to produce a comparison table (markdown), a per-condition chart, and a list of the
> evidences Genie missed most often.

**Done when:** one table comparing both systems on all metrics, and total spend logged.
**You check:** every number in the paper traces back to summary.json.
