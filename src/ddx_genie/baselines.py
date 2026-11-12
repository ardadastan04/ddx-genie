"""LLM baselines that any gap-filling agent will be compared against (MediQ, open-ended).

All baselines start from the same place -- the case's initial information (the p=0
view: demographics + presenting complaint) -- use the same cheap model, and score with
the same open-ended diagnosis prompt and judge as ``partial_eval.py``. Facts handed to
the diagnosis step are always the case's own atomic facts in source order, so the only
thing that differs between arms is *which* facts were obtained.

``asking``  (baseline 2, MediQ-Basic style)
    An LLM asks one question per turn for k = 1..K_ASK turns, with no option to stop
    early (fixed budget isolates question quality from the stopping decision). A
    fact-select patient answers with the hidden facts that answer the question, or
    "cannot answer". After each turn: diagnose + judge.
``random``  (baseline 2 control, matched information)
    Reveal k hidden facts chosen at random (seeded per case, nested in k). Same k as
    ``asking``, so asking vs. random isolates the value of the questions themselves.
``bestk``   (baseline 4, ceiling)
    Greedy oracle: at each step reveal the hidden fact that most raises P(gold). Uses the
    gold label, so it is an upper bound on what any k-question asker could obtain.
``gapid``   (baseline 3, gap identification)
    Given a partial view, the LLM lists the missing information / follow-up questions it
    would ask. A judge marks which hidden facts those questions would uncover. Scored as
    hidden-fact recall, and as key-fact recall against the facts ``bestk`` found useful.

Results: ``runs/<run_id>/<baseline>/<case_id>.json`` (resumable) and ``summary.json``.

Run: ``uv run python -m ddx_genie.baselines --run-id baselines_dev --limit 5``
"""

from __future__ import annotations

import argparse
import json
import random
from collections import defaultdict
from dataclasses import asdict, dataclass
from typing import Any, Callable

from ddx_genie.diagnosis import _load_json, diagnose_open, format_facts, judge_differential
from ddx_genie.llm import RUNS_DIR, LLMClient
from ddx_genie.partial_eval import load_jsonl
from ddx_genie.reveal import SEED, SUBSET_PATH, VIEWS_PATH

K_ASK = 5       # question budget for asking / random
K_BEST = 3      # greedy depth for the best-k ceiling (cost grows ~ n_hidden * k)
MAX_UNCONFIRMED_CASES = 5
GAPID_VIEWS = ("prefix:0.0", "prefix:0.2", "prefix:0.4", "gaps:0.2", "gaps:0.4")
GAPID_N_QUESTIONS = 5
CANNOT_ANSWER = "The patient cannot answer this question."

ASK_SYSTEM = """You are a physician taking a history from a patient to reach a \
diagnosis. You see what is known so far and the questions already asked.

Ask the ONE question whose answer would most help you narrow down the diagnosis. You \
may ask about symptoms, history, medications, family or social history, examination \
findings or test results. Ask a single, specific question; do not repeat a question \
already asked. Reply with the question only."""

PATIENT_SYSTEM = """You answer a doctor's question using ONLY a numbered list of facts \
about a patient. Select the facts that directly answer the question (at most 3). Do not \
infer or add anything. If no fact answers it, select none.

Reply with JSON only: {"facts": [<fact numbers>]}"""

GAPID_SYSTEM = """You are a physician reviewing a partially documented case. Based on \
what is known, list the {n} most important pieces of missing information you would \
obtain next to reach the diagnosis, each phrased as a specific question to the patient \
or a specific exam or test. Most important first.

Reply with JSON only: {{"questions": ["...", "..."]}}"""

GAPID_JUDGE_SYSTEM = """You check which hidden facts about a patient a clinician's \
planned questions would uncover. A fact is COVERED if asking at least one of the \
questions, or performing the listed exam/test, would directly reveal that fact. Be \
strict: a question about a different topic does not cover a fact.

Reply with JSON only: {"covered": [<fact numbers>]}"""


# ------------------------------------------------------------------ shared scoring


@dataclass
class Scored:
    """One diagnosis of a fact set, judged against gold."""

    known: list[int]
    differential: list[str]
    match_rank: int | None
    p_gold: float

    @property
    def top1(self) -> bool:
        return self.match_rank == 1


