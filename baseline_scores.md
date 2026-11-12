# Baseline scores — MediQ, open-ended diagnosis (frozen 2026-11-05)

<!--
These are the reference numbers every later agent version (Genie worksheet agent,
John's question tree, any planner) must be compared against. Do not overwrite them:
re-running the commands at the bottom replays from the on-disk LLM cache and must
reproduce these numbers exactly. A new system is evaluated on the SAME 50 cases, SAME
starting views, SAME diagnosis prompt, SAME judge and SAME model.
-->

## Setup

| Item | Value |
|---|---|
| Cases | 50 MediQ (MedQA-derived) questions that ask for the diagnosis, sampled with seed 0 (`data/processed/mediq/subset.jsonl`) |
| Answer setting | **Open-ended**: the model names its own top-5 differential; no answer options are shown |
| Scoring | A judge labels each of the 5 candidates vs. the gold diagnosis as same / more specific / broader / different. **Strict** (reported here): same or more specific counts as a hit |
| Model (every role) | `gemini-3.1-flash-lite` (cheap model), temperature 0 |
| Starting point for baselines 2–4 | The case's initial information only: age, sex, presenting complaint (1–4 facts; MediQ's own "initial info" setting) |
| Runs | `runs/mediq_open_v1` (baseline 1), `runs/baselines_v1` (baselines 2–4) |
| Cost | $0.19 + $0.69 = **$0.88** for all four baselines (~6,000 calls) |
| Brackets | 95% confidence intervals (Wilson for proportions, bootstrap for means). n=50, so differences under ~0.15 are mostly noise |

**Metric glossary**
- **top-1**: the correct diagnosis is the model's first answer.
- **top-5**: it appears anywhere in the 5-item differential.
- **P(gold)**: the probability the model put on the correct diagnosis. It's a softer score that improves even when the top answer doesn't change.
- **p (facts revealed)**: share of the non-initial facts shown. p=0 is the complaint only; p=1 is the full case.
- **prefix**: facts in their original order, cut off part-way (history → exam → labs), like an interrupted consultation.
- **gaps**: the same number of facts, chosen at random, so holes can fall anywhere.

---

## Baseline 1: one-shot diagnosis vs. how much is known

<!-- One LLM call per view: diagnose from whatever facts are shown, no questions.
     Gives the FLOOR (one-shot at each information level) and the CEILING (p=1, full case). -->

| mode | metric | p=0.0 (complaint only) | p=0.2 | p=0.4 | p=0.6 | p=0.8 | p=1.0 (full case) |
|---|---|---|---|---|---|---|---|
| prefix | top-1 | **0.18** [0.10–0.31] | 0.38 [0.26–0.52] | 0.40 [0.28–0.54] | 0.64 [0.50–0.76] | 0.68 [0.54–0.79] | **0.78** [0.65–0.87] |
| prefix | top-5 | 0.36 [0.24–0.50] | 0.46 [0.33–0.60] | 0.76 [0.63–0.86] | 0.86 [0.74–0.93] | 0.86 [0.74–0.93] | 0.92 [0.81–0.97] |
| prefix | P(gold) | 0.11 [0.06–0.15] | 0.19 [0.13–0.27] | 0.27 [0.21–0.34] | 0.40 [0.33–0.46] | 0.43 [0.37–0.49] | 0.50 [0.44–0.56] |
| gaps | top-1 | 0.18 [0.10–0.31] | 0.30 [0.19–0.44] | 0.48 [0.35–0.61] | 0.58 [0.44–0.71] | 0.68 [0.54–0.79] | 0.78 [0.65–0.87] |
| gaps | top-5 | 0.36 [0.24–0.50] | 0.50 [0.37–0.63] | 0.68 [0.54–0.79] | 0.80 [0.67–0.89] | 0.86 [0.74–0.93] | 0.92 [0.81–0.97] |
| gaps | P(gold) | 0.11 [0.06–0.15] | 0.20 [0.14–0.28] | 0.29 [0.22–0.36] | 0.35 [0.29–0.42] | 0.42 [0.36–0.50] | 0.50 [0.44–0.56] |

<!-- Reading: 60 points of top-1 headroom between the complaint alone (0.18) and the full case (0.78).
     For comparison, with 4 multiple-choice options the same cases went 0.50 -> 0.96 (run mediq_oneshot_v1):
     options hide most of the difficulty, which is why open-ended is the headline setting. -->

