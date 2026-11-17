;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter Real)
(declare-const patient_has_diagnosis_of_hypertensive_disorder_inthehistory Bool)
(declare-const patient_has_diagnosis_of_dyslipidemia_inthehistory Bool)
(declare-const patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_inthehistory Bool)
(declare-const patient_has_diagnosis_of_disorder_of_cardiovascular_system_inthehistory Bool)
(declare-const patient_has_history_of_unsuccessful_dietary_effort_to_lose_body_weight Bool)
(declare-const patient_number_of_unsuccessful_dietary_efforts_to_lose_body_weight_in_the_history Real)

;; Existing auxiliary assertions
(assert (! (= patient_has_history_of_unsuccessful_dietary_effort_to_lose_body_weight (>= patient_number_of_unsuccessful_dietary_efforts_to_lose_body_weight_in_the_history 1)) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 27.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_diagnosis_of_hypertensive_disorder_inthehistory patient_has_diagnosis_of_dyslipidemia_inthehistory patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_inthehistory patient_has_diagnosis_of_disorder_of_cardiovascular_system_inthehistory) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_history_of_unsuccessful_dietary_effort_to_lose_body_weight :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
