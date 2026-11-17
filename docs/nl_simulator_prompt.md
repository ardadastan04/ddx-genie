# Natural-language patient simulator (optional extension)

The default simulator answers one *variable* at a time from an answer key. A more realistic setting has the agent ask
free-text questions and a simulated patient answer in free text. Use an LLM to role-play the patient from the note.

## Simulator prompt (patient side)

```
You are role-playing a patient talking to a research coordinator who is screening you for clinical trials.
Everything you know about yourself is in the note below. Answer the coordinator's question briefly, in plain language,
as the patient would. If the note does not contain the answer, say you don't know or are not sure. Do not volunteer
information that was not asked for. Never mention the note.

# Your medical note
{patient_note}

# Coordinator's question
{question}
```

## Turning answers into SMT state

The agent must map each free-text answer onto the trial variables it asked about (true / false / number / unknown),
using the variable dictionary (`data/variables/<NCT>.json`: meaning, when_true, when_false, when_unknown). Evaluate the
mapping separately by comparing the agent's values with `data/answer_keys/gpt5_oracle.jsonl` (agreement per variable),
and evaluate the conversation end to end with `eval/evaluate.py`.

Keep the simulator model fixed across systems you compare, and log the full transcript.
