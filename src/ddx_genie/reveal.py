"""Partial views of a case: what a clinician knows part-way through a consultation.

The project's claim is that an agent which notices what is missing and asks for it
beats an LLM that one-shots whatever it was handed. Testing that needs cases with
information withheld. Every view has the same shape:

    anchor (always shown) + a fraction ``p`` of the remaining facts

The anchor is the case's initial information (for MediQ, demographics plus presenting
complaint). ``p = 0`` is MediQ's own "initial information only" setting; ``p = 1`` is
the full case, i.e. the oracle input.

Two modes decide *which* remaining facts are shown:

``prefix``
    The first ``k`` in source order. MediQ facts run history -> exam -> labs, so this
    looks like a consultation interrupted part-way.
``gaps``
    ``k`` facts chosen at random (order preserved), so holes fall anywhere, including
    early history. Same ``k`` as ``prefix`` at the same ``p``, so the two modes are
    matched on amount of information and differ only in which facts are missing.

Both modes are *nested*: a fact shown at ``p`` is also shown at every larger ``p``.
That makes accuracy-vs-``p`` curves monotone in information, not noisy resamples.
Randomness is per case, seeded from ``SEED`` and the case id, so adding or removing a
case never changes another case's views.

Run: ``uv run python -m ddx_genie.reveal``
"""

from __future__ import annotations

import json
import random
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Literal, Sequence

REPO_ROOT = Path(__file__).resolve().parents[2]
SUBSET_PATH = REPO_ROOT / "data" / "processed" / "mediq" / "subset.jsonl"
VIEWS_PATH = REPO_ROOT / "data" / "processed" / "mediq" / "views.jsonl"

SEED = 0
FRACTIONS: tuple[float, ...] = (0.0, 0.2, 0.4, 0.6, 0.8, 1.0)
MODES: tuple[str, ...] = ("prefix", "gaps")

Mode = Literal["prefix", "gaps"]


@dataclass(frozen=True)
class View:
    case_id: str
    mode: str
    fraction: float
    #: Indices into the case's full ``facts`` list, ascending.
    revealed: list[int]
    hidden: list[int]
    facts: list[str]

    @property
    def view_id(self) -> str:
        return f"{self.case_id}:{self.mode}:{self.fraction:.1f}"


def n_revealed_rest(n_rest: int, fraction: float) -> int:
    """How many non-anchor facts a view at ``fraction`` shows."""
    if not 0.0 <= fraction <= 1.0:
        raise ValueError(f"fraction must be in [0, 1], got {fraction}")
    return round(fraction * n_rest)


def rest_order(case_id: str, n_facts: int, n_anchor: int, mode: Mode, seed: int = SEED) -> list[int]:
    """The order in which non-anchor facts get revealed as ``fraction`` grows."""
    rest = list(range(n_anchor, n_facts))
    if mode == "prefix":
        return rest
    if mode == "gaps":
        # str seeds are hashed deterministically (independent of PYTHONHASHSEED).
        random.Random(f"{seed}:{case_id}").shuffle(rest)
        return rest
    raise ValueError(f"unknown mode {mode!r}")


def make_view(
    case_id: str,
    facts: Sequence[str],
    n_anchor: int,
    mode: Mode,
    fraction: float,
    seed: int = SEED,
) -> View:
    if not 1 <= n_anchor <= len(facts):
        raise ValueError(f"{case_id}: anchor {n_anchor} out of range for {len(facts)} facts")
    order = rest_order(case_id, len(facts), n_anchor, mode, seed)
    k = n_revealed_rest(len(order), fraction)
    revealed = sorted(list(range(n_anchor)) + order[:k])
    shown = set(revealed)
    return View(
        case_id=case_id,
        mode=mode,
        fraction=fraction,
        revealed=revealed,
        hidden=[i for i in range(len(facts)) if i not in shown],
        facts=[facts[i] for i in revealed],
    )


def views_for_case(
    case_id: str,
    facts: Sequence[str],
    n_anchor: int,
    *,
    modes: Sequence[str] = MODES,
    fractions: Sequence[float] = FRACTIONS,
    seed: int = SEED,
) -> list[View]:
    views = []
    for mode in modes:
        for fraction in fractions:
            # At p=0 and p=1 both modes coincide; keep one copy, under "prefix".
            if mode != "prefix" and fraction in (0.0, 1.0):
                continue
            views.append(make_view(case_id, facts, n_anchor, mode, fraction, seed))  # type: ignore[arg-type]
    return views


def build_mediq_views(subset_path: Path = SUBSET_PATH) -> list[View]:
    views: list[View] = []
    for line in subset_path.read_text().splitlines():
        if line.strip():
            case = json.loads(line)
            views.extend(views_for_case(case["case_id"], case["facts"], case["n_initial"]))
    return views


def write_views(views: list[View], path: Path = VIEWS_PATH) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    rows = [{"view_id": v.view_id} | asdict(v) for v in views]
    path.write_text("".join(json.dumps(r) + "\n" for r in rows))


def main() -> int:
    views = build_mediq_views()
    write_views(views)
    n_cases = len({v.case_id for v in views})
    print(f"{len(views)} views over {n_cases} cases "
          f"(modes {MODES}, fractions {FRACTIONS}; p=0 and p=1 stored once)")
    for mode in MODES:
        for fraction in FRACTIONS:
            sel = [v for v in views if v.mode == mode and v.fraction == fraction]
            if sel:
                share = sum(len(v.revealed) / (len(v.revealed) + len(v.hidden)) for v in sel) / len(sel)
                print(f"  {mode:6s} p={fraction:.1f}: mean share of all facts shown {share:.2f}")
    print(f"wrote {VIEWS_PATH.relative_to(REPO_ROOT)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