def score_facts(case: dict[str, Any], known: list[int], client: LLMClient, tag: str) -> Scored:
    """Diagnose from the facts at ``known`` (source order) and judge against gold."""
    known = sorted(set(known))
    facts = [case["facts"][i] for i in known]
    diff = diagnose_open(facts, client=client, tag=f"{tag}:diagnose")
    names = [n for n, _ in diff.ranked]
    judgement = judge_differential(names, case["answer"], client=client, tag=f"{tag}:judge")
    rank = judgement.match_rank
    return Scored(
        known=known,
        differential=names,
        match_rank=rank,
        p_gold=diff.ranked[rank - 1][1] if rank is not None else 0.0,
    )


def anchor(case: dict[str, Any]) -> list[int]:
    return list(range(case["n_initial"]))


def hidden(case: dict[str, Any], known: list[int]) -> list[int]:
    seen = set(known)
    return [i for i in range(len(case["facts"])) if i not in seen]


def _numbered(facts: list[str], idx: list[int]) -> str:
    """Number facts 1..n for the prompt; caller maps back via ``idx``."""
    return "\n".join(f"{n}. {facts[i]}" for n, i in enumerate(idx, 1))


def _indices(text: str, key: str, idx: list[int]) -> list[int]:
    """Map a JSON list of 1-based numbers back to fact indices; junk is dropped."""
    parsed = _load_json(text)
    raw = parsed.get(key, []) if isinstance(parsed, dict) else []
    out = []
    for n in raw if isinstance(raw, list) else []:
        try:
            n = int(n)
        except (TypeError, ValueError):
            continue
        if 1 <= n <= len(idx) and idx[n - 1] not in out:
            out.append(idx[n - 1])
    return out


# ------------------------------------------------------- baseline 2: prompted asking


@dataclass
class AskStep:
    k: int
    question: str
    answered_with: list[int]
    wasted: bool  # unanswerable or nothing new
    scored: Scored


def ask_question(case: dict[str, Any], known: list[int], history: list[tuple[str, str]],
                 client: LLMClient) -> str:
    convo = "\n".join(f"Doctor: {q}\nPatient: {a}" for q, a in history) or "None yet."
    user = (f"Known so far:\n{format_facts([case['facts'][i] for i in sorted(known)])}\n\n"
            f"Questions asked so far:\n{convo}")
    completion = client.complete(
        [{"role": "system", "content": ASK_SYSTEM}, {"role": "user", "content": user}],
        tag="asking:question", max_tokens=100,
    )
    lines = [ln.strip() for ln in completion.text.strip().splitlines() if ln.strip()]
    return lines[-1] if lines else ""


def patient_answer(case: dict[str, Any], question: str, known: list[int],
                   client: LLMClient) -> list[int]:
    """Fact-select patient over the not-yet-known facts."""
    pool = hidden(case, known)
    if not pool or not question:
        return []
    user = f"Facts:\n{_numbered(case['facts'], pool)}\n\nDoctor's question: {question}"
    completion = client.complete(
        [{"role": "system", "content": PATIENT_SYSTEM}, {"role": "user", "content": user}],
        tag="asking:patient", max_tokens=60,
    )
    return _indices(completion.text, "facts", pool)


def run_asking(case: dict[str, Any], client: LLMClient) -> dict[str, Any]:
    known = anchor(case)
    history: list[tuple[str, str]] = []
    steps = []
    for k in range(1, K_ASK + 1):
        question = ask_question(case, known, history, client)
        got = patient_answer(case, question, known, client)
        answer = " ".join(case["facts"][i] for i in got) if got else CANNOT_ANSWER
        history.append((question, answer))
        known = known + got
        steps.append(AskStep(k, question, got, wasted=not got,
                             scored=score_facts(case, known, client, "asking")))
    return {"case_id": case["case_id"], "steps": [asdict(s) for s in steps]}


# ----------------------------------------------------- baseline 2 control: random k


def run_random(case: dict[str, Any], client: LLMClient) -> dict[str, Any]:
    order = hidden(case, anchor(case))
    random.Random(f"{SEED}:{case['case_id']}:randk").shuffle(order)
    steps = []
    for k in range(1, K_ASK + 1):
        known = anchor(case) + order[:k]
        steps.append({"k": k, "scored": asdict(score_facts(case, known, client, "random"))})
    return {"case_id": case["case_id"], "steps": steps}


