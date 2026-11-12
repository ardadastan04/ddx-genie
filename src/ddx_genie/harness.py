"""Batch driver: run a system against N simulated patients and record everything.

    uv run python -m ddx_genie.harness --system genie --n 5 --run-id dev1

Per CLAUDE.md the run is resumable (a patient whose result file exists is skipped),
cached (through ``llm.py`` and Genie's own Redis cache), and budget-guarded (aborts
rather than crossing ``MAX_RUN_USD``). The running total prints after every patient.

Both systems implement :class:`System`, so the only difference between the Genie and
baseline arms is how evidence gets elicited: same patients, same simulator, same turn
cap, same diagnosis prompt.
"""

from __future__ import annotations

import argparse
import asyncio
import json
import os
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Protocol

from ddx_genie.cards import CARDS_DIR, Finding, PatientCard
from ddx_genie.diagnosis import Differential, diagnose_findings
from ddx_genie.llm import RUNS_DIR, BudgetExceeded, LLMClient, load_env
from ddx_genie.simulator import SimulatedPatient
from ddx_genie.subset import PROCESSED_DIR, REPO_ROOT

#: A compromise: 10 turns left Genie no headroom at all (it hit the cap on every
#: patient), while pneumonia cases carry ~32 findings and stay budget-limited rather
#: than skill-limited until ~35. Raise it for the final paper run.
DEFAULT_MAX_TURNS = 20


class System(Protocol):
    """One agent architecture under comparison."""

    name: str

    def start(self) -> str:
        """The agent's opening utterance."""

    async def respond(self, patient_utterance: str) -> str:
        """Take the patient's reply, return the next agent utterance."""

    def findings(self) -> dict[str, Any]:
        """Everything recorded so far, as field name -> value."""

    def differential(self) -> Differential | None:
        """The differential if the system produced one unprompted, else None."""


# ------------------------------------------------------------------------ the Genie arm


class GenieSystem:
    """Genie Worksheets agent, driven one turn at a time."""

    name = "genie"

    def __init__(self, run_id: str, client: LLMClient) -> None:
        sys.path.insert(0, str(REPO_ROOT / "genie"))
        from agent import build_agent  # noqa: PLC0415  (needs the path tweak above)

        # Share the harness's client so Genie's calls land in the same ledger.
        self.agent, _ = build_agent(run_id, client=client)
        self._client = client

    def start(self) -> str:
        return self.agent.starting_prompt

    async def respond(self, patient_utterance: str) -> str:
        await self.agent.generate_next_turn(patient_utterance)
        return self.agent.dlg_history[-1].system_response

    def findings(self) -> dict[str, Any]:
        from worksheets.utils.field import get_genie_fields_from_ws

        out: dict[str, Any] = {}
        for obj in self.agent.runtime.context.context.values():
            if not hasattr(obj, "_ordered_attributes"):
                continue
            for field in get_genie_fields_from_ws(obj):
                if field.name == "differential":
                    continue
                value = getattr(field, "value", None)
                if value is not None:
                    out[field.name] = getattr(value, "name", value)
        return out

    def differential(self) -> Differential | None:
        # The worksheet rarely completes inside the cap, so the Form Action that calls
        # diagnose usually has not fired. The harness asks for the diagnosis instead.
        return None


# --------------------------------------------------------------------------- one patient


@dataclass
class PatientResult:
    row_index: int
    pathology: str
    system: str
    turns: int
    transcript: list[dict[str, str]]
    findings: dict[str, Any]
    differential: list[dict[str, Any]]
    differential_raw: str
    true_evidences: list[dict[str, Any]]
    true_differential: list[dict[str, Any]]
    fills_per_turn: list[int]
    usd: float
    prompt_tokens: int
    completion_tokens: int
    wall_s: float
    max_turns: int
    error: str | None = None

    def as_json(self) -> dict[str, Any]:
        return self.__dict__.copy()


def load_card(path: Path) -> PatientCard:
    raw = json.loads(path.read_text())
    return PatientCard(
        row_index=raw["row_index"],
        age=raw["age"],
        sex=raw["sex"],
        chief_complaint=raw["chief_complaint"],
        findings=[Finding(**f) for f in raw["findings"]],
        pathology=raw["pathology"],
        differential=raw["differential"],
    )


