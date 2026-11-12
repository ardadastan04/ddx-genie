"""Tests for MCQ diagnosis parsing and partial-eval scoring. No LLM calls."""

from __future__ import annotations

from ddx_genie.diagnosis import Differential, _parse_differential, format_facts
from ddx_genie.partial_eval import aggregate, option_texts, score_view

OPTS = ("Giardiasis", "Irritable bowel syndrome (IBS)",
        "Traveler’s diarrhea due to Norovirus", "Traveler’s diarrhea due to ETEC")
CASE = {"case_id": "c1", "options": {"B": OPTS[1], "A": OPTS[0], "D": OPTS[3], "C": OPTS[2]},
        "answer": OPTS[3], "answer_idx": "D"}


def _view(mode: str, p: float) -> dict:
    return {"view_id": f"c1:{mode}:{p}", "mode": mode, "fraction": p,
            "revealed": [0, 1], "hidden": [2], "facts": ["a", "b"]}


def test_option_texts_in_letter_order() -> None:
    assert option_texts(CASE) == OPTS


def test_parser_curly_vs_straight_quotes() -> None:
    text = '{"differential": [{"condition": "Traveler\'s diarrhea due to ETEC", "probability": 0.7},' \
           ' {"condition": "giardiasis", "probability": 0.3}]}'
    assert _parse_differential(text, OPTS) == [(OPTS[3], 0.7), (OPTS[0], 0.3)]


def test_parser_refuses_ambiguous_prefix() -> None:
    # Truncated name shared by two options must not silently map to the first one.
    text = '[{"condition": "Traveler\'s diarrhea", "probability": 1.0}]'
    assert _parse_differential(text, OPTS) == []


def test_parser_unique_prefix_still_works() -> None:
    text = '[{"condition": "Irritable bowel syndrome", "probability": 1.0}]'
    assert _parse_differential(text, OPTS) == [(OPTS[1], 1.0)]


def test_format_facts() -> None:
    assert format_facts(["x", " ", "y"]) == "- x\n- y"
    assert format_facts([]) == "No findings were collected."


def test_score_view() -> None:
    diff = Differential(ranked=[(OPTS[3], 0.6), (OPTS[2], 0.4)], raw="")
    r = score_view(_view("prefix", 0.4), CASE, diff, "oneshot", 0.001)
    assert r.correct and r.p_gold == 0.6 and r.n_facts == 3 and r.parse_ok
    bad = score_view(_view("gaps", 0.4), CASE, Differential(ranked=[], raw="?"), "oneshot", 0)
    assert not bad.correct and bad.p_gold == 0.0 and not bad.parse_ok


def test_aggregate_shares_endpoints_across_modes() -> None:
    right = Differential(ranked=[(OPTS[3], 1.0)], raw="")
    wrong = Differential(ranked=[(OPTS[0], 1.0)], raw="")
    results = [
        score_view(_view("prefix", 0.0), CASE, wrong, "oneshot", 0),
        score_view(_view("prefix", 0.4), CASE, right, "oneshot", 0),
        score_view(_view("gaps", 0.4), CASE, wrong, "oneshot", 0),
        score_view(_view("prefix", 1.0), CASE, right, "oneshot", 0),
    ]
    cells = {(c["mode"], c["fraction"]): c for c in aggregate(results)["cells"]}
    assert cells[("prefix", 0.4)]["accuracy"] == 1.0
    assert cells[("gaps", 0.4)]["accuracy"] == 0.0
    assert cells[("gaps", 1.0)]["accuracy"] == 1.0  # oracle endpoint shared
    assert cells[("gaps", 0.0)]["n"] == 1


# ------------------------------------------------------------ open-ended answer space

from ddx_genie.diagnosis import Judgement, _parse_judgement, _parse_open_differential


def test_open_parser_free_names_dedup_and_normalise() -> None:
    text = ('```json\n{"differential": [{"diagnosis": "Cerebral venous sinus thrombosis", '
            '"probability": 2}, {"diagnosis": "cerebral venous sinus thrombosis", '
            '"probability": 1}, {"diagnosis": "Bacterial meningitis", "probability": 2}]}\n```')
    assert _parse_open_differential(text) == [
        ("Cerebral venous sinus thrombosis", 0.5), ("Bacterial meningitis", 0.5)]
    assert _parse_open_differential("no json here") == []


def test_judge_parser_per_candidate() -> None:
    j = _parse_judgement('{"verdicts": [{"candidate": 1, "relation": "broader"}, '
                         '{"candidate": 2, "relation": "more-specific"}, '
                         '{"candidate": 3, "relation": "different"}], "reason": "x"}', 3)
    assert j.relations == ["broader", "more_specific", "different"] and j.parse_ok
    assert j.match_rank == 2 and j.lenient_rank == 1


def test_judge_parser_failures() -> None:
    bad = _parse_judgement("garbage", 3)
    assert not bad.parse_ok and bad.match_rank is None
    partial = _parse_judgement('{"verdicts": [{"candidate": 1, "relation": "same"}]}', 3)
    assert partial.match_rank == 1 and not partial.parse_ok  # 2 verdicts missing
    junk = _parse_judgement('{"verdicts": [{"candidate": 7, "relation": "same"}]}', 3)
    assert junk.match_rank is None


def test_score_view_open_uses_judge_rank() -> None:
    diff = Differential(ranked=[("Norovirus gastroenteritis", 0.5),
                                ("Enterotoxigenic E. coli infection", 0.3),
                                ("Giardiasis", 0.2)], raw="")
    j = Judgement(relations=["different", "same", "different"], reason="ETEC", raw="{}")
    r = score_view(_view("gaps", 0.4), CASE, diff, "oneshot", 0, answer_space="open", judgement=j)
    assert not r.correct and r.hit_at(3) and r.p_gold == 0.3 and r.match_rank == 2


def test_legacy_mcq_result_hit_at() -> None:
    diff = Differential(ranked=[(OPTS[0], 0.6), (OPTS[3], 0.4)], raw="")
    r = score_view(_view("prefix", 0.4), CASE, diff, "oneshot", 0)
    assert r.match_rank == 2 and r.hit_at(3) and not r.hit_at(1)
