;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_benign_prostatic_hyperplasia_now Bool)
(declare-const duration_of_5_alpha_reductase_inhibitor_prescription_claim_during_observation_period_in_days Real)
(declare-const patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory Bool)
(declare-const patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory@@identified_by_prescription_claim Bool)
(declare-const patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory@@duration_at_least_60_days_during_observation_period Bool)
(declare-const patient_is_continuously_eligible_for_months_prior_to_index_date Real)
(declare-const patient_is_continuously_eligible_for_months_after_index_date Real)

;; Existing auxiliary assertions
(assert (! (= patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory@@duration_at_least_60_days_during_observation_period (>= duration_of_5_alpha_reductase_inhibitor_prescription_claim_during_observation_period_in_days 60.0)) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory@@identified_by_prescription_claim patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory) :named REQ3_AUXILIARY1))
(assert (! (=> patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory@@duration_at_least_60_days_during_observation_period patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory) :named REQ3_AUXILIARY2))

;; Other kept assertions
(assert (! patient_sex_is_male_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 50.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_benign_prostatic_hyperplasia_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory@@identified_by_prescription_claim patient_has_undergone_administration_of_5_alpha_reductase_inhibitor_inthehistory@@duration_at_least_60_days_during_observation_period) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_is_continuously_eligible_for_months_prior_to_index_date 6.0) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_is_continuously_eligible_for_months_after_index_date 6.0) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
