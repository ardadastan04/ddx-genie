# LLM-only conversation baseline (no SMT state)

An LLM converses with the (simulated) patient and decides eligibility from the trial's criteria text directly,
without programs or variables. This is the main comparison for "does SMT state help?".

## Questioner prompt (one turn)

```
You are screening a patient for these clinical trials. You may ask ONE short question per turn, or stop.
When you stop, give a verdict for every trial: eligible or ineligible. Treat criteria the patient cannot answer as
satisfied (unknown facts do not disqualify); declare ineligible only if an answer shows a criterion fails.

# Trials (title, inclusion, exclusion)
{trials}

# Conversation so far
{transcript}

Reply with JSON: {"action": "ask", "question": "..."}  or  {"action": "stop", "verdicts": {"<NCT>": "eligible"|"ineligible"}}
```

Log the episode in the same JSON format as `smtstate/runner.py` (one turn per question; put the verdicts the model would
give at each turn, or its final verdicts at every turn if it only decides at the end) so `eval/evaluate.py` applies.
The missing-data instruction matters: without it, LLM-only baselines become very conservative (they reject most eligible
patients), which makes the comparison unfair.