def load_subset() -> dict[int, dict[str, Any]]:
    path = PROCESSED_DIR / "subset.jsonl"
    records = [json.loads(line) for line in path.read_text().splitlines() if line]
    return {record["row_index"]: record for record in records}


async def run_patient(
    card: PatientCard,
    record: dict[str, Any],
    *,
    system: System,
    client: LLMClient,
    max_turns: int,
) -> PatientResult:
    """Interview one patient to completion or the turn cap, then diagnose."""
    patient = SimulatedPatient(card=card, client=client)
    transcript: list[dict[str, str]] = []
    fills_per_turn: list[int] = []
    started = time.monotonic()
    before = (client.cost_log.total_usd, client.cost_log.calls)
    tokens = [0, 0]
    error: str | None = None

    agent_utterance = system.start()
    turns = 0
    try:
        for _ in range(max_turns):
            turns += 1
            patient_utterance = patient.reply(agent_utterance)
            previous = set(system.findings())
            agent_utterance = await system.respond(patient_utterance)
            transcript.append(
                {
                    "agent": transcript[-1]["next_agent"] if transcript else system.start(),
                    "patient": patient_utterance,
                    "next_agent": agent_utterance,
                }
            )
            # More than one new field in a turn means the patient volunteered
            # something unasked. Recorded so leakage is measurable, not guessed at.
            fills_per_turn.append(len(set(system.findings()) - previous))
            if system.differential() is not None:
                break
    except BudgetExceeded:
        raise
    except Exception as exc:  # a single patient must not kill the batch
        error = f"{type(exc).__name__}: {exc}"

    findings = system.findings()
    differential = system.differential()
    if differential is None:
        # Inside the error handling: a failed diagnosis must still yield a result
        # file, or a transient network blip discards a completed interview.
        try:
            differential = diagnose_findings(findings, client=client)
        except BudgetExceeded:
            raise
        except Exception as exc:
            error = "; ".join(filter(None, [error, f"diagnose failed: {exc}"]))
            differential = Differential(ranked=[], raw="")

    # Attribute every call made during this patient to this patient.
    rows = [
        json.loads(line)
        for line in client.cost_log.path.read_text().splitlines()[before[1] :]
        if line.strip()
    ]
    tokens = [
        sum(r["prompt_tokens"] for r in rows),
        sum(r["completion_tokens"] for r in rows),
    ]

    return PatientResult(
        row_index=card.row_index,
        pathology=card.pathology,
        system=system.name,
        turns=turns,
        transcript=transcript,
        findings=findings,
        differential=differential.as_json(),
        differential_raw=differential.raw,
        true_evidences=record["evidences"],
        true_differential=record["differential"],
        fills_per_turn=fills_per_turn,
        usd=client.cost_log.total_usd - before[0],
        prompt_tokens=tokens[0],
        completion_tokens=tokens[1],
        wall_s=round(time.monotonic() - started, 1),
        max_turns=max_turns,
        error=error,
    )


# ------------------------------------------------------------------------------ the batch


def select_cards(limit: int, subset: dict[int, dict[str, Any]]) -> list[Path]:
    """Choose which patients to run, stratified by condition for partial runs.

    Cards are named by row_index, so taking the first N alphabetically gave five
    patients spanning only two of the six conditions -- a dev run that cannot show a
    per-condition effect and whose averages are weighted by whichever conditions
    happen to sort first. Round-robin across conditions instead, in the deterministic
    order CONDITIONS declares.
    """
    from ddx_genie.subset import CONDITIONS

    all_cards = sorted(CARDS_DIR.glob("patient_*.json"))
    if limit >= len(all_cards):
        return all_cards

    by_condition: dict[str, list[Path]] = {c: [] for c in CONDITIONS}
    for path in all_cards:
        row = int(path.stem.split("_")[1])
        pathology = subset.get(row, {}).get("pathology")
        if pathology in by_condition:
            by_condition[pathology].append(path)

    chosen: list[Path] = []
    index = 0
    while len(chosen) < limit:
        added = False
        for condition in CONDITIONS:
            group = by_condition[condition]
            if index < len(group) and len(chosen) < limit:
                chosen.append(group[index])
                added = True
        if not added:
            break
        index += 1
    return chosen


