"""The Genie Worksheets clinical-intake agent.

Run it and play the patient yourself:

    uv run python genie/agent.py

Two things here are load-bearing and easy to get wrong:

``init_llm``
    ``Config`` has no ``prompt_dir`` field, and ``import worksheets`` already calls
    ``init_llm`` pointing at Genie's own bundled prompts. Unless we call it again with
    our directory, the agent silently runs the generic course-enrollment prompts and
    behaves plausibly but wrongly. :func:`configure_prompts` does that, and asserts
    our files are the ones that resolved.

the 10s timeout
    ``worksheets/llm/llm.py`` hardcodes ``timeout=10`` when constructing its client.
    Our prompts are ~2k tokens and Gemini can exceed that, which surfaces as a retry
    storm rather than a clean error. :func:`patch_genie_timeout` raises it without
    editing the package, per CLAUDE.md.
"""

from __future__ import annotations

import argparse
import asyncio
import os
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT / "src") not in sys.path:  # runnable as a plain script
    sys.path.insert(0, str(REPO_ROOT / "src"))

import worksheets  # noqa: E402  (must precede the init_llm and env wiring below)
from worksheets import AgentBuilder, Config  # noqa: E402
from worksheets.llm.prompts import init_llm  # noqa: E402

from ddx_genie.diagnosis import diagnose, set_client  # noqa: E402
from ddx_genie.llm import LLMClient, configure_genie_env  # noqa: E402

GENIE_DIR = REPO_ROOT / "genie"
PROMPT_DIR = GENIE_DIR / "prompts"
CONFIG_PATH = GENIE_DIR / "config.yaml"
INTAKE_CSV = GENIE_DIR / "intake.csv"

REQUIRED_PROMPTS = ("semantic_parser.prompt", "response_generator.prompt")

#: Genie's hardcoded timeout is 10s; our prompts are far larger than its examples.
LLM_TIMEOUT_S = 120.0

AGENT_NAME = "Clinical Intake Assistant"

AGENT_DESCRIPTION = (
    "You are a clinical intake assistant. You interview a patient about their "
    "symptoms and medical history to build a structured record for a clinician. "
    "You ask one clear question at a time in plain, everyday language. You never "
    "give a diagnosis, never give medical advice, and never speculate about what "
    "the patient might have."
)

STARTING_PROMPT = (
    "Hello, I'm here to take some details about your symptoms before you see a "
    "clinician. What's been bothering you?"
)


def configure_prompts() -> None:
    """Point Genie's jinja loader at our prompts, and prove that it took effect."""
    missing = [name for name in REQUIRED_PROMPTS if not (PROMPT_DIR / name).exists()]
    if missing:
        raise FileNotFoundError(f"missing prompts in {PROMPT_DIR}: {missing}")

    init_llm(prompt_dir=str(PROMPT_DIR), dotenv_path=str(REPO_ROOT / ".env"))

    # A wrong prompt_dir is silent: Genie falls back to its bundled prompts and the
    # agent still runs, just as a course-enrollment bot. Verify the resolved path.
    from worksheets.llm import prompts as prompt_module

    for name in REQUIRED_PROMPTS:
        resolved = prompt_module.jinja_environment.loader.get_source(
            prompt_module.jinja_environment, name
        )[1]
        if Path(resolved).resolve() != (PROMPT_DIR / name).resolve():
            raise RuntimeError(
                f"{name} resolved to {resolved}, not our copy in {PROMPT_DIR}. "
                "The agent would run on Genie's generic prompts."
            )


