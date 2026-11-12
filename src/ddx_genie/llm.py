"""The single chokepoint for every LLM call in this project.

Per CLAUDE.md, all spend must be observable and bounded, so everything routes through
``LLMClient``: one OpenAI-compatible client, a disk cache that makes reruns free, a
JSONL cost ledger, and a budget guard that refuses to cross ``MAX_RUN_USD``.

Two backends, selected by ``LLM_BACKEND``:

``gemini_api``
    Static ``GEMINI_API_KEY`` against the Gemini API's OpenAI-compatible endpoint.
    No token lifecycle. This is the default.
``vertex``
    Vertex AI via Application Default Credentials. Tokens expire roughly hourly, so
    ``Credentials.api_key()`` re-mints them mid-run.

Genie Worksheets runs its own LangChain client that we do not control. It reads
``LLM_API_KEY`` and ``LLM_API_BASE_URL`` from the environment lazily, inside
``get_llm_client()``, so :func:`configure_genie_env` can point it at the same backend
and refresh the key before expiry. Genie's own calls therefore do *not* pass through
``LLMClient`` and are not in ``cost.jsonl``; the harness accounts for them separately
from Genie's token logging.
"""

from __future__ import annotations

import hashlib
import json
import os
import threading
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Literal

from dotenv import load_dotenv
from openai import APIConnectionError, APIStatusError, OpenAI, RateLimitError
from tenacity import (
    retry,
    retry_if_exception_type,
    stop_after_attempt,
    wait_exponential,
)

REPO_ROOT = Path(__file__).resolve().parents[2]
CACHE_DIR = REPO_ROOT / ".llm_cache"
RUNS_DIR = REPO_ROOT / "runs"

GEMINI_API_BASE_URL = "https://generativelanguage.googleapis.com/v1beta/openai/"
VERTEX_SCOPE = "https://www.googleapis.com/auth/cloud-platform"

#: Re-mint an ADC token when fewer than this many seconds remain.
TOKEN_REFRESH_MARGIN_S = 300

#: Gemini's FREE TIER allows 15 generate_content requests/minute
#: ("generate_content_free_tier_requests, limit: 15"), which is the binding
#: constraint -- not tokens. Enabling billing on the Cloud project moves the key to
#: the paid tier and lifts this to thousands per minute. Override with
#: REQUESTS_PER_MINUTE. Shared process-wide, since Genie runs its own client against
#: the same quota.
DEFAULT_REQUESTS_PER_MINUTE = 13


class Throttle:
    """Process-wide minimum interval between API calls."""

    def __init__(self, requests_per_minute: float) -> None:
        self.interval = 60.0 / requests_per_minute if requests_per_minute > 0 else 0.0
        self._lock = threading.Lock()
        self._last = 0.0

    def wait(self) -> None:
        if self.interval <= 0:
            return
        with self._lock:
            delay = self._last + self.interval - time.monotonic()
            if delay > 0:
                time.sleep(delay)
            self._last = time.monotonic()


_THROTTLE: Throttle | None = None


def throttle() -> Throttle:
    """The shared throttle, built from REQUESTS_PER_MINUTE on first use."""
    global _THROTTLE
    if _THROTTLE is None:
        load_env()
        _THROTTLE = Throttle(
            _env_float("REQUESTS_PER_MINUTE", DEFAULT_REQUESTS_PER_MINUTE)
        )
    return _THROTTLE

ModelAlias = Literal["cheap", "strong"]

_env_loaded = False


def load_env(*, override: bool = False) -> None:
    """Load ``ddx-genie/.env`` once.

    Note that importing ``worksheets`` calls ``load_dotenv(override=True)`` on
    ``genie-worksheets/src/.env``. That file does not exist today, but if one is ever
    created it silently wins over our values, so call :func:`configure_genie_env`
    *after* importing ``worksheets``.
    """
    global _env_loaded
    if _env_loaded and not override:
        return
    load_dotenv(REPO_ROOT / ".env", override=override)
    _env_loaded = True


def _env(name: str, default: str | None = None) -> str:
    load_env()
    value = os.getenv(name, default)
    if value is None or value == "":
        raise ConfigError(f"{name} is not set in {REPO_ROOT / '.env'}")
    return value


