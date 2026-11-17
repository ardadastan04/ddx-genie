"""Run question-asking policies on a split and report accuracy vs budget with paired tests.

Solver only (answer-key simulator), no LLM calls. Reuses the CA's ``smtstate.runner.run_patient``
and ``smtstate.sim.AnswerKeySimulator`` exactly as ``baselines/run_baselines.py`` does: seed 0,
same budget semantics, a multiprocessing pool over patients.

Policies: CA names (``no_questions``, ``random_stop``, ``greedy_smt``, ``ask_all``) or
``module.path:function`` / ``path/to/file.py:function`` with the CA's signature
``(states, asked, rng) -> (nct, var) | None``. See ``policy_loading.py``.

Answer keys: ``--keys gpt5_oracle,gpt5mini`` runs every policy against each key (default
``gpt5_oracle``). Paired tests compare policies within a key, never across keys.

Every question is labelled ``useful_answered`` (informative, answered), ``useful_unanswered``
(informative, answer unknown) or ``not_useful`` (could not change any trial's status).

Outputs in ``runs/<run_id>/``: ``config.json``; per key ``<key>/<policy>.jsonl`` (CA log format;
reused unless ``--force``), ``<key>/accuracy_vs_budget.png`` and ``<key>/answered_vs_budget.png``;
and across keys ``curves.csv``, ``tests.csv``, ``questions.csv``, ``waste_breakdown.png`` and
``summary.md``. Every CSV has a ``key`` column.

  uv run python -m smt_trial_matching.experiment \\
    --policies no_questions,random_stop,greedy_smt --reference greedy_smt \\
    --split dev --budget 30 --run-id harness_demo_dev
"""

from __future__ import annotations

import argparse
import collections
import csv
import json
import math
import subprocess
from dataclasses import dataclass
from datetime import UTC, datetime
from functools import cache
from multiprocessing import Pool
from pathlib import Path

from . import metrics as M
from .plots import accuracy_plot, answered_plot, waste_plot
from .policy_loading import ROOT, load_policy, policy_label

RUNS_DIR = ROOT / "runs"
SUMMARY_KS = (0, 5, 10, 20, 30)


# ------------------------------------------------------------------ running


@cache
def _simulator(key: str):
    from smtstate.sim import AnswerKeySimulator

    return AnswerKeySimulator(key)


def _episode(args: tuple[str, list[str], str, str, int]) -> dict:
    """One patient, as baselines/run_baselines.py's _one (minus read_note)."""
    from smtstate.runner import run_patient

    qid, ncts, spec, key, budget = args
    policy, sim = load_policy(spec), _simulator(key)
    bind = getattr(policy, "for_patient", None)  # oracle policies only (see policies.py)
    return run_patient(qid, ncts, bind(qid, sim) if bind else policy, sim, budget=budget)


def _read_note(args: tuple[str, list[str], str]) -> list[tuple[str, str, str]]:
    """read_note verdicts for one patient: every value of the key at once (the ceiling)."""
    from smtstate.state import TrialState

    qid, ncts, key = args
    keys = _simulator(key).keys
    return [(qid, n, TrialState(n, dict(keys.get(f"{qid}__{n}", {}))).verdict()) for n in ncts]


def patients(split: str, limit: int = 0) -> list[tuple[str, list[str]]]:
    """(qid, trials) for the split's patients, in qid order (as run_baselines.patients)."""
    by = collections.defaultdict(list)
    for p in map(json.loads, (ROOT / "data" / "pairs.jsonl").open()):
        by[p["qid"]].append(p["nct"])
    keep = set(M.load_split(split))
    return [(q, n) for q, n in sorted(by.items()) if q in keep][: limit or None]


def run_policy(spec: str, pts: list[tuple[str, list[str]]], key: str, budget: int,
               out: Path, workers: int) -> None:
    load_policy(spec)  # fail fast in the parent on a bad spec
    tmp = out.with_suffix(".jsonl.tmp")
    with Pool(workers) as pool, tmp.open("w") as f:
        for ep in pool.imap(_episode, [(q, n, spec, key, budget) for q, n in pts]):
            f.write(json.dumps(ep) + "\n")
    tmp.replace(out)


def ceiling_accuracy(pts: list[tuple[str, list[str]]], key: str, gold: dict, workers: int) -> float:
    with Pool(workers) as pool:
        rows = [r for chunk in pool.imap(_read_note, [(q, n, key) for q, n in pts]) for r in chunk]
    return sum((v == "eligible") == gold[(q, n)] for q, n, v in rows) / len(rows)


