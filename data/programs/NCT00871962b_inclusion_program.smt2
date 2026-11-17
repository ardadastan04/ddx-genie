;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_needs_to_undergo_long_term_oxygen_therapy_now Bool)
(declare-const patient_is_being_treated_with_long_term_oxygen_therapy_now Bool)
(declare-const patient_partial_pressure_of_oxygen_value_recorded_now_withunit_mm_hg Real)
(declare-const patient_has_finding_of_dependent_edema_now Bool)
(declare-const patient_has_finding_of_pulmonary_hypertension_now Bool)
(declare-const patient_hematocrit_value_recorded_now_withunit_percent Real)
(declare-const patient_has_finding_of_patient_s_condition_stable_now Bool)
(declare-const patient_has_oxygen_device_from_antadir_network_now Bool)

;; Other kept assertions
(assert (! patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_needs_to_undergo_long_term_oxygen_therapy_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_being_treated_with_long_term_oxygen_therapy_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (=> (and (>= patient_partial_pressure_of_oxygen_value_recorded_now_withunit_mm_hg 56.0) (<= patient_partial_pressure_of_oxygen_value_recorded_now_withunit_mm_hg 59.0)) (or patient_has_finding_of_dependent_edema_now patient_has_finding_of_pulmonary_hypertension_now (> patient_hematocrit_value_recorded_now_withunit_percent 56.0))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_patient_s_condition_stable_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_oxygen_device_from_antadir_network_now :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