def _env_float(name: str, default: float | None = None) -> float:
    raw = os.getenv(name) if default is not None else _env(name)
    if raw is None or raw == "":
        if default is None:
            raise ConfigError(f"{name} is not set in {REPO_ROOT / '.env'}")
        return default
    try:
        return float(raw)
    except ValueError as exc:
        raise ConfigError(f"{name}={raw!r} is not a number") from exc


class ConfigError(RuntimeError):
    """Required configuration is missing or malformed."""


class BudgetExceeded(RuntimeError):
    """Raised instead of making a call that would push spend past the cap."""


# --------------------------------------------------------------------------- pricing


@dataclass(frozen=True)
class Pricing:
    """USD per million tokens, with the long-prompt tier gemini-2.5-pro uses.

    Rates come from .env, sourced from ai.google.dev/gemini-api/docs/pricing
    (page dated 2026-10-28). Verify against the first real bill.
    """

    usd_per_mtok_in: float
    usd_per_mtok_out: float
    usd_per_mtok_in_long: float | None = None
    usd_per_mtok_out_long: float | None = None
    long_prompt_threshold: int | None = None

    def cost_usd(self, prompt_tokens: int, completion_tokens: int) -> float:
        """Cost of one call. Output tokens include thinking tokens on Gemini 2.5."""
        rate_in, rate_out = self.usd_per_mtok_in, self.usd_per_mtok_out
        if (
            self.long_prompt_threshold is not None
            and prompt_tokens > self.long_prompt_threshold
            and self.usd_per_mtok_in_long is not None
            and self.usd_per_mtok_out_long is not None
        ):
            rate_in, rate_out = self.usd_per_mtok_in_long, self.usd_per_mtok_out_long
        return (prompt_tokens * rate_in + completion_tokens * rate_out) / 1_000_000

    @classmethod
    def from_env(cls, alias: ModelAlias) -> Pricing:
        prefix = "CHEAP_MODEL" if alias == "cheap" else "STRONG_MODEL"
        threshold = os.getenv(f"{prefix}_LONG_PROMPT_THRESHOLD")
        return cls(
            usd_per_mtok_in=_env_float(f"{prefix}_USD_PER_MTOK_IN"),
            usd_per_mtok_out=_env_float(f"{prefix}_USD_PER_MTOK_OUT"),
            usd_per_mtok_in_long=(
                _env_float(f"{prefix}_USD_PER_MTOK_IN_LONG", 0.0) or None
            ),
            usd_per_mtok_out_long=(
                _env_float(f"{prefix}_USD_PER_MTOK_OUT_LONG", 0.0) or None
            ),
            long_prompt_threshold=int(threshold) if threshold else None,
        )


def resolve_model(alias_or_id: ModelAlias | str) -> str:
    """Map ``"cheap"``/``"strong"`` to the configured model id; pass ids through."""
    if alias_or_id == "cheap":
        return _env("CHEAP_MODEL")
    if alias_or_id == "strong":
        return _env("STRONG_MODEL")
    return alias_or_id


def alias_for_model(model_id: str) -> ModelAlias:
    """Reverse of :func:`resolve_model`, so pricing can be found from a model id."""
    load_env()
    if model_id == os.getenv("STRONG_MODEL"):
        return "strong"
    if model_id == os.getenv("CHEAP_MODEL"):
        return "cheap"
    raise ConfigError(
        f"model {model_id!r} is neither CHEAP_MODEL nor STRONG_MODEL, so it has no "
        "configured price; add it to .env before using it"
    )


# ------------------------------------------------------------------------ credentials


