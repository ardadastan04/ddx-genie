;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=5 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const parkinson_s_disease_diagnosis_duration_prior_to_recruitment_in_months Real)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_inthehistory@@diagnosed_by_movement_disorder_specialist Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_inthehistory@@diagnosis_present_for_at_least_3_months_prior_to_recruitment Bool)
(declare-const parkinsons_disease_medication_regimen_is_stable_with_no_changes_in_past_3_months Bool)
(declare-const patient_is_at_hoehn_and_yahr_stage_2_now Bool)
(declare-const patient_is_at_hoehn_and_yahr_stage_3_now Bool)
(declare-const patient_has_finding_of_independent_walking_now Bool)
(declare-const patient_is_able_to_walk_with_simple_assistive_device_now Bool)
(declare-const patient_is_able_to_walk_with_cane_now Bool)
(declare-const patient_is_able_to_walk_with_walker_now Bool)
(declare-const patient_has_finding_of_extrapyramidal_gait_now Bool)
(declare-const patient_has_finding_of_extrapyramidal_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen Bool)
(declare-const patient_has_finding_of_freezing_of_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen Bool)
(declare-const patient_has_finding_of_shortened_stride_lengths_now@@observed_by_research_team_while_on_regular_treatment_regimen Bool)
(declare-const patient_has_finding_of_irregular_stride_lengths_now@@observed_by_research_team_while_on_regular_treatment_regimen Bool)
(declare-const patient_has_finding_of_irregular_step_cadence_now@@observed_by_research_team_while_on_regular_treatment_regimen Bool)
(declare-const patient_has_finding_of_slowed_speed_now@@observed_by_research_team_while_on_regular_treatment_regimen Bool)
(declare-const patient_has_finding_of_irregular_step_cadence_now Bool)
(declare-const patient_has_finding_of_shortened_stride_lengths_now Bool)
(declare-const patient_has_finding_of_slowed_speed_now Bool)
(declare-const patient_has_finding_of_irregular_stride_lengths_now Bool)
(declare-const patient_has_finding_of_freezing_of_gait_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_diagnosis_of_parkinson_s_disease_inthehistory@@diagnosis_present_for_at_least_3_months_prior_to_recruitment (>= parkinson_s_disease_diagnosis_duration_prior_to_recruitment_in_months 3.0)) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_inthehistory@@diagnosed_by_movement_disorder_specialist patient_has_diagnosis_of_parkinson_s_disease_inthehistory) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_inthehistory@@diagnosis_present_for_at_least_3_months_prior_to_recruitment patient_has_diagnosis_of_parkinson_s_disease_inthehistory) :named REQ1_AUXILIARY2))
(assert (! (=> (or patient_is_able_to_walk_with_cane_now patient_is_able_to_walk_with_walker_now) patient_is_able_to_walk_with_simple_assistive_device_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_finding_of_extrapyramidal_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_extrapyramidal_gait_now) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_finding_of_freezing_of_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_extrapyramidal_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen) :named REQ5_AUXILIARY1))
(assert (! (=> patient_has_finding_of_shortened_stride_lengths_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_extrapyramidal_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen) :named REQ5_AUXILIARY2))
(assert (! (=> patient_has_finding_of_irregular_stride_lengths_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_extrapyramidal_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen) :named REQ5_AUXILIARY3))
(assert (! (=> patient_has_finding_of_irregular_step_cadence_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_extrapyramidal_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen) :named REQ5_AUXILIARY4))
(assert (! (=> patient_has_finding_of_slowed_speed_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_extrapyramidal_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen) :named REQ5_AUXILIARY5))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_freezing_of_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_freezing_of_gait_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_irregular_step_cadence_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_irregular_step_cadence_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_irregular_stride_lengths_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_irregular_stride_lengths_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_finding_of_shortened_stride_lengths_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_shortened_stride_lengths_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_has_finding_of_slowed_speed_now@@observed_by_research_team_while_on_regular_treatment_regimen patient_has_finding_of_slowed_speed_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 21.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_diagnosis_of_parkinson_s_disease_inthehistory@@diagnosed_by_movement_disorder_specialist patient_has_diagnosis_of_parkinson_s_disease_inthehistory@@diagnosis_present_for_at_least_3_months_prior_to_recruitment) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! parkinsons_disease_medication_regimen_is_stable_with_no_changes_in_past_3_months :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_is_at_hoehn_and_yahr_stage_2_now patient_is_at_hoehn_and_yahr_stage_3_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_independent_walking_now patient_is_able_to_walk_with_simple_assistive_device_now) :named REQ4_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_extrapyramidal_gait_now@@observed_by_research_team_while_on_regular_treatment_regimen :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
