"""The two harness plots: accuracy vs budget, and cumulative answered questions vs budget."""

from __future__ import annotations

from pathlib import Path

import matplotlib

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