**Calibration (does one-shot know when it's missing information?)**

| stated confidence in top answer | n views | actual top-1 accuracy |
|---|---|---|
| 0.0–0.4 (mean 0.34) | 93 | 0.15 |
| 0.4–0.6 (mean 0.45) | 259 | 0.49 |
| 0.6–0.8 (mean 0.64) | 135 | 0.76 |
| 0.8–1.0 (mean 0.85) | 13 | 0.92 |

Expected calibration error (ECE) = 0.087. Mean confidence rises only from 0.38 (complaint only) to 0.58 (full case), while accuracy rises from 0.18 to 0.78. Confidence ranks answers reasonably well but is compressed, and it is overconfident when information is scarce. That is why a confidence-based "stop asking" rule would be unreliable on this model.

---

## Baselines 2 and 4: asking questions vs. getting facts

<!-- All arms start from the complaint only and diagnose with the same prompt after each step.
     prompted asking: LLM asks 1 question per turn (MediQ-Basic style, fixed budget of 5, no early stop);
                      a fact-select patient answers with the matching hidden facts or "cannot answer".
     random facts:    k hidden facts revealed at random (the matched-information control).
     best-k ceiling:  greedy oracle; each step reveals the hidden fact that most raises P(gold).
                      Uses the gold label, so it is an upper bound on any k-question asker. -->

| k | arm | top-1 | top-5 | P(gold) |
|---|---|---|---|---|
| 0 | one-shot (complaint only) | 0.18 [0.10–0.31] | 0.36 [0.24–0.50] | 0.11 [0.06–0.15] |
| 1 | prompted asking (1 question) | 0.36 [0.24–0.50] | 0.54 [0.40–0.67] | 0.21 [0.14–0.27] |
| 1 | random facts (1 fact) | 0.28 [0.17–0.42] | 0.48 [0.35–0.61] | 0.18 [0.12–0.25] |
| 1 | best-k ceiling (1 fact) | 0.74 [0.60–0.84] | 0.92 [0.81–0.97] | 0.46 [0.40–0.53] |
| 2 | prompted asking | 0.32 [0.21–0.46] | 0.54 [0.40–0.67] | 0.21 [0.14–0.28] |
| 2 | random facts | 0.48 [0.35–0.61] | 0.68 [0.54–0.79] | 0.29 [0.22–0.36] |
| 2 | best-k ceiling | 0.86 [0.74–0.93] | 0.94 [0.84–0.98] | 0.55 [0.48–0.61] |
| 3 | prompted asking | 0.36 [0.24–0.50] | 0.60 [0.46–0.72] | 0.24 [0.16–0.31] |
| 3 | random facts | 0.50 [0.37–0.63] | 0.68 [0.54–0.79] | 0.30 [0.23–0.37] |
| 3 | best-k ceiling | 0.86 [0.74–0.93] | 0.96 [0.87–0.99] | 0.58 [0.52–0.64] |
| 4 | prompted asking | 0.44 [0.31–0.58] | 0.62 [0.48–0.74] | 0.28 [0.20–0.36] |
| 4 | random facts | 0.68 [0.54–0.79] | 0.86 [0.74–0.93] | 0.40 [0.33–0.47] |
| 5 | prompted asking | 0.50 [0.37–0.63] | 0.64 [0.50–0.76] | 0.30 [0.22–0.39] |
| 5 | random facts | 0.62 [0.48–0.74] | 0.82 [0.69–0.90] | 0.39 [0.32–0.46] |
| all | full case (oracle) | 0.78 [0.65–0.87] | 0.92 [0.81–0.97] | 0.50 [0.43–0.57] |

**Prompted-asking behaviour:** 250 questions in total. **57% returned no new fact** (the record didn't contain the answer), and only 2 were exact repeats. That works out to 0.56 facts per question, 2.78 facts on average after 5 questions, and 4 cases that got nothing at all.

**Same comparison at equal facts obtained** (each asking step paired with the random arm at the same number of facts, same case):

| facts obtained | n | asking top-1 | random top-1 | asking P(gold) | random P(gold) |
|---|---|---|---|---|---|
| 1 | 35 | 0.37 | 0.23 | 0.21 | 0.15 |
| 2 | 26 | 0.38 | 0.27 | 0.27 | 0.20 |
| 3 | 18 | 0.50 | 0.44 | 0.30 | 0.24 |
| 4 | 17 | 0.65 | 0.65 | 0.39 | 0.34 |
| 5 | 7 | 0.71 | 0.57 | 0.49 | 0.36 |

<!-- Reading: per QUESTION the asker loses to random facts (27% vs 40% of the gap closed at k=3,
     measured on P(gold)), but per FACT it wins at every level. The LLM picks better facts than chance; it just
     asks about things the record can't answer more than half the time. -->

**Gap closed at k=3** = (arm − one-shot) / (best-k − one-shot), on P(gold): prompted asking **27%**, random facts **40%**.

---

## Baseline 3: gap identification (the copilot's "what's missing?" output)

<!-- One call per view: the LLM lists the 5 most important missing items / follow-up questions.
     A judge marks which hidden facts those 5 questions would uncover.
     hidden-fact recall = share of ALL hidden facts covered.
     key-fact recall    = share of the facts best-k found diagnostically useful (raised P(gold)) that are covered.
     47/50 cases have at least one such key fact. -->

| starting view | hidden-fact recall (5 questions) | key-fact recall | n cases with key facts hidden |
|---|---|---|---|
| prefix p=0.0 (complaint only) | 0.33 [0.28–0.38] | 0.42 [0.30–0.54] | 47 |
| prefix p=0.2 | 0.32 [0.26–0.38] | 0.41 [0.29–0.53] | 46 |
| prefix p=0.4 | 0.34 [0.28–0.41] | 0.41 [0.27–0.55] | 40 |
| gaps p=0.2 | 0.31 [0.26–0.37] | 0.33 [0.21–0.45] | 43 |
| gaps p=0.4 | 0.35 [0.30–0.41] | 0.37 [0.25–0.51] | 40 |

For comparison, the prompted asker actually *obtained* 0.42 [0.31–0.54] of the key facts with its 5 sequential questions, the same as the planned list of 5.

---

## What these baselines say

1. **There is a lot of headroom.** Open-ended top-1 goes from 0.18 (complaint only) to 0.78 (full case), and the best one or two facts alone reach 0.74–0.86.
2. **Plain prompted asking replicates MediQ's finding, for a specific reason.** Per question it does *worse* than revealing random facts. Per fact it does *better*. The loss comes from wasted questions (57% unanswerable), not from bad clinical judgement.
3. **The improvement targets for your agent are concrete:**
   - **Hit rate:** ask questions the case can answer, i.e. ask about standard history, exam and lab categories rather than speculative specifics. Raising the hit rate from 43% toward the ~100% that random facts gets would, by the equal-facts table, put the asker above random.
   - **Choice:** the best-k ceiling shows one or two well-chosen facts are worth almost the whole case. Asking currently gets 0.42 of the key facts; the ceiling is 1.0.
   - **Gap flagging:** a planned list of 5 questions finds only a third of the hidden facts and about 40% of the key ones.
4. **Headline comparison for future systems:** at a budget of k=3 questions, report top-1, P(gold) and gap closed against this table. The targets to beat are prompted asking (27%) and random facts (40%). Also report key-fact recall against 0.42.

## Caveats (state these next to any comparison)

- **Small n:** 50 cases, so differences under ~0.15 in top-1 aren't significant.
- **The best-k ceiling is optimistic.** It picks, from ~10 trials per step, the one that scored best against the gold label, so some of its lead is lucky draws (this inflates any best-of-N maximum). That's why it beats the full case (0.86 vs 0.78). Treat it as a loose ceiling.
- **"Cannot answer" is a benchmark artifact.** MedQA vignettes list only some facts. A real patient asked about bruising would say "no", which is informative, but here it returns nothing. MediQ's own Fact-Select patient behaves the same way. Part of the asker's waste is therefore not a real clinical failure.
- **The judge is not yet human-validated.** Hand-check `runs/mediq_open_v1/judge_review.csv` (30 decisions) before presenting.
- **One cheap model throughout:** stronger models may ask better (MediQ found GPT-4 already roughly matched Initial with Basic asking).
- **No early stopping:** the asker had a fixed budget of 5. MediQ's stopping (abstention) mechanism is not included here.

## Reproduce (free from cache)

```
cd "/Users/ardadastan/224V Project/ddx-genie"
uv run python -m ddx_genie.partial_eval --run-id mediq_open_v1 --limit 50 --confirmed   # baseline 1
uv run python -m ddx_genie.baselines --run-id baselines_v1 --limit 50 --confirmed       # baselines 2-4
uv run python scripts/baseline_report.py                                                # tables above
```