class Credentials:
    """Supplies the bearer token and base URL for the configured backend."""

    def __init__(self) -> None:
        load_env()
        self.backend = os.getenv("LLM_BACKEND", "gemini_api").strip()
        if self.backend not in {"gemini_api", "vertex"}:
            raise ConfigError(
                f"LLM_BACKEND={self.backend!r} must be 'gemini_api' or 'vertex'"
            )
        self._lock = threading.Lock()
        self._adc: Any = None

    @property
    def base_url(self) -> str:
        if self.backend == "gemini_api":
            return os.getenv("LLM_API_BASE_URL", GEMINI_API_BASE_URL)
        project, region = _env("GCP_PROJECT_ID"), os.getenv("GCP_REGION", "us-central1")
        return (
            f"https://{region}-aiplatform.googleapis.com/v1/"
            f"projects/{project}/locations/{region}/endpoints/openapi"
        )

    def api_key(self) -> str:
        """A currently-valid key. Re-mints ADC tokens nearing expiry."""
        if self.backend == "gemini_api":
            key = _env("GEMINI_API_KEY")
            if key == "PASTE_YOUR_KEY_HERE":
                raise ConfigError(
                    f"GEMINI_API_KEY is still the placeholder in {REPO_ROOT / '.env'}. "
                    "Get a key at https://aistudio.google.com/apikey"
                )
            return key
        return self._adc_token()

    def _adc_token(self) -> str:
        import google.auth
        import google.auth.transport.requests

        with self._lock:
            if self._adc is None:
                self._adc, _ = google.auth.default(scopes=[VERTEX_SCOPE])
            expiry = getattr(self._adc, "expiry", None)
            stale = expiry is None or (
                expiry.timestamp() - time.time() < TOKEN_REFRESH_MARGIN_S
            )
            if stale or not self._adc.valid:
                self._adc.refresh(google.auth.transport.requests.Request())
            token = self._adc.token
        if not token:
            raise ConfigError("ADC returned an empty access token")
        return token


def configure_genie_env(credentials: Credentials | None = None) -> Credentials:
    """Point Genie's own LangChain client at our backend.

    Genie reads these two vars inside ``get_llm_client()``, so this must run before an
    agent is built, and again before expiry on a ``vertex`` run. Call it *after*
    ``import worksheets``, whose import-time ``load_dotenv(override=True)`` would
    otherwise win. Model ids must not carry an ``azure/`` prefix or Genie routes to
    ``AzureChatOpenAI`` instead.
    """
    creds = credentials or Credentials()
    os.environ["LLM_API_KEY"] = creds.api_key()
    os.environ["LLM_API_BASE_URL"] = creds.base_url
    return creds


# ----------------------------------------------------------------------- disk cache


def cache_key(model: str, messages: list[dict[str, Any]], params: dict[str, Any]) -> str:
    """Content hash over (model, messages, params), per CLAUDE.md."""
    payload = json.dumps(
        {"model": model, "messages": messages, "params": params},
        sort_keys=True,
        ensure_ascii=False,
    )
    return hashlib.sha256(payload.encode()).hexdigest()


class DiskCache:
    """Content-addressed JSON cache. Reruns of an identical call are free."""

    def __init__(self, root: Path = CACHE_DIR, *, enabled: bool = True) -> None:
        self.root = root
        self.enabled = enabled

    def _path(self, key: str) -> Path:
        return self.root / key[:2] / f"{key}.json"

    def get(self, key: str) -> dict[str, Any] | None:
        if not self.enabled:
            return None
        path = self._path(key)
        if not path.exists():
            return None
        try:
            return json.loads(path.read_text())
        except json.JSONDecodeError:
            return None  # a half-written entry is simply a miss

    def put(self, key: str, value: dict[str, Any]) -> None:
        if not self.enabled:
            return
        path = self._path(key)
        path.parent.mkdir(parents=True, exist_ok=True)
        tmp = path.with_suffix(".tmp")
        tmp.write_text(json.dumps(value, ensure_ascii=False))
        tmp.replace(path)  # atomic, so a crash cannot leave a torn entry


# ------------------------------------------------------------------- cost accounting


@dataclass
class CostEntry:
    ts: float
    run_id: str
    model: str
    tag: str
    prompt_tokens: int
    completion_tokens: int
    usd: float
    cached: bool
    latency_s: float

    def as_json(self) -> dict[str, Any]:
        return self.__dict__.copy()