def make_system(name: str, run_id: str, client: LLMClient) -> System:
    if name == "genie":
        return GenieSystem(run_id, client)
    if name == "baseline":
        from ddx_genie.baseline import BaselineSystem

        return BaselineSystem(client)
    raise ValueError(f"unknown system {name!r}; expected 'genie' or 'baseline'")


async def run_batch(
    system_name: str,
    *,
    run_id: str,
    limit: int,
    max_turns: int,
    max_run_usd: float | None = None,
) -> list[Path]:
    load_env()
    os.environ.setdefault("DDX_RUN_ID", run_id)
    out_dir = RUNS_DIR / run_id
    out_dir.mkdir(parents=True, exist_ok=True)

    subset = load_subset()
    cards = select_cards(limit, subset)
    if not cards:
        raise FileNotFoundError(
            f"no cards in {CARDS_DIR}; run `python -m ddx_genie.cards` first"
        )

    client = LLMClient(run_id, max_run_usd=max_run_usd)
    print(f"system={system_name} run_id={run_id} patients={len(cards)} "
          f"max_turns={max_turns} cap=${client.budget.max_run_usd:.2f}")
    print(f"starting spend: ${client.cost_log.total_usd:.4f}\n")

    written: list[Path] = []
    for index, card_path in enumerate(cards, 1):
        card = load_card(card_path)
        out_path = out_dir / f"{system_name}_{card.row_index:06d}.json"
        if out_path.exists():  # resumable
            print(f"[{index}/{len(cards)}] row {card.row_index} skipped (exists)")
            written.append(out_path)
            continue
        try:
            result = await run_patient(
                card,
                subset[card.row_index],
                system=make_system(system_name, run_id, client),
                client=client,
                max_turns=max_turns,
            )
        except BudgetExceeded as exc:
            print(f"\nABORTED: {exc}")
            break
        except Exception as exc:
            # One patient's failure must not discard the rest of the batch. No result
            # file is written, so a rerun retries exactly this patient.
            print(f"[{index}/{len(cards)}] row {card.row_index} FAILED "
                  f"{type(exc).__name__}: {exc}")
            continue

        out_path.write_text(json.dumps(result.as_json(), indent=2, ensure_ascii=False) + "\n")
        written.append(out_path)

        volunteered = sum(max(0, n - 1) for n in result.fills_per_turn)
        flag = f"  ERROR {result.error}" if result.error else ""
        print(
            f"[{index}/{len(cards)}] row {result.row_index} {result.pathology[:22]:<22} "
            f"turns={result.turns:<3} fields={len(result.findings):<3} "
            f"volunteered={volunteered:<3} top1={(result.differential or [{}])[0].get('condition','-')[:18]:<18} "
            f"${result.usd:.4f}  total=${client.cost_log.total_usd:.4f}{flag}"
        )

        # Project the full run from what we have, per CLAUDE.md's pre-batch estimate.
        if index == 3 and len(cards) > 3:
            mean = client.cost_log.total_usd / index
            print(f"    projected for {len(cards)} patients: "
                  f"${mean * len(cards):.2f} (mean ${mean:.4f}/patient)")

    print(f"\n{client.summary()}")
    return written


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--system", default="genie", choices=["genie", "baseline"])
    parser.add_argument("--n", type=int, default=5, help="patients to run")
    parser.add_argument("--run-id", default="dev1")
    parser.add_argument(
        "--max-turns",
        type=int,
        default=int(os.getenv("MAX_TURNS", DEFAULT_MAX_TURNS)),
        help=f"turn cap per conversation (default {DEFAULT_MAX_TURNS})",
    )
    parser.add_argument("--max-run-usd", type=float, default=None)
    args = parser.parse_args()

    if args.n > 5:
        # CLAUDE.md: never launch a run over 5 patients without confirmation.
        reply = input(f"Run {args.n} patients (over the 5-patient dev limit)? [y/N] ")
        if reply.strip().lower() not in {"y", "yes"}:
            print("aborted")
            return 1

    asyncio.run(
        run_batch(
            args.system,
            run_id=args.run_id,
            limit=args.n,
            max_turns=args.max_turns,
            max_run_usd=args.max_run_usd,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
