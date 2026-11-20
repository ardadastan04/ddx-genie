"""Why does predicted answerability barely help answerable_informative? (dev only, solver only, no LLM)

The ablation (configs/ablations_dev.yaml) found that setting P(answered) = 1 costs almost nothing
(AUC 0.700 -> 0.695), while the true answerability (answerable_informative_oracle) is worth +0.083.
This module measures where the predicted P(answered) falls short:

1. **Discrimination.** AUC of P(answered) on (a) every variable in the dev answer key, (b) the
   distinct candidate questions the policy actually weighs, (c) the questions it asks, and (d) within
   a single turn's candidates (the ranking the policy really needs), averaged over turns.
2. **Calibration.** Predicted vs observed answer rate in bins of P(answered); Brier score and ECE.
3. **Decision impact.** Along answerable_informative's own conversation, at every turn, the same
   candidates are scored three ways: predicted P(answered) (the policy's actual choice), P = 1 (the
   no-answerability ablation) and the key's truth (the oracle). How often do the choices differ, and
   how often is each choice answered? "Realized value" = the chosen question's value if answered, else 0.
   Then each weighting drives its *own* conversation (DRIVERS), to see whether the no-answerability
   policy catches up over 30 questions despite worse single choices.
4. **Answer rates by question type** (kind, timeframe, qualifier, type): observed vs predicted.

P(answered) is always the policy's own model (``answerability.model_for``: dev patients get a model
fit on the other folds). The truth comes from ``--keys`` (the model is fit on ``gpt5_oracle``).

  uv run python -m smt_trial_matching.diagnostics --run-id answerability_diag_dev
"""

from __future__ import annotations

import argparse
import csv
import json
import math
from collections import defaultdict
from functools import cache
from itertools import pairwise
from multiprocessing import Pool
from pathlib import Path
from typing import Any

import numpy as np
from sklearn.metrics import roc_auc_score

from . import answerability as A
from .policies import AnswerableConfig, _neg, _undetermined, candidate_questions, score_question
from .policy_loading import ROOT

RUNS_DIR = ROOT / "runs"
BINS = np.linspace(0.0, 1.0, 11)
#: Which weighting picks the question asked (the others are only scored on the same state).
DRIVERS = {"pred": "predicted P(answered) (answerable_informative)",
           "noans": "P = 1 (no-answerability ablation)",
           "oracle": "true answerability (answerable_informative_oracle)"}


@cache
def _simulator(key: str) -> Any:
    from smtstate.sim import AnswerKeySimulator

    return AnswerKeySimulator(key)


def _type_fields(var: str, vtype: str) -> dict[str, str]:
    p = A.parse(var)
    return {"kind": str(p["kind"]), "timeframe": str(p["timeframe"]),
            "qualifier": "yes" if p["qualifier"] else "no", "vtype": vtype}


def _auc(y: list[bool], p: list[float]) -> float:
    return float(roc_auc_score(y, p)) if 0 < sum(y) < len(y) else float("nan")


# ------------------------------------------------------------------ per-patient trace


