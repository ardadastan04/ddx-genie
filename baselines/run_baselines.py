"""Run a baseline policy on every patient (multi-trial conversations) and write episode logs.
Usage: python baselines/run_baselines.py POLICY [--key gpt5_oracle] [--budget 30] [--out logs/POLICY.jsonl] [--limit N]
Also: python baselines/run_baselines.py read_note --key gpt5mini   (no conversation: all of the key's answers at once)"""
import argparse, json, os, sys, collections
from multiprocessing import Pool
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, ROOT); sys.path.insert(0, os.path.join(ROOT, 'baselines'))
from smtstate.runner import run_patient
from smtstate.sim import AnswerKeySimulator
from smtstate.state import TrialState
from policies import POLICIES

def patients():
    P = [json.loads(l) for l in open(os.path.join(ROOT, 'data', 'pairs.jsonl'))]
    by = collections.defaultdict(list)
    for p in P: by[p['qid']].append(p['nct'])
    return sorted(by.items())

def _one(args):
    qid, ncts, policy, key, budget = args
    sim = AnswerKeySimulator(key)
    if policy == 'read_note':
        verd = {}
        for n in ncts:
            s = TrialState(n, dict(sim.keys.get(f'{qid}__{n}', {}))); verd[n] = s.verdict()
        return dict(qid=qid, trials=ncts, turns=[], initial_verdicts=verd, final_verdicts=verd, final_status={})
    return run_patient(qid, ncts, POLICIES[policy], sim, budget=budget)

if __name__ == '__main__':
    ap = argparse.ArgumentParser(); ap.add_argument('policy'); ap.add_argument('--key', default='gpt5_oracle')
    ap.add_argument('--budget', type=int, default=30); ap.add_argument('--out'); ap.add_argument('--limit', type=int, default=0)
    ap.add_argument('--workers', type=int, default=8); a = ap.parse_args()
    pts = patients()[:a.limit or None]
    out = a.out or os.path.join(ROOT, 'logs', f'{a.policy}_{a.key}.jsonl'); os.makedirs(os.path.dirname(out), exist_ok=True)
    with Pool(a.workers) as pool, open(out, 'w') as f:
        for ep in pool.imap(_one, [(q, n, a.policy, a.key, a.budget) for q, n in pts]):
            f.write(json.dumps(ep) + '\n')
    print('wrote', out)