def git_commit() -> str:
    def git(*a: str) -> str:
        return subprocess.run(["git", *a], cwd=ROOT, capture_output=True, text=True,
                              check=False).stdout.strip()

    sha = git("rev-parse", "HEAD")
    return sha + ("-dirty" if git("status", "--porcelain", "--untracked-files=no") else "")


# ------------------------------------------------------------------ reporting


def _fmt(x: float | None, digits: int = 3) -> str:
    return "" if x is None or (isinstance(x, float) and math.isnan(x)) else f"{x:.{digits}f}"


def _p(p: float) -> str:
    return "<.001" if p < 0.001 else f"{p:.3f}".lstrip("0")


def _ci(v: tuple[float, float, float], digits: int = 3) -> str:
    return f"{v[0]:.{digits}f} [{v[1]:.2f}–{v[2]:.2f}]"


@dataclass
class KeyResult:
    """Everything computed for one answer key."""

    key: str
    episodes: dict[str, list[dict]]  # policy -> episodes, in qid order
    curves: dict[str, dict]  # policy -> metric -> per k (value, lo, hi)
    auc: dict[str, tuple[float, float, float]]
    tests: dict[str, list[dict]]
    ceiling: float


def write_curves(path: Path, results: list[KeyResult], ks: list) -> None:
    with path.open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["key", "policy", "k", "metric", "value", "ci_low", "ci_high"])
        for r in results:
            for name, cur in r.curves.items():
                for metric, vals in cur.items():
                    for k, (v, lo, hi) in zip(ks, vals):
                        w.writerow([r.key, name, k, metric, _fmt(v, 4), _fmt(lo, 4), _fmt(hi, 4)])
                v, lo, hi = r.auc[name]
                w.writerow([r.key, name, M.AUC, "accuracy_auc", _fmt(v, 4), _fmt(lo, 4), _fmt(hi, 4)])


def write_tests(path: Path, results: list[KeyResult], reference: str) -> None:
    cols = ["key", "policy", "reference", "k", "test", "stat", "p",
            "ci_low", "ci_high", "only_policy", "only_reference"]
    with path.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=cols)
        w.writeheader()
        for res in results:
            for name, rows in res.tests.items():
                for r in rows:
                    w.writerow({"key": res.key, "policy": name, "reference": reference, **r,
                                "stat": _fmt(float(r["stat"]), 4), "p": _fmt(r["p"], 4),
                                "ci_low": _fmt(r.get("ci_low"), 4),
                                "ci_high": _fmt(r.get("ci_high"), 4)})


@cache
def _meanings(nct: str) -> dict[str, str]:
    rows = json.load((ROOT / "data" / "variables" / f"{nct}.json").open())
    return {v["name"]: v.get("meaning", "") for v in rows}


def write_questions(path: Path, results: list[KeyResult]) -> None:
    """One row per question asked: policy, key, qid, turn, nct, var, meaning, answer, label."""
    with path.open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["policy", "key", "qid", "turn", "nct", "var", "meaning", "answer", "label"])
        for r in results:
            for name, eps in r.episodes.items():
                for ep in eps:
                    for i, t in enumerate(ep["turns"], 1):
                        ans = "unknown" if t["answer"] is None else json.dumps(t["answer"])
                        w.writerow([name, r.key, ep["qid"], i, t["nct"], t["var"],
                                    _meanings(t["nct"]).get(t["var"], ""), ans, M.label(t)])


