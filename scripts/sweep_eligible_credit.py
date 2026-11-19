"""Dev sweep of the eligible-credit weight (AnswerableConfig.w_eligible); every other weight at its default.

w_eligible is the value of an answer that would make a trial certainly eligible (which ends its questions
but never flips the verdict, since undetermined already counts as eligible). Solver only, no LLM calls;
dev split only.

  uv run python -m smt_trial_matching.experiment --split dev --budget 30 --run-id sweep_eligible_dev \\
    --reference scripts/sweep_eligible_credit.py:eligible_0_2 --policies no_questions,greedy_smt,\\
smt_trial_matching.policies:oracle_answerable_greedy,scripts/sweep_eligible_credit.py:eligible_0_2,\\
scripts/sweep_eligible_credit.py:eligible_0_1,scripts/sweep_eligible_credit.py:eligible_0_05,\\
scripts/sweep_eligible_credit.py:eligible_0_0
"""

from smt_trial_matching.policies import AnswerableConfig, AnswerableInformative

eligible_0_2 = AnswerableInformative(AnswerableConfig(w_eligible=0.2))  # current default
eligible_0_1 = AnswerableInformative(AnswerableConfig(w_eligible=0.1))
eligible_0_05 = AnswerableInformative(AnswerableConfig(w_eligible=0.05))
eligible_0_0 = AnswerableInformative(AnswerableConfig(w_eligible=0.0))