# ------------------------------------------------------- baseline 4: best-k ceiling


def run_bestk(case: dict[str, Any], client: LLMClient) -> dict[str, Any]:
    """Greedy on P(gold); ties broken by source order. k=0 is the anchor alone."""
    known = anchor(case)
    base = score_facts(case, known, client, "bestk")
    steps = [{"k": 0, "added": None, "gain": 0.0, "scored": asdict(base)}]
    current = base
    for k in range(1, K_BEST + 1):
        trials = [(i, score_facts(case, known + [i], client, "bestk")) for i in hidden(case, known)]
        if not trials:
            break
        best_i, best = max(trials, key=lambda t: (t[1].p_gold, -t[0]))
        steps.append({"k": k, "added": best_i, "gain": best.p_gold - current.p_gold,
                      "scored": asdict(best)})
        known, current = known + [best_i], best
    # Facts that actually moved P(gold) up: the case's "key" missing facts.
    key = [s["added"] for s in steps[1:] if s["gain"] > 0]
    return {"case_id": case["case_id"], "steps": steps, "key_facts": key}


# --------------------------------------------------- baseline 3: gap identification


def run_gapid(case: dict[str, Any], views: list[dict[str, Any]], client: LLMClient) -> dict[str, Any]:
    out = []
    for view in views:
        known = view["revealed"]
        pool = view["hidden"]
        completion = client.complete(
            [{"role": "system", "content": GAPID_SYSTEM.format(n=GAPID_N_QUESTIONS)},
             {"role": "user", "content": f"Known so far:\n{format_facts(view['facts'])}"}],
            tag="gapid:list", max_tokens=400,
        )
        parsed = _load_json(completion.text)
        questions = parsed.get("questions", []) if isinstance(parsed, dict) else []
        questions = [str(q) for q in questions][:GAPID_N_QUESTIONS] if isinstance(questions, list) else []
        covered: list[int] = []
        if questions and pool:
            listing = "\n".join(f"{n}. {q}" for n, q in enumerate(questions, 1))
            judged = client.complete(
                [{"role": "system", "content": GAPID_JUDGE_SYSTEM},
                 {"role": "user", "content": f"Hidden facts:\n{_numbered(case['facts'], pool)}"
                                             f"\n\nPlanned questions:\n{listing}"}],
                tag="gapid:judge", max_tokens=200,
            )
            covered = _indices(judged.text, "covered", pool)
        out.append({"view": f"{view['mode']}:{view['fraction']:.1f}", "known": known,
                    "hidden": pool, "questions": questions, "covered": covered,
                    "parse_ok": bool(questions)})
    return {"case_id": case["case_id"], "views": out}


# ------------------------------------------------------------------- aggregation


def _mean(xs: list[float]) -> float | None:
    return sum(xs) / len(xs) if xs else None


def aggregate(results: dict[str, list[dict[str, Any]]], oneshot_p0: dict[str, dict[str, Any]],
              oracle: dict[str, dict[str, Any]]) -> dict[str, Any]:
    """Per-k accuracy/P(gold) for asking, random, bestk; recall for gapid; gap closed."""
    summary: dict[str, Any] = {}

    def by_k(arm: str, getter: Callable[[dict[str, Any]], dict[str, Any]]) -> dict[int, dict[str, float]]:
        cells: dict[int, list[dict[str, Any]]] = defaultdict(list)
        for res in results.get(arm, []):
            for step in res["steps"]:
                cells[step["k"]].append(getter(step))
        return {k: {"n": len(v),
                    "top1": _mean([float(s["match_rank"] == 1) for s in v]),
                    "top5": _mean([float(s["match_rank"] is not None) for s in v]),
                    "p_gold": _mean([s["p_gold"] for s in v])}
                for k, v in sorted(cells.items())}

    summary["asking"] = by_k("asking", lambda s: s["scored"])
    summary["random"] = by_k("random", lambda s: s["scored"])
    summary["bestk"] = by_k("bestk", lambda s: s["scored"])
    summary["oneshot_k0"] = {"top1": _mean([float(r["correct"]) for r in oneshot_p0.values()]),
                             "top5": _mean([float(r["match_rank"] is not None) for r in oneshot_p0.values()]),
                             "p_gold": _mean([r["p_gold"] for r in oneshot_p0.values()])}
    summary["oracle_full"] = {"top1": _mean([float(r["correct"]) for r in oracle.values()]),
                              "top5": _mean([float(r["match_rank"] is not None) for r in oracle.values()]),
                              "p_gold": _mean([r["p_gold"] for r in oracle.values()])}

    asks = [s for r in results.get("asking", []) for s in r["steps"]]
    summary["asking_behaviour"] = {
        "questions": len(asks),
        "wasted_share": _mean([float(s["wasted"]) for s in asks]),
        "facts_per_question": _mean([float(len(s["answered_with"])) for s in asks]),
    }

    key = {r["case_id"]: set(r["key_facts"]) for r in results.get("bestk", [])}
    gap: dict[str, dict[str, list[float]]] = defaultdict(lambda: defaultdict(list))
    for res in results.get("gapid", []):
        for v in res["views"]:
            if v["hidden"]:
                gap[v["view"]]["hidden_recall"].append(len(v["covered"]) / len(v["hidden"]))
            k = key.get(res["case_id"], set()) & set(v["hidden"])
            if k:
                gap[v["view"]]["key_recall"].append(len(k & set(v["covered"])) / len(k))
    summary["gapid"] = {view: {m: _mean(xs) for m, xs in ms.items()} | {"n": len(ms["hidden_recall"])}
                        for view, ms in sorted(gap.items())}
    return summary