class CostLog:
    """Appends one JSON line per call to ``runs/<run_id>/cost.jsonl``."""

    def __init__(self, run_id: str, *, runs_dir: Path = RUNS_DIR) -> None:
        self.run_id = run_id
        self.path = runs_dir / run_id / "cost.jsonl"
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self._lock = threading.Lock()
        self._total_usd = 0.0
        self._calls = 0
        self._resume_from_disk()

    def _resume_from_disk(self) -> None:
        """Runs are resumable, so spend already logged counts against the cap."""
        if not self.path.exists():
            return
        for line in self.path.read_text().splitlines():
            if not line.strip():
                continue
            try:
                self._total_usd += float(json.loads(line).get("usd", 0.0))
                self._calls += 1
            except (json.JSONDecodeError, TypeError, ValueError):
                continue

    @property
    def total_usd(self) -> float:
        return self._total_usd

    @property
    def calls(self) -> int:
        return self._calls

    def record(self, entry: CostEntry) -> None:
        with self._lock:
            self._total_usd += entry.usd
            self._calls += 1
            with self.path.open("a") as fh:
                fh.write(json.dumps(entry.as_json(), ensure_ascii=False) + "\n")


@dataclass
class BudgetGuard:
    """Refuses a call once logged spend reaches ``max_run_usd``.

    The check is pre-call and based on spend so far, so a single call can still
    overshoot the cap by its own cost. Keep the cap below the real limit.
    """

    max_run_usd: float
    cost_log: CostLog

    def check(self) -> None:
        if self.cost_log.total_usd >= self.max_run_usd:
            raise BudgetExceeded(
                f"run {self.cost_log.run_id!r} has spent "
                f"${self.cost_log.total_usd:.4f} of its ${self.max_run_usd:.2f} cap "
                f"over {self.cost_log.calls} calls; raise MAX_RUN_USD to continue"
            )

    def projected_usd(self, remaining_units: int) -> float:
        """Extrapolate total spend from the mean so far, for pre-batch estimation."""
        if self.cost_log.calls == 0:
            return 0.0
        mean = self.cost_log.total_usd / self.cost_log.calls
        return self.cost_log.total_usd + mean * remaining_units


# ------------------------------------------------------------------------- the client


@dataclass
class Completion:
    text: str
    model: str
    prompt_tokens: int
    completion_tokens: int
    usd: float
    cached: bool
    latency_s: float
    #: Raw OpenAI-format tool calls, when the request supplied ``tools``.
    tool_calls: list[dict[str, Any]] = field(default_factory=list)


_TRANSIENT = (APIConnectionError, RateLimitError)


