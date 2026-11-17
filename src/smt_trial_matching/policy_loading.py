"""Resolve a policy spec to a function with the CA's signature ``policy(states, asked, rng)``.

Accepted specs:
- a name in ``baselines.policies.POLICIES`` (``no_questions``, ``random_stop``, ``greedy_smt``, ``ask_all``);
- ``module.path:function``, e.g. ``smt_trial_matching.policies:answerable_greedy``;
- ``path/to/file.py:function``, relative to the repo root or absolute,
  e.g. ``src/smt_trial_matching/policies.py:answerable_greedy``.

Specs are resolved inside each worker process, so a policy only has to be importable, not picklable.
"""

from __future__ import annotations

import importlib
import importlib.util
import sys
from collections.abc import Callable
from functools import cache
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:  # `baselines/` is a plain directory, not an installed package
    sys.path.insert(0, str(ROOT))

Policy = Callable[[dict, set, Any], "tuple[str, str] | None"]


def _ca_policies() -> dict[str, Policy]:
    from baselines.policies import POLICIES

    return POLICIES


def _load_file(path: Path) -> Any:
    name = f"_policy_file_{abs(hash(str(path)))}"
    if name in sys.modules:
        return sys.modules[name]
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise ValueError(f"cannot import {path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


@cache
def load_policy(spec: str) -> Policy:
    """Return the policy function named by ``spec`` (see module docstring)."""
    if ":" not in spec:
        policies = _ca_policies()
        if spec not in policies:
            raise ValueError(f"unknown policy {spec!r}; CA policies: {sorted(policies)}, "
                             "or use module.path:function / file.py:function")
        return policies[spec]
    target, func = spec.rsplit(":", 1)
    if target.endswith(".py") or "/" in target:
        path = Path(target) if Path(target).is_absolute() else ROOT / target
        if not path.exists():
            raise ValueError(f"policy file not found: {path}")
        module = _load_file(path.resolve())
    else:
        module = importlib.import_module(target)
    fn = getattr(module, func, None)
    if not callable(fn):
        raise TypeError(f"{target} has no callable {func!r}")
    return fn


def policy_label(spec: str) -> str:
    """Short name used for log files and plots: the CA name, or the function name."""
    return spec.rsplit(":", 1)[-1]
