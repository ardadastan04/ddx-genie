;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_benign_prostatic_hyperplasia_now Bool)
(declare-const patient_has_prescription_claim_for_5_alpha_reductase_inhibitor_during_observation_period Bool)
(declare-const patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory Bool)
(declare-const prescription_claim_5_alpha_reductase_inhibitor_duration_in_observation_period_in_days Real)
(declare-const continuous_eligibility_duration_prior_to_index_date_in_months Real)
(declare-const continuous_eligibility_duration_after_index_date_in_months Real)
(declare-const patient_is_continuously_eligible_for_6_months_prior_to_index_date Bool)
(declare-const patient_is_continuously_eligible_for_6_months_after_index_date Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_prescription_claim_for_5_alpha_reductase_inhibitor_during_observation_period patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory) :named REQ3_AUXILIARY0))
(assert (! (= patient_is_continuously_eligible_for_6_months_prior_to_index_date (>= continuous_eligibility_duration_prior_to_index_date_in_months 6.0)) :named REQ4_AUXILIARY0))
(assert (! (= patient_is_continuously_eligible_for_6_months_after_index_date (>= continuous_eligibility_duration_after_index_date_in_months 6.0)) :named REQ4_AUXILIARY1))

;; Other kept assertions
(assert (! patient_sex_is_male_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 50.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_benign_prostatic_hyperplasia_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_prescription_claim_for_5_alpha_reductase_inhibitor_during_observation_period (>= prescription_claim_5_alpha_reductase_inhibitor_duration_in_observation_period_in_days 60)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_continuously_eligible_for_6_months_prior_to_index_date :named REQ4_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_continuously_eligible_for_6_months_after_index_date :named REQ4_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
