"""Tests for baseline parsing and aggregation. No LLM calls."""

from __future__ import annotations

from ddx_genie.baselines import _indices, _numbered, aggregate, anchor, hidden

CASE = {"case_id": "c1", "facts": ["f0", "f1", "f2", "f3", "f4"], "n_initial": 2, "answer": "X"}


def test_anchor_and_hidden() -> None:
    assert anchor(CASE) == [0, 1]
    assert hidden(CASE, [0, 1, 3]) == [2, 4]


def test_numbered_and_indices_map_back() -> None:
    pool = [2, 4]
    assert _numbered(CASE["facts"], pool) == "1. f2\n2. f4"
    assert _indices('{"facts": [2, 1, 2, 9, "x"]}', "facts", pool) == [4, 2]
    assert _indices("not json", "facts", pool) == []
    assert _indices('{"facts": []}', "facts", pool) == []


def _scored(rank, p):
    return {"known": [], "differential": [], "match_rank": rank, "p_gold": p}


def test_aggregate() -> None:
    results = {
        "asking": [{"case_id": "c1", "steps": [
            {"k": 1, "question": "q", "answered_with": [2], "wasted": False, "scored": _scored(1, 0.6)},
            {"k": 2, "question": "q", "answered_with": [], "wasted": True, "scored": _scored(None, 0.0)}]}],
        "bestk": [{"case_id": "c1", "key_facts": [2], "steps": [
            {"k": 0, "added": None, "gain": 0.0, "scored": _scored(None, 0.0)},
            {"k": 1, "added": 2, "gain": 0.6, "scored": _scored(1, 0.6)}]}],
        "gapid": [{"case_id": "c1", "views": [
            {"view": "prefix:0.0", "known": [0, 1], "hidden": [2, 3, 4], "questions": ["a"],
             "covered": [2], "parse_ok": True}]}],
    }
    one = {"c1": {"correct": False, "match_rank": None, "p_gold": 0.0}}
    full = {"c1": {"correct": True, "match_rank": 1, "p_gold": 0.9}}
    s = aggregate(results, one, full)
    assert s["asking"][1]["top1"] == 1.0 and s["asking"][2]["top5"] == 0.0
    assert s["asking_behaviour"]["wasted_share"] == 0.5
    assert s["bestk"][1]["p_gold"] == 0.6
    assert s["gapid"]["prefix:0.0"]["hidden_recall"] == 1 / 3
    assert s["gapid"]["prefix:0.0"]["key_recall"] == 1.0
    assert s["oracle_full"]["top1"] == 1.0 and s["oneshot_k0"]["top1"] == 0.0