def trace_patient(args: tuple[str, list[str], str, int, str]) -> dict:
    """Run one patient's conversation driven by ``driver`` (a DRIVERS key; "pred" is
    answerable_informative itself); at each turn score the candidates all three ways."""
    from smtstate.runner import run_patient

    qid, ncts, key, budget, driver = args
    sim, cfg = _simulator(key), AnswerableConfig()
    turns: list[dict] = []
    cands: dict[tuple[str, str], dict] = {}

    def pick(rows: list[dict], p_of) -> dict | None:
        rows = [r for r in rows if r["value"] * p_of(r) > 0]
        if not rows:
            return None
        return max(rows, key=lambda r: (r["value"] * p_of(r), p_of(r), _neg(r["nct"]), _neg(r["var"])))

    def policy(states: dict, asked: set, rng: Any) -> tuple[str, str] | None:
        model = A.model_for(states)
        rows = []
        for n in _undetermined(states):
            for v in candidate_questions(states[n]):
                if (n, v) in asked:
                    continue
                vt = states[n].types[v]
                value = score_question(states[n], v, model, cfg, p_ans=1.0)
                if value <= 0:
                    continue
                r = {"nct": n, "var": v, "vtype": vt, "value": value,
                     "p": model.p_answered(v, vt), "answered": sim.answer(qid, n, v) is not None}
                rows.append(r)
                cands.setdefault((n, v), {"qid": qid, **r, **_type_fields(v, vt), "asked": False})
        pred = pick(rows, lambda r: r["p"])  # = answerable_informative's own choice
        if pred is None:
            return None
        noans = pick(rows, lambda r: 1.0)
        oracle = pick(rows, lambda r: float(r["answered"]))
        turns.append({
            "qid": qid, "turn": len(turns) + 1, "n_candidates": len(rows),
            "n_answerable": sum(r["answered"] for r in rows),
            "within_turn_auc": _auc([r["answered"] for r in rows], [r["p"] for r in rows]),
            "pred_answered": pred["answered"],
            "noans_answered": noans["answered"],
            "oracle_answered": oracle is not None,
            "pred_eq_noans": (pred["nct"], pred["var"]) == (noans["nct"], noans["var"]),
            "pred_eq_oracle": oracle is not None and (pred["nct"], pred["var"]) == (oracle["nct"], oracle["var"]),
            "pred_realized": pred["value"] * pred["answered"],
            "noans_realized": noans["value"] * noans["answered"],
            "oracle_realized": oracle["value"] if oracle else 0.0,
            "pred_p": pred["p"], "noans_p": noans["p"],
        })
        chosen = {"pred": pred, "noans": noans, "oracle": oracle}[driver]
        if chosen is None:  # the oracle stops when nothing answerable is left
            turns.pop()
            return None
        turns[-1]["chosen_answered"] = chosen["answered"]
        turns[-1]["chosen_realized"] = chosen["value"] * chosen["answered"]
        cands[(chosen["nct"], chosen["var"])]["asked"] = True
        return chosen["nct"], chosen["var"]

    ep = run_patient(qid, ncts, policy, sim, budget=budget)
    return {"qid": qid, "driver": driver, "turns": turns, "candidates": list(cands.values()),
            "asked": [(t["nct"], t["var"]) for t in ep["turns"]]}


def all_key_variables(qids: list[str], key: str) -> list[dict]:
    """Every (patient, trial, variable) in the answer key, with the cross-fitted P(answered)."""
    out = []
    for e in A.load_examples(qids, key):
        fold = A.dev_fold(e.qid)
        model = A._fold_model(fold) if fold is not None else A.fit_default()
        out.append({"qid": e.qid, "nct": e.nct, "var": e.name, "p": model.p_answered(e.name, e.vtype),
                    "answered": e.value is not None, **_type_fields(e.name, e.vtype)})
    return out


# ------------------------------------------------------------------ summaries


def calibration(rows: list[dict]) -> list[dict]:
    p = np.array([r["p"] for r in rows])
    y = np.array([r["answered"] for r in rows], dtype=float)
    out = []
    for lo, hi in pairwise(BINS):
        m = (p >= lo) & ((p < hi) if hi < 1 else (p <= hi))
        if m.any():
            out.append({"bin": f"{lo:.1f}–{hi:.1f}", "n": int(m.sum()),
                        "mean_p": float(p[m].mean()), "observed": float(y[m].mean())})
    return out


def scores(rows: list[dict]) -> dict[str, float]:
    p = np.array([r["p"] for r in rows])
    y = np.array([r["answered"] for r in rows], dtype=float)
    ece = sum(c["n"] * abs(c["mean_p"] - c["observed"]) for c in calibration(rows)) / len(rows)
    return {"n": len(rows), "answered_rate": float(y.mean()), "mean_p": float(p.mean()),
            "auc": _auc(list(y.astype(bool)), list(p)), "brier": float(((p - y) ** 2).mean()),
            "ece": float(ece)}


def by_type(rows: list[dict], field: str, min_n: int = 20) -> list[dict]:
    groups: dict[str, list[dict]] = defaultdict(list)
    for r in rows:
        groups[r[field]].append(r)
    out = [{"group": g, "n": len(rs), "observed": float(np.mean([r["answered"] for r in rs])),
            "mean_p": float(np.mean([r["p"] for r in rs]))} for g, rs in groups.items() if len(rs) >= min_n]
    return sorted(out, key=lambda d: -d["n"])


