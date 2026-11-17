"""Harness plots: accuracy vs budget, cumulative answered questions vs budget, waste breakdown."""

from __future__ import annotations

import math
from pathlib import Path

import matplotlib
import matplotlib.ticker

matplotlib.use("Agg")
import matplotlib.pyplot as plt

Curve = list[tuple[float, float, float]]  # per k: (value, ci_low, ci_high), k = 0..budget


def _band(ax, ks: list[int], curve: Curve, label: str, color: str, **kw) -> None:
    ax.plot(ks, [c[0] for c in curve], label=label, color=color, lw=2, **kw)
    ax.fill_between(ks, [c[1] for c in curve], [c[2] for c in curve], color=color, alpha=0.15, lw=0)


def accuracy_plot(curves: dict[str, Curve], ceiling: float, floor: float, title: str,
                  path: Path) -> None:
    fig, ax = plt.subplots(figsize=(7, 4.5))
    colors = plt.rcParams["axes.prop_cycle"].by_key()["color"]
    for i, (name, curve) in enumerate(curves.items()):
        _band(ax, list(range(len(curve))), curve, name, colors[i % len(colors)])
    ax.axhline(ceiling, ls="--", color="0.3", lw=1, label=f"read_note oracle ceiling ({ceiling:.2f})")
    ax.axhline(floor, ls=":", color="0.5", lw=1, label=f"no_questions floor ({floor:.2f})")
    ax.set(xlabel="questions asked (budget k)", ylabel="pair-level accuracy", title=title)
    ax.grid(alpha=0.3)
    ax.legend(fontsize=8, loc="lower right")
    fig.tight_layout()
    fig.savefig(path, dpi=150)
    plt.close(fig)


def answered_plot(answered: dict[str, Curve], asked: dict[str, Curve], title: str,
                  path: Path) -> None:
    fig, ax = plt.subplots(figsize=(7, 4.5))
    colors = plt.rcParams["axes.prop_cycle"].by_key()["color"]
    for i, name in enumerate(answered):
        color = colors[i % len(colors)]
        ks = list(range(len(answered[name])))
        _band(ax, ks, answered[name], f"{name}: answered", color)
        ax.plot(ks, [c[0] for c in asked[name]], ls="--", lw=1, color=color,
                label=f"{name}: asked")
    ax.plot([0, ks[-1]], [0, ks[-1]], color="0.7", lw=0.8, label="every question answered")
    ax.set(xlabel="question budget k", ylabel="questions per patient (cumulative)", title=title)
    ax.grid(alpha=0.3)
    ax.legend(fontsize=8, loc="upper left")
    fig.tight_layout()
    fig.savefig(path, dpi=150)
    plt.close(fig)


LABEL_STYLE = {  # label -> (legend text, color)
    "useful_answered": ("useful, answered", "#2a9d8f"),
    "useful_unanswered": ("useful, answer unknown", "#e9c46a"),
    "not_useful": ("not useful (could not change a status)", "#bbbbbb"),
}


def waste_plot(shares: dict[str, dict[str, list[float]]], per_patient: dict[str, dict[str, float]],
               labels: tuple[str, ...], title: str, path: Path) -> None:
    """Stacked horizontal bars: share of each question label, one bar per (key, policy).

    ``shares[key][policy]`` holds the label shares in ``labels`` order (NaN if no questions).
    """
    rows = [(k, p) for k, pol in shares.items() for p in pol]
    fig, ax = plt.subplots(figsize=(8, 0.5 * len(rows) + 1.6))
    ys = list(range(len(rows)))[::-1]
    in_legend: set[str] = set()
    for y, (k, p) in zip(ys, rows):
        vals = shares[k][p]
        if any(math.isnan(v) for v in vals):  # the policy asked nothing
            ax.text(0.01, y, "no questions asked", va="center", fontsize=8, color="0.4")
            continue
        left = 0.0
        for lab, v in zip(labels, vals):
            text, color = LABEL_STYLE[lab]
            ax.barh(y, v, left=left, color=color, edgecolor="white", height=0.7,
                    label=None if lab in in_legend else text)
            in_legend.add(lab)
            if v >= 0.07:
                ax.text(left + v / 2, y, f"{v:.0%}", ha="center", va="center", fontsize=8)
            left += v
        ax.text(1.01, y, f"{per_patient[k][p]:.1f} q/patient", va="center", fontsize=8)
    multi = len(shares) > 1
    ax.set_yticks(ys, [f"{k} · {p}" if multi else p for k, p in rows])
    ax.set_xlim(0, 1)
    ax.xaxis.set_major_formatter(matplotlib.ticker.PercentFormatter(1.0))
    ax.set(xlabel="share of questions asked", title=f"Where the questions go: {title}")
    ax.set_ylim(-0.6, len(rows) - 0.4)
    ax.legend(fontsize=8, loc="upper center", bbox_to_anchor=(0.5, -0.1 - 0.5 / len(rows)),
              ncol=3, frameon=False)
    fig.tight_layout()
    fig.savefig(path, dpi=150, bbox_inches="tight")
    plt.close(fig)
