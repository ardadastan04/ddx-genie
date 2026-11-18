"""Dev sweep of the cohort-credit weight (AnswerableConfig.w_cohort); every other weight as in policy-v1.

Each module-level name is a policy the harness can load, e.g.
``scripts/sweep_cohort_credit.py:cohort_0_7``. Solver only, no LLM calls; dev split only.

  uv run python -m smt_trial_matching.experiment --split dev --budget 30 --run-id sweep_cohort_dev \\
    --reference greedy_smt --policies no_questions,random_stop,greedy_smt,\\
smt_trial_matching.policies:oracle_answerable_greedy,scripts/sweep_cohort_credit.py:cohort_0_5,\\
scripts/sweep_cohort_credit.py:cohort_0_7,scripts/sweep_cohort_credit.py:cohort_0_9,\\
scripts/sweep_cohort_credit.py:cohort_1_0
"""

from smt_trial_matching.policies import AnswerableConfig, AnswerableInformative

cohort_0_5 = AnswerableInformative(AnswerableConfig(w_cohort=0.5))  # current default
cohort_0_7 = AnswerableInformative(AnswerableConfig(w_cohort=0.7))
cohort_0_9 = AnswerableInformative(AnswerableConfig(w_cohort=0.9))
cohort_1_0 = AnswerableInformative(AnswerableConfig(w_cohort=1.0))