def turn_summary(turns: list[dict]) -> dict[str, float]:
    def mean(k: str, subset: list[dict] | None = None) -> float:
        rows = turns if subset is None else subset
        return float(np.mean([t[k] for t in rows])) if rows else float("nan")

    differ = [t for t in turns if not t["pred_eq_noans"]]
    return {
        "turns": len(turns),
        "mean_candidates": mean("n_candidates"),
        "share_answerable_candidates": float(sum(t["n_answerable"] for t in turns)
                                             / max(sum(t["n_candidates"] for t in turns), 1)),
        "within_turn_auc": float(np.nanmean([t["within_turn_auc"] for t in turns])),
        "pred_answered": mean("pred_answered"), "noans_answered": mean("noans_answered"),
        "oracle_answered": mean("oracle_answered"),
        "pred_eq_noans": mean("pred_eq_noans"), "pred_eq_oracle": mean("pred_eq_oracle"),
        "pred_realized": mean("pred_realized"), "noans_realized": mean("noans_realized"),
        "oracle_realized": mean("oracle_realized"),
        "differ_turns": len(differ),
        "differ_pred_answered": mean("pred_answered", differ),
        "differ_noans_answered": mean("noans_answered", differ),
        "differ_pred_p": mean("pred_p", differ), "differ_noans_p": mean("noans_p", differ),
    }


def _pct(x: float) -> str:
    return "–" if math.isnan(x) else f"{100 * x:.0f}%"


def _f(x: float, d: int = 3) -> str:
    return "–" if math.isnan(x) else f"{x:.{d}f}"


def own_section(own: dict[str, list[dict]], n_patients: int) -> list[str]:
    """Each weighting driving its own conversation: answers and realized value over the turns."""
    spans = ((1, 10), (11, 20), (21, 30))
    lines = [("**Each weighting driving its own conversation** (questions answered per patient, and "
              "realized value per patient, by turn range):"), "",
             "| driver | questions / patient | answered / patient | " + " | ".join(
                 f"answered, turns {a}–{b}" for a, b in spans) + " | realized value / patient | "
             + " | ".join(f"value, turns {a}–{b}" for a, b in spans) + " |",
             "|---|---|---|" + "---|" * (2 * len(spans) + 1)]
    for d, turns in own.items():
        def per(field: str, lo: int = 1, hi: int = 10**6, turns: list[dict] = turns) -> float:
            return sum(t[field] for t in turns if lo <= t["turn"] <= hi) / n_patients

        lines.append(
            f"| {DRIVERS[d]} | {len(turns) / n_patients:.1f} | {per('chosen_answered'):.1f} | "
            + " | ".join(f"{per('chosen_answered', a, b):.1f}" for a, b in spans)
            + f" | {per('chosen_realized'):.2f} | "
            + " | ".join(f"{per('chosen_realized', a, b):.2f}" for a, b in spans) + " |")
    return [*lines, ""]


def key_section(key: str, allv: list[dict], cands: list[dict], turns: list[dict],
                own: dict[str, list[dict]], n_patients: int) -> list[str]:
    asked = [c for c in cands if c["asked"]]
    pops = [("every variable in the answer key", allv),
            ("distinct candidates the policy weighed (value > 0)", cands),
            ("questions the policy asked", asked)]
    ts = turn_summary(turns)
    lines = [f"## Answer key `{key}`", "", "### 1–2. Discrimination and calibration of P(answered)", "",
             "| population | n | answered | mean P(answered) | AUC | Brier | ECE |", "|---|---|---|---|---|---|---|"]
    for name, rows in pops:
        s = scores(rows)
        lines.append(f"| {name} | {s['n']} | {_pct(s['answered_rate'])} | {_f(s['mean_p'], 2)} | "
                     f"{_f(s['auc'])} | {_f(s['brier'])} | {_f(s['ece'])} |")
    lines += [(f"| *within one turn's candidates* (mean over {ts['turns']} turns) | "
               f"{ts['mean_candidates']:.0f} / turn | {_pct(ts['share_answerable_candidates'])} | | "
               f"{_f(ts['within_turn_auc'])} | | |"), "",
              "Calibration on the candidates the policy weighed:", "",
              "| P(answered) bin | n | mean predicted | observed |", "|---|---|---|---|"]
    lines += [f"| {c['bin']} | {c['n']} | {c['mean_p']:.2f} | {c['observed']:.2f} |" for c in calibration(cands)]
    lines += ["", "### 3. Decision impact, turn by turn along answerable_informative's conversations", "",
              ("Same state, same candidates, three ways to weigh them. *Realized value* = the chosen "
               "question's value if it gets an answer, else 0 (mean per turn)."), "",
              "| weighting | choice answered | realized value | same choice as predicted |",
              "|---|---|---|---|",
              f"| predicted P(answered) (the policy) | {_pct(ts['pred_answered'])} | {_f(ts['pred_realized'])} | – |",
              f"| P = 1 (no-answerability ablation) | {_pct(ts['noans_answered'])} | {_f(ts['noans_realized'])} | {_pct(ts['pred_eq_noans'])} |",
              f"| true answerability (oracle) | {_pct(ts['oracle_answered'])} | {_f(ts['oracle_realized'])} | {_pct(ts['pred_eq_oracle'])} |",
              "",
              (f"On the {ts['differ_turns']} turns where predicted P(answered) changes the choice: "
               f"the policy's choice is answered {_pct(ts['differ_pred_answered'])} of the time "
               f"(mean predicted P {ts['differ_pred_p']:.2f}) vs {_pct(ts['differ_noans_answered'])} for "
               f"the P = 1 choice (mean predicted P {ts['differ_noans_p']:.2f})."), "",
              ]
    lines += own_section(own, n_patients)
    lines += ["### 4. Answer rate by question type (every variable in the answer key)", ""]
    for field in ("kind", "timeframe", "qualifier", "vtype"):
        lines += [f"| {field} | n | observed answered | mean predicted |", "|---|---|---|---|"]
        lines += [f"| {g['group']} | {g['n']} | {_pct(g['observed'])} | {_pct(g['mean_p'])} |"
                  for g in by_type(allv, field)]
        lines.append("")
    return lines