def _key_section(cfg: dict, r: KeyResult, ks: list) -> list[str]:
    cols = [k for k in SUMMARY_KS if k <= cfg["budget"]] + [M.FINAL]
    head = " | ".join(f"k={k}" if k != M.FINAL else "final" for k in cols)
    lines = [
        f"## Answer key `{r.key}`",
        "",
        "### Pair-level accuracy [95% CI]",
        "",
        (f"AUC = area under accuracy vs k over k = 0..{cfg['budget']}, divided by the budget "
         "(average accuracy across budgets, 0–1)."),
        "",
        f"| policy | {head} | AUC | questions / patient |",
        "|---|" + "---|" * (len(cols) + 2),
    ]
    for name, cur in r.curves.items():
        cells = [_ci(cur["accuracy"][ks.index(k)]) for k in cols]
        lines.append(f"| {name} | " + " | ".join(cells)
                     + f" | {_ci(r.auc[name])} | {cur['questions_per_patient'][-1][0]:.1f} |")
    lines += [
        (f"| read_note `{r.key}` (ceiling) | " + " | ".join(["–"] * (len(cols) - 1))
         + f" | {r.ceiling:.3f} | – | 0 |"),
        "",
        "### Where the questions go (all questions asked, final)",
        "",
        ("useful = could change some trial's status when asked; answered = the answer was not "
         "unknown. An unknown answer never changes a status, so only *useful, answered* questions "
         "can move a verdict."),
        "",
        "| policy | questions / patient | useful, answered | useful, unanswered | not useful | F1 (eligible +) | patient set F1 |",
        "|---|---|---|---|---|---|---|",
    ]
    for name, cur in r.curves.items():
        sh = [_fmt(cur[f"share_{lab}"][-1][0]) for lab in M.LABELS]
        lines.append(f"| {name} | {cur['questions_per_patient'][-1][0]:.1f} | " + " | ".join(sh)
                     + f" | {_fmt(cur['f1'][-1][0])} | {_fmt(cur['set_f1'][-1][0])} |")
    if r.tests:
        lines += [
            "",
            f"### Paired tests vs `{cfg['reference']}`",
            "",
            ("Differences are policy minus reference, with a paired bootstrap over patients "
             "(95% CI, two-sided p). **Pairs within a patient are not independent, so the patient "
             "bootstrap is the primary test; McNemar on pairs is secondary.**"),
            "",
            "| policy | k | Δ accuracy [95% CI], p | Δ set F1 [95% CI], p | McNemar (only policy – only ref), p |",
            "|---|---|---|---|---|",
        ]
        for name, rows in r.tests.items():
            by = collections.defaultdict(dict)
            for t in rows:
                by[t["k"]][t["test"]] = t
            for k, t in by.items():
                if k == M.AUC:
                    a = t["bootstrap_auc_diff"]
                    lines.append(f"| {name} | **AUC** | {a['stat']:+.3f} [{a['ci_low']:+.2f}, "
                                 f"{a['ci_high']:+.2f}], {_p(a['p'])} | | |")
                    continue
                a, s, m = t["bootstrap_accuracy_diff"], t["bootstrap_set_f1_diff"], t["mcnemar_pairs"]
                lines.append(
                    f"| {name} | {k} | {a['stat']:+.3f} [{a['ci_low']:+.2f}, {a['ci_high']:+.2f}], {_p(a['p'])} "
                    f"| {s['stat']:+.3f} [{s['ci_low']:+.2f}, {s['ci_high']:+.2f}], {_p(s['p'])} "
                    f"| {m['only_policy']}–{m['only_reference']}, {_p(m['p'])} |")
    return [*lines, ""]


def summary_md(cfg: dict, results: list[KeyResult], ks: list) -> str:
    oracles = [n for n, s in cfg["policies"].items() if getattr(load_policy(s), "for_patient", None)]
    lines = [
        f"# {cfg['run_id']}: accuracy vs question budget",
        "",
        (f"Split `{cfg['split']}` ({cfg['n_patients']} patients, {cfg['n_pairs']} pairs), answer "
         f"keys {', '.join(f'`{k}`' for k in cfg['keys'])}, budget {cfg['budget']}, commit "
         f"`{cfg['git_commit'][:12]}`. 95% CIs bootstrap over patients (2,000 resamples, seed 0)."),
        "",
    ]
    if oracles:
        lines += [(f"**Oracle policies (read the answer key; upper bounds, not methods):** "
                   f"{', '.join(f'`{n}`' for n in oracles)}."), ""]
    for r in results:
        lines += _key_section(cfg, r, ks)
    lines += [("Files: `curves.csv`, `tests.csv`, `questions.csv`, `waste_breakdown.png`, "
               "`<key>/accuracy_vs_budget.png`, `<key>/answered_vs_budget.png`."), ""]
    return "\n".join(lines)


# ------------------------------------------------------------------ CLI


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--policies", required=True,
                    help="comma-separated CA names or module.path:function / file.py:function")
    ap.add_argument("--reference", default="greedy_smt", help="policy the paired tests compare against")
    ap.add_argument("--split", choices=("dev", "test"), default="dev")
    ap.add_argument("--confirmed", action="store_true", help="required for --split test")
    ap.add_argument("--budget", type=int, default=30)
    ap.add_argument("--keys", "--key", dest="keys", default="gpt5_oracle",
                    help="comma-separated answer keys in data/answer_keys/, e.g. gpt5_oracle,gpt5mini")
    ap.add_argument("--run-id", required=True)
    ap.add_argument("--limit", type=int, default=0, help="first N patients of the split (quick checks)")
    ap.add_argument("--force", action="store_true", help="re-run policies whose log already exists")
    ap.add_argument("--workers", type=int, default=8)
    a = ap.parse_args(argv)
    if a.split == "test" and not a.confirmed:
        ap.error("--split test needs --confirmed (run the test split once per final system, "
                 "after the project lead's OK)")
    a.keys = [k.strip() for k in a.keys.split(",") if k.strip()]
    for k in a.keys:
        if not (ROOT / "data" / "answer_keys" / f"{k}.jsonl").exists():
            ap.error(f"no answer key data/answer_keys/{k}.jsonl")
    return a


