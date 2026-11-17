"""Tests for the experiment harness (no network, no LLM calls)."""

from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path

import pytest

from smt_trial_matching import metrics as M
from smt_trial_matching.experiment import parse_args
from smt_trial_matching.policy_loading import ROOT, load_policy, policy_label

# ------------------------------------------------------------------ policy loading


def test_load_ca_policy_by_name() -> None:
    from baselines.policies import POLICIES

    for name in ("no_questions", "random_stop", "greedy_smt", "ask_all"):
        assert load_policy(name) is POLICIES[name]
    with pytest.raises(ValueError, match="unknown policy"):
        load_policy("nope")


def test_load_policy_from_module_and_file(tmp_path: Path) -> None:
    from baselines.policies import greedy_smt

    assert load_policy("baselines.policies:greedy_smt") is greedy_smt
    f = tmp_path / "my_policies.py"
    f.write_text("def first_var(states, asked, rng):\n    return None\n")
    fn = load_policy(f"{f}:first_var")
    assert fn.__name__ == "first_var" and fn({}, set(), None) is None
    assert policy_label(f"{f}:first_var") == "first_var"
    with pytest.raises(TypeError, match="no callable"):
        load_policy(f"{f}:missing")
    with pytest.raises(ValueError, match="not found"):
        load_policy("src/nowhere.py:x")


# ------------------------------------------------------------------ metrics on a hand-made log

GOLD = {("p1", "A"): True, ("p1", "B"): False, ("p2", "C"): False}


def _turn(verdicts: dict[str, str], answer=None, informative=True) -> dict:
    return {"nct": "A", "var": "v", "answer": answer, "informative": informative, "verdicts": verdicts}


EPS = [
    # p1: B becomes ineligible after question 2; stops after 3 questions.
    {"qid": "p1", "trials": ["A", "B"], "initial_verdicts": {"A": "eligible", "B": "eligible"},
     "turns": [_turn({"A": "eligible", "B": "eligible"}),
               _turn({"A": "eligible", "B": "ineligible"}, answer=True),
               _turn({"A": "eligible", "B": "ineligible"}, answer=False, informative=False)],
     "final_verdicts": {"A": "eligible", "B": "ineligible"}},
    # p2: never asks anything.
    {"qid": "p2", "trials": ["C"], "initial_verdicts": {"C": "eligible"}, "turns": [],
     "final_verdicts": {"C": "eligible"}},
]


def test_metrics_at_budget_on_hand_made_log() -> None:
    t = M.build_table(EPS, GOLD, budget=5)
    acc = M.point(t)["accuracy"]
    assert acc[0] == pytest.approx(1 / 3)  # only A correct
    assert acc[1] == pytest.approx(1 / 3)
    assert acc[2] == pytest.approx(2 / 3)  # B now correct
    assert acc[5] == pytest.approx(2 / 3)  # stopped early: keeps final verdicts
    assert acc[-1] == pytest.approx(2 / 3)  # final
    pt = M.point(t)
    assert pt["answered_rate"][3] == pytest.approx(2 / 3)
    assert pt["informative_rate"][3] == pytest.approx(2 / 3)
    assert pt["questions_per_patient"][5] == pytest.approx(1.5)
    # set F1 at k=5: p1 pred {A} gold {A} -> 1; p2 pred {C}, gold {} -> P=0, R=1 -> 0.
    assert pt["set_f1"][5] == pytest.approx(0.5)


def test_bootstrap_resamples_patients_reproducibly() -> None:
    t = M.build_table(EPS, GOLD, budget=5)
    a = M.curves(t, M.boot_indices(2))["accuracy"]
    b = M.curves(t, M.boot_indices(2))["accuracy"]
    assert a == b
    assert all(lo <= v <= hi for v, lo, hi in a)


def test_mcnemar_exact_known_example() -> None:
    # 6 discordant pairs all for a: p = 2 * 0.5**6
    a = [True] * 6 + [True, False] * 2
    b = [False] * 6 + [True, False] * 2
    r = M.mcnemar_exact(a, b)
    assert (r["only_a"], r["only_b"]) == (6, 0)
    assert r["p"] == pytest.approx(2 / 64)
    # 7 vs 2: two-sided p = 2 * P(X <= 2 | n=9) = 2 * 46/512
    r = M.mcnemar_exact([True] * 7 + [False] * 2, [False] * 7 + [True] * 2)
    assert r["p"] == pytest.approx(92 / 512)
    assert M.mcnemar_exact([True], [True])["p"] == 1.0


# ------------------------------------------------------------------ agreement with eval/evaluate.py


def _evaluate(log: Path, split: str) -> dict:
    out = subprocess.run([sys.executable, str(ROOT / "eval" / "evaluate.py"), str(log),
                          "--split", split], capture_output=True, text=True, check=True).stdout
    return json.loads(out)


@pytest.mark.parametrize("policy", ["no_questions", "random_stop", "greedy_smt", "ask_all"])
def test_accuracy_at_budget_matches_evaluate_py(policy: str) -> None:
    log = ROOT / "logs" / "reference" / f"{policy}_gpt5_oracle.jsonl"
    ref = _evaluate(log, "dev")
    dev = set(M.load_split("dev"))
    eps = [e for e in M.load_log(log) if e["qid"] in dev]
    pt = M.point(M.build_table(eps, M.load_gold(), budget=30))
    for k in (0, 5, 10, 20, 30):
        assert round(float(pt["accuracy"][k]), 3) == ref["accuracy_at_budget"][str(k)]
    assert round(float(pt["accuracy"][-1]), 3) == ref["pairs"]["acc"]
    assert round(float(pt["f1"][-1]), 3) == ref["pairs"]["F1"]
    assert round(float(pt["set_f1"][-1]), 3) == ref["patient_sets"]["F1"]


# ------------------------------------------------------------------ CLI guard


def test_test_split_refused_without_confirmed(capsys) -> None:
    with pytest.raises(SystemExit):
        parse_args(["--policies", "greedy_smt", "--split", "test", "--run-id", "x"])
    assert "--confirmed" in capsys.readouterr().err
    assert parse_args(["--policies", "greedy_smt", "--split", "test", "--run-id", "x",
                       "--confirmed"]).split == "test"