# ------------------------------------------------------------------------- driver


BASELINES = ("bestk", "asking", "random", "gapid")


def run(client: LLMClient, run_id: str, limit: int, which: tuple[str, ...]) -> dict[str, list]:
    cases = load_jsonl(SUBSET_PATH)[:limit]
    views = load_jsonl(VIEWS_PATH)
    results: dict[str, list] = defaultdict(list)
    for case in cases:
        for name in which:
            path = RUNS_DIR / run_id / name / f"{case['case_id']}.json"
            if path.exists():
                results[name].append(json.loads(path.read_text()))
                continue
            client.budget.check()
            if name == "asking":
                res = run_asking(case, client)
            elif name == "random":
                res = run_random(case, client)
            elif name == "bestk":
                res = run_bestk(case, client)
            else:
                mine = [v for v in views if v["case_id"] == case["case_id"]
                        and f"{v['mode']}:{v['fraction']:.1f}" in GAPID_VIEWS]
                res = run_gapid(case, mine, client)
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(json.dumps(res, indent=1) + "\n")
            results[name].append(res)
        print(f"{case['case_id']}: done | {client.summary()}", flush=True)
    return results


def load_oneshot(run_id: str, case_ids: set[str], fraction: float) -> dict[str, dict[str, Any]]:
    """Baseline-1 results at one fraction (prefix mode holds the shared endpoints)."""
    out = {}
    for p in (RUNS_DIR / run_id).glob(f"*__prefix__{fraction:.1f}.json"):
        r = json.loads(p.read_text())
        if r["case_id"] in case_ids:
            out[r["case_id"]] = r
    return out


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--run-id", required=True)
    parser.add_argument("--oneshot-run-id", default="mediq_open_v1",
                        help="partial_eval run supplying the k=0 and full-information rows")
    parser.add_argument("--limit", type=int, default=MAX_UNCONFIRMED_CASES)
    parser.add_argument("--only", nargs="*", choices=BASELINES, default=list(BASELINES))
    parser.add_argument("--confirmed", action="store_true")
    args = parser.parse_args()
    if args.limit > MAX_UNCONFIRMED_CASES and not args.confirmed:
        parser.error(f"--limit {args.limit} > {MAX_UNCONFIRMED_CASES} needs --confirmed")

    client = LLMClient(args.run_id)
    results = run(client, args.run_id, args.limit, tuple(args.only))
    ids = {r["case_id"] for rs in results.values() for r in rs}
    summary = aggregate(results, load_oneshot(args.oneshot_run_id, ids, 0.0),
                        load_oneshot(args.oneshot_run_id, ids, 1.0))
    summary |= {"n_cases": len(ids), "usd": client.cost_log.total_usd}
    out = RUNS_DIR / args.run_id / "summary.json"
    out.write_text(json.dumps(summary, indent=2) + "\n")
    print(json.dumps(summary, indent=2))
    print(f"\n{client.summary()}\nwrote {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
