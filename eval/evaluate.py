"""Evaluate conversation logs (one JSON line per patient episode; see README for the format) against the gold labels.
Metrics: pair-level accuracy / precision / recall / F1 (eligible = positive), questions per patient and per pair,
accuracy at question budgets, informative-question rate, patient-level eligible-set precision / recall / F1 and exact match.
Usage: python eval/evaluate.py LOGS.jsonl [--budgets 0,5,10,20,30]"""
import argparse, json, os, statistics, collections
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def prf(pairs):
    tp = sum(p and g for p, g in pairs); fp = sum(p and not g for p, g in pairs); fn = sum(g and not p for p, g in pairs)
    acc = sum(p == g for p, g in pairs) / max(len(pairs), 1); P = tp / max(tp + fp, 1); R = tp / max(tp + fn, 1)
    return dict(acc=round(acc, 3), P=round(P, 3), R=round(R, 3), F1=round(2 * P * R / max(P + R, 1e-9), 3), n=len(pairs))

def main():
    ap = argparse.ArgumentParser(); ap.add_argument('logs'); ap.add_argument('--budgets', default='0,5,10,20,30')
    ap.add_argument('--split', choices=['all', 'dev', 'test'], default='all', help='patients from data/splits.json'); a = ap.parse_args()
    gold = {(p['qid'], p['nct']): p['gold'] == 'eligible' for p in map(json.loads, open(os.path.join(ROOT, 'data', 'pairs.jsonl')))}
    eps = [json.loads(l) for l in open(a.logs)]
    if a.split != 'all':
        keep = set(json.load(open(os.path.join(ROOT, 'data', 'splits.json')))[a.split]); eps = [e for e in eps if e['qid'] in keep]
    final, nq, inf, sets = [], [], [], []
    at = {int(b): [] for b in a.budgets.split(',')}
    for e in eps:
        fv = {n: v == 'eligible' for n, v in e['final_verdicts'].items()}
        for n in e['trials']: final.append((fv[n], gold[(e['qid'], n)]))
        nq.append(len(e['turns'])); inf += [t['informative'] for t in e['turns']]
        for b in at:
            v = e['initial_verdicts'] if b == 0 or not e['turns'] else e['turns'][min(b, len(e['turns'])) - 1]['verdicts']
            for n in e['trials']: at[b].append((v[n] == 'eligible', gold[(e['qid'], n)]))
        pe = {n for n in e['trials'] if fv[n]}; ge = {n for n in e['trials'] if gold[(e['qid'], n)]}
        tp = len(pe & ge); P = tp / len(pe) if pe else (1.0 if not ge else 0.0); R = tp / len(ge) if ge else 1.0
        sets.append((P, R, 2 * P * R / max(P + R, 1e-9), pe == ge))
    res = dict(pairs=prf(final),
               questions=dict(per_patient_mean=round(statistics.mean(nq), 2), per_patient_median=statistics.median(nq),
                              per_pair_mean=round(sum(nq) / max(len(final), 1), 2),
                              informative_rate=round(sum(inf) / max(len(inf), 1), 3) if inf else None),
               accuracy_at_budget={b: prf(v)['acc'] for b, v in sorted(at.items())},
               patient_sets=dict(P=round(statistics.mean(s[0] for s in sets), 3), R=round(statistics.mean(s[1] for s in sets), 3),
                                 F1=round(statistics.mean(s[2] for s in sets), 3), exact_match=round(statistics.mean(s[3] for s in sets), 3)))
    print(json.dumps(res, indent=1))

if __name__ == '__main__':
    main()