def reliability_plot(per_key: dict[str, list[dict]], path: Path) -> None:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    fig, ax = plt.subplots(figsize=(5, 5))
    ax.plot([0, 1], [0, 1], ls="--", c="#888", lw=1, label="perfect calibration")
    for (key, rows), color in zip(per_key.items(), ("#264653", "#e76f51")):
        cal = calibration(rows)
        ax.plot([c["mean_p"] for c in cal], [c["observed"] for c in cal], "o-", c=color,
                label=f"truth: {key}")
    ax.set(xlabel="predicted P(answered)", ylabel="observed answer rate", xlim=(0, 1), ylim=(0, 1),
           title="Calibration on candidates the policy weighed (dev)")
    ax.legend(loc="upper left", frameon=False)
    fig.tight_layout()
    fig.savefig(path, dpi=150)
    plt.close(fig)


def _write_csv(path: Path, rows: list[dict]) -> None:
    if not rows:
        return
    with path.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]))
        w.writeheader()
        w.writerows(rows)


def main(argv: list[str] | None = None) -> int:
    from .experiment import patients

    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--run-id", required=True)
    ap.add_argument("--keys", default="gpt5_oracle,gpt5mini")
    ap.add_argument("--budget", type=int, default=30)
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--workers", type=int, default=8)
    a = ap.parse_args(argv)  # dev only by design: no --split flag

    out = RUNS_DIR / a.run_id
    out.mkdir(parents=True, exist_ok=True)
    pts = patients("dev", a.limit)
    keys = [k.strip() for k in a.keys.split(",") if k.strip()]
    lines = ["# Answerability diagnostics (dev, answerable_informative)", "",
             (f"{len(pts)} dev patients, budget {a.budget}. P(answered) is the policy's own model "
              "(cross-fitted by patient fold, fit on `gpt5_oracle`). See "
              "`src/smt_trial_matching/diagnostics.py` for definitions."), ""]
    cal_rows = {}
    for key in keys:
        print(f"[{key}] tracing {len(pts)} patients ...", flush=True)
        own: dict[str, list[dict]] = {}
        with Pool(a.workers) as pool:
            for d in DRIVERS:
                tr_d = list(pool.imap(trace_patient, [(q, n, key, a.budget, d) for q, n in pts]))
                own[d] = [t for tr in tr_d for t in tr["turns"]]
                if d == "pred":
                    traces = tr_d
        turns = own["pred"]
        cands = [c for tr in traces for c in tr["candidates"]]
        allv = all_key_variables([q for q, _ in pts], key)
        kdir = out / key
        kdir.mkdir(exist_ok=True)
        _write_csv(kdir / "turns.csv", turns)
        _write_csv(kdir / "candidates.csv", cands)
        (kdir / "asked.json").write_text(json.dumps({tr["qid"]: tr["asked"] for tr in traces}) + "\n")
        lines += key_section(key, allv, cands, turns, own, len(pts))
        cal_rows[key] = cands
    reliability_plot(cal_rows, out / "reliability.png")
    lines += [("Files: `<key>/turns.csv` (one row per turn), `<key>/candidates.csv` (one row per "
               "distinct candidate), `reliability.png`."), ""]
    text = "\n".join(lines)
    (out / "answerability_diagnostics.md").write_text(text)
    print(text)
    print(f"wrote {out.relative_to(ROOT)}/")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