def patch_genie_llm(client: LLMClient, timeout_s: float = LLM_TIMEOUT_S) -> None:
    """Raise Genie's hardcoded timeout and route its token usage into our ledger.

    Patches the model classes rather than ``get_llm_client``, because several modules
    already did ``from worksheets.llm.llm import get_llm_client`` at import time and
    would keep their own reference to the original function. The class objects are
    shared, so wrapping them reaches every call site.

    Two wrappers:

    ``__init__``
        forces ``timeout`` past Genie's hardcoded 10s, which our ~2k-token prompts
        would otherwise trip, surfacing as a retry storm rather than a clean error.
    ``agenerate``
        records prompt/completion tokens against ``cost.jsonl``. Genie's calls are
        the bulk of a run's spend; unlogged, the budget guard protects nothing.
    """
    import time

    from worksheets.llm import llm as genie_llm

    for class_name in ("OpenAIModelCall", "AzureModelCall"):
        model_class = getattr(genie_llm, class_name)
        if getattr(model_class, "_ddx_patched", False):
            continue

        original_init = model_class.__init__
        original_agenerate = model_class.agenerate

        def make_init(original):
            def __init__(self, *args, **kwargs):
                kwargs["timeout"] = timeout_s
                kwargs.setdefault("max_retries", 5)
                # Genie defaults to 40 requests/second, which blows straight through
                # Gemini's tokens-per-minute quota at our ~2.2k-token prompt size.
                from langchain_core.rate_limiters import InMemoryRateLimiter

                from ddx_genie.llm import throttle as ddx_throttle

                interval = ddx_throttle().interval
                if interval > 0:
                    kwargs["rate_limiter"] = InMemoryRateLimiter(
                        requests_per_second=1.0 / interval,
                        check_every_n_seconds=0.1,
                        max_bucket_size=1,
                    )
                original(self, *args, **kwargs)

            return __init__

        def make_agenerate(original):
            async def agenerate(self, *args, **kwargs):
                started = time.monotonic()
                result = await original(self, *args, **kwargs)
                latency = time.monotonic() - started
                usage = (getattr(result, "llm_output", None) or {}).get(
                    "token_usage", {}
                ) or {}
                prompt_tokens = int(usage.get("prompt_tokens", 0) or 0)
                completion_tokens = int(usage.get("completion_tokens", 0) or 0)
                # Genie's Redis cache reports zero usage; log it as a cached call so
                # the ledger's call count still reflects what the agent did.
                client.record_external(
                    model=self.model_name,
                    prompt_tokens=prompt_tokens,
                    completion_tokens=completion_tokens,
                    tag="genie",
                    latency_s=latency,
                    cached=(prompt_tokens == 0 and completion_tokens == 0),
                )
                return result

            return agenerate

        model_class.__init__ = make_init(original_init)
        model_class.agenerate = make_agenerate(original_agenerate)
        model_class._ddx_patched = True


def build_agent(
    run_id: str = "manual",
    *,
    csv_path: Path = INTAKE_CSV,
    client: LLMClient | None = None,
):
    """Construct the intake agent. No knowledge base: both are optional in build().

    Pass ``client`` to log Genie's calls into an existing ledger. The harness must do
    this: a second LLMClient writes to the same cost.jsonl but keeps its own in-memory
    total, so the caller's budget guard and per-patient cost attribution would both
    miss every call Genie makes -- which is most of them.
    """
    if not csv_path.exists():
        raise FileNotFoundError(
            f"{csv_path} is missing; run `python -m ddx_genie.worksheet_gen` first"
        )

    configure_prompts()

    # Must come after `import worksheets`, whose import-time load_dotenv(override=True)
    # would otherwise clobber these two values. The client is built before the patch
    # because the patch logs into its ledger.
    client = client or LLMClient(run_id)
    configure_genie_env(client.credentials)
    patch_genie_llm(client)
    set_client(client)

    config = Config.load_from_yaml(str(CONFIG_PATH))
    agent = (
        AgentBuilder(
            name=AGENT_NAME,
            description=AGENT_DESCRIPTION,
            starting_prompt=STARTING_PROMPT,
        )
        .with_csv_specification(str(csv_path))
        .add_api(diagnose, "Produce a top-5 differential diagnosis from the findings")
        .build(config)
    )
    return agent, client


def main() -> int:
    parser = argparse.ArgumentParser(description="Talk to the Genie intake agent.")
    parser.add_argument("--run-id", default="manual", help="cost ledger run id")
    parser.add_argument("--debug", action="store_true", help="post-mortem on error")
    args = parser.parse_args()

    os.environ.setdefault("DDX_RUN_ID", args.run_id)
    agent, client = build_agent(args.run_id)

    from worksheets import conversation_loop

    print(f"model    : {os.environ.get('CHEAP_MODEL')}")
    print(f"worksheet: {INTAKE_CSV.relative_to(REPO_ROOT)}")
    print(f"prompts  : {PROMPT_DIR.relative_to(REPO_ROOT)}")
    print("type 'exit' to stop\n")
    try:
        asyncio.run(conversation_loop(agent, debug=args.debug))
    finally:
        print(f"\n{client.summary()}")
        print(f"ledger: {client.cost_log.path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