class LLMClient:
    """OpenAI-compatible client with caching, cost logging and a budget guard."""

    def __init__(
        self,
        run_id: str,
        *,
        max_run_usd: float | None = None,
        cache: DiskCache | None = None,
        runs_dir: Path = RUNS_DIR,
        timeout_s: float = 120.0,
    ) -> None:
        load_env()
        self.credentials = Credentials()
        self.cost_log = CostLog(run_id, runs_dir=runs_dir)
        self.budget = BudgetGuard(
            max_run_usd=(
                max_run_usd if max_run_usd is not None else _env_float("MAX_RUN_USD", 5.0)
            ),
            cost_log=self.cost_log,
        )
        self.cache = cache if cache is not None else DiskCache()
        self._timeout_s = timeout_s
        self._client: OpenAI | None = None
        self._client_key: str | None = None
        self._pricing: dict[ModelAlias, Pricing] = {}

    def _openai(self) -> OpenAI:
        """Rebuild the client when the key rotates (``vertex`` token refresh)."""
        key = self.credentials.api_key()
        if self._client is None or key != self._client_key:
            self._client = OpenAI(
                api_key=key, base_url=self.credentials.base_url, timeout=self._timeout_s
            )
            self._client_key = key
        return self._client

    def pricing(self, model: str) -> Pricing:
        alias = alias_for_model(model)
        if alias not in self._pricing:
            self._pricing[alias] = Pricing.from_env(alias)
        return self._pricing[alias]

    def complete(
        self,
        messages: list[dict[str, Any]],
        *,
        model: ModelAlias | str = "cheap",
        tag: str = "",
        temperature: float = 0.0,
        max_tokens: int = 1024,
        use_cache: bool = True,
        **extra: Any,
    ) -> Completion:
        """One chat completion. ``tag`` labels the call in ``cost.jsonl``."""
        model_id = resolve_model(model)
        params: dict[str, Any] = {
            "temperature": temperature,
            "max_tokens": max_tokens,
            **extra,
        }
        key = cache_key(model_id, messages, params)

        if use_cache and (hit := self.cache.get(key)) is not None:
            # A cached replay costs nothing, but keep the token counts for reporting.
            completion = Completion(
                text=hit["text"],
                model=model_id,
                prompt_tokens=hit.get("prompt_tokens", 0),
                completion_tokens=hit.get("completion_tokens", 0),
                usd=0.0,
                cached=True,
                latency_s=0.0,
                tool_calls=hit.get("tool_calls") or [],
            )
            self._log(completion, tag)
            return completion

        self.budget.check()
        throttle().wait()
        started = time.monotonic()
        response = self._create(messages, model_id, params)
        latency = time.monotonic() - started

        usage = response.usage
        prompt_tokens = getattr(usage, "prompt_tokens", 0) or 0
        completion_tokens = getattr(usage, "completion_tokens", 0) or 0
        message = response.choices[0].message
        text = message.content or ""
        # Preserve the tool call verbatim. Gemini attaches
        # extra_content.google.thought_signature to each call and rejects the next
        # request with a 400 if it is not echoed back, so rebuilding the dict from
        # just id/name/arguments silently breaks multi-turn tool use.
        tool_calls = []
        for call in getattr(message, "tool_calls", None) or []:
            try:
                tool_calls.append(call.model_dump(exclude_none=True))
            except AttributeError:
                tool_calls.append(
                    {
                        "id": call.id,
                        "type": "function",
                        "function": {
                            "name": call.function.name,
                            "arguments": call.function.arguments,
                        },
                    }
                )

        completion = Completion(
            text=text,
            model=model_id,
            prompt_tokens=prompt_tokens,
            completion_tokens=completion_tokens,
            usd=self.pricing(model_id).cost_usd(prompt_tokens, completion_tokens),
            cached=False,
            latency_s=latency,
            tool_calls=tool_calls,
        )
        if use_cache:
            self.cache.put(
                key,
                {
                    "text": text,
                    "model": model_id,
                    "prompt_tokens": prompt_tokens,
                    "completion_tokens": completion_tokens,
                    "tool_calls": tool_calls,
                },
            )
        self._log(completion, tag)
        return completion

    @retry(
        retry=retry_if_exception_type(_TRANSIENT),
        stop=stop_after_attempt(6),
        wait=wait_exponential(multiplier=1, min=2, max=45),
        reraise=True,
    )
    def _create(
        self, messages: list[dict[str, Any]], model_id: str, params: dict[str, Any]
    ) -> Any:
        try:
            return self._openai().chat.completions.create(
                model=model_id, messages=messages, **params
            )
        except APIStatusError as exc:
            if exc.status_code in (408, 429, 500, 502, 503, 504):
                raise APIConnectionError(request=exc.request) from exc
            raise

    def _log(self, completion: Completion, tag: str) -> None:
        self.cost_log.record(
            CostEntry(
                ts=time.time(),
                run_id=self.cost_log.run_id,
                model=completion.model,
                tag=tag,
                prompt_tokens=completion.prompt_tokens,
                completion_tokens=completion.completion_tokens,
                usd=completion.usd,
                cached=completion.cached,
                latency_s=round(completion.latency_s, 3),
            )
        )

    def record_external(
        self,
        *,
        model: str,
        prompt_tokens: int,
        completion_tokens: int,
        tag: str,
        latency_s: float = 0.0,
        cached: bool = False,
    ) -> float:
        """Log a call made by someone else's client, and return its cost.

        Genie runs its own LangChain client, so its calls never pass through
        :meth:`complete`. Without this the ledger would show zero spend for the very
        calls that dominate a run, and the budget guard would be blind. Returns the
        USD cost so callers can surface it.
        """
        try:
            usd = self.pricing(model).cost_usd(prompt_tokens, completion_tokens)
        except ConfigError:
            # An unpriced model must not silently log as free.
            usd = float("nan")
        completion = Completion(
            text="",
            model=model,
            prompt_tokens=prompt_tokens,
            completion_tokens=completion_tokens,
            usd=0.0 if cached else usd,
            cached=cached,
            latency_s=latency_s,
        )
        self._log(completion, tag)
        return completion.usd

    def summary(self) -> str:
        return (
            f"run {self.cost_log.run_id}: {self.cost_log.calls} calls, "
            f"${self.cost_log.total_usd:.4f} of ${self.budget.max_run_usd:.2f}"
        )