def run_key(key: str, names: list[str], specs: list[str], ref_name: str,
            pts: list[tuple[str, list[str]]], gold: dict, a: argparse.Namespace,
            out: Path) -> KeyResult:
    kdir = out / key
    kdir.mkdir(parents=True, exist_ok=True)
    qids = [q for q, _ in pts]
    episodes, tables = {}, {}
    for name, spec in zip(names, specs):
        log = kdir / f"{name}.jsonl"
        if log.exists() and not a.force:
            print(f"[{key}] {name}: reusing {log.relative_to(ROOT)} (--force to re-run)")
        else:
            print(f"[{key}] {name}: running {len(pts)} patients ...", flush=True)
            run_policy(spec, pts, key, a.budget, log, a.workers)
        by_qid = {e["qid"]: e for e in M.load_log(log)}
        missing = [q for q in qids if q not in by_qid]
        if missing:
            raise SystemExit(f"{log} lacks {len(missing)} patients of this selection; use --force")
        episodes[name] = [by_qid[q] for q in qids]
        tables[name] = M.build_table(episodes[name], gold, a.budget)

    idx = M.boot_indices(len(qids))
    result = KeyResult(
        key=key, episodes=episodes,
        curves={n: M.curves(t, idx) for n, t in tables.items()},
        auc={n: M.auc_ci(t, idx, a.budget) for n, t in tables.items()},
        tests={n: M.paired_tests(t, tables[ref_name], idx, a.budget)
               for n, t in tables.items() if n != ref_name},
        ceiling=ceiling_accuracy(pts, key, gold, a.workers))

    rng = slice(0, a.budget + 1)
    cur = result.curves
    # Floor: no_questions if it was run, else every policy's k=0 (the same initial verdicts).
    floor = cur.get("no_questions", cur[names[0]])["accuracy"][0][0]
    title = f"{a.split} ({len(qids)} patients), key {key}"
    accuracy_plot({n: c["accuracy"][rng] for n, c in cur.items()}, result.ceiling, floor, title,
                  kdir / "accuracy_vs_budget.png")
    answered_plot({n: c["answered_per_patient"][rng] for n, c in cur.items()},
                  {n: c["questions_per_patient"][rng] for n, c in cur.items()}, title,
                  kdir / "answered_vs_budget.png")
    return result


def main(argv: list[str] | None = None) -> int:
    a = parse_args(argv)
    specs = [s.strip() for s in a.policies.split(",") if s.strip()]
    names = [policy_label(s) for s in specs]
    if len(set(names)) != len(names):
        raise SystemExit(f"policy names collide: {names}")
    ref_name = policy_label(a.reference)
    if a.reference not in specs and ref_name not in names:
        specs.append(a.reference)
        names.append(ref_name)
    for s in specs:
        load_policy(s)  # fail fast on a bad spec

    out = RUNS_DIR / a.run_id
    out.mkdir(parents=True, exist_ok=True)
    pts = patients(a.split, a.limit)
    gold = M.load_gold()
    cfg = {"run_id": a.run_id, "policies": dict(zip(names, specs)), "reference": ref_name,
           "split": a.split, "keys": a.keys, "budget": a.budget, "limit": a.limit,
           "n_patients": len(pts), "n_pairs": sum(len(n) for _, n in pts),
           "git_commit": git_commit(), "created": datetime.now(UTC).isoformat(timespec="seconds")}
    (out / "config.json").write_text(json.dumps(cfg, indent=2) + "\n")

    results = [run_key(k, names, specs, ref_name, pts, gold, a, out) for k in a.keys]
    ks = [*range(a.budget + 1), M.FINAL]
    write_curves(out / "curves.csv", results, ks)
    write_tests(out / "tests.csv", results, ref_name)
    write_questions(out / "questions.csv", results)
    waste_plot({r.key: {n: [c[f"share_{lab}"][-1][0] for lab in M.LABELS]
                        for n, c in r.curves.items()} for r in results},
               {r.key: {n: c["questions_per_patient"][-1][0] for n, c in r.curves.items()}
                for r in results},
               M.LABELS, f"{a.split} ({len(pts)} patients)", out / "waste_breakdown.png")
    text = summary_md(cfg, results, ks)
    (out / "summary.md").write_text(text)
    print(text)
    print(f"wrote {out.relative_to(ROOT)}/")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
