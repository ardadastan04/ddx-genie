"""Patient simulators.

AnswerKeySimulator answers a question about one variable from a stored answer key (values extracted from the patient's
note by a strong model). 'unknown' (None) means the note does not settle it, which is what a real patient often says.
Keys: 'gpt5_oracle' (GPT-5 reading of the full note; reaches the gold label on 348/363 pairs when fully asked) and
'gpt5mini' (the reader used for the paper's GPT-5-mini row).
A natural-language simulator (an LLM role-playing the patient from the note) is described in README.md."""
import json, os
DATA = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'data')

class AnswerKeySimulator:
    def __init__(self, key='gpt5_oracle'):
        self.keys = {}
        for l in open(os.path.join(DATA, 'answer_keys', f'{key}.jsonl')):
            o = json.loads(l); self.keys[o['pair']] = o['assign']

    def answer(self, qid, nct, var):
        """Value of `var` for patient `qid` (looked up in the trial's pair key; variables are trial-specific)."""
        return self.keys.get(f'{qid}__{nct}', {}).get(var)
