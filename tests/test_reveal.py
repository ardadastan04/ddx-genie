"""Tests for partial-view construction. No data files needed."""

from __future__ import annotations

import pytest

from ddx_genie.mediq import initial_fact_count
from ddx_genie.reveal import FRACTIONS, make_view, n_revealed_rest, views_for_case

FACTS = [f"fact {i}" for i in range(12)]
ANCHOR = 2


@pytest.mark.parametrize("mode", ["prefix", "gaps"])
def test_anchor_always_shown_and_partition_complete(mode: str) -> None:
    for p in FRACTIONS:
        v = make_view("c1", FACTS, ANCHOR, mode, p)  # type: ignore[arg-type]
        assert v.revealed[:ANCHOR] == [0, 1]
        assert sorted(v.revealed + v.hidden) == list(range(len(FACTS)))
        assert v.facts == [FACTS[i] for i in v.revealed]


def test_endpoints() -> None:
    assert make_view("c1", FACTS, ANCHOR, "gaps", 0.0).revealed == [0, 1]
    assert make_view("c1", FACTS, ANCHOR, "gaps", 1.0).hidden == []


def test_prefix_is_a_prefix() -> None:
    v = make_view("c1", FACTS, ANCHOR, "prefix", 0.4)
    assert v.revealed == list(range(ANCHOR + n_revealed_rest(10, 0.4)))


@pytest.mark.parametrize("mode", ["prefix", "gaps"])
def test_nested_across_fractions(mode: str) -> None:
    shown = [set(make_view("c1", FACTS, ANCHOR, mode, p).revealed) for p in FRACTIONS]  # type: ignore[arg-type]
    assert all(a <= b for a, b in zip(shown, shown[1:]))


def test_modes_matched_on_amount() -> None:
    for p in FRACTIONS:
        a = make_view("c1", FACTS, ANCHOR, "prefix", p)
        b = make_view("c1", FACTS, ANCHOR, "gaps", p)
        assert len(a.revealed) == len(b.revealed)


def test_gaps_deterministic_and_per_case() -> None:
    a = make_view("c1", FACTS, ANCHOR, "gaps", 0.4)
    assert a == make_view("c1", FACTS, ANCHOR, "gaps", 0.4)
    others = {tuple(make_view(f"c{i}", FACTS, ANCHOR, "gaps", 0.4).revealed) for i in range(10)}
    assert len(others) > 1  # different cases get different holes


def test_views_for_case_dedupes_endpoints() -> None:
    views = views_for_case("c1", FACTS, ANCHOR)
    assert len(views) == len(FRACTIONS) + (len(FRACTIONS) - 2)
    assert len({v.view_id for v in views}) == len(views)


def test_bad_inputs() -> None:
    with pytest.raises(ValueError):
        make_view("c1", FACTS, 0, "prefix", 0.2)
    with pytest.raises(ValueError):
        make_view("c1", FACTS, ANCHOR, "prefix", 1.5)
    with pytest.raises(ValueError):
        make_view("c1", FACTS, ANCHOR, "shuffle", 0.2)  # type: ignore[arg-type]


def test_initial_fact_count() -> None:
    ctx0 = "A 38-year-old woman comes to the emergency department because of headache for 1 day."
    facts = ["A 38-year-old woman comes to the emergency department.",
             "She has headache for 1 day.",
             "Four days ago, she was diagnosed with an ear infection."]
    assert initial_fact_count(facts, ctx0) == 2
    assert initial_fact_count(["Unrelated thing entirely."], ctx0) == 1  # floor of 1
