;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_able_to_give_informed_consent_now Bool)
(declare-const patient_has_ability_to_comply_with_schedule_of_at_home_tests_with_qmat_system Bool)
(declare-const patient_has_ability_to_comply_with_routine_of_at_home_tests_with_qmat_system_responsibly Bool)
(declare-const patient_has_ability_to_perform_qmat_testing Bool)
(declare-const patient_has_current_enrollment_in_12_n_0137 Bool)
(declare-const patient_has_planned_enrollment_in_12_n_0137 Bool)

;; Other kept assertions
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_give_informed_consent_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_ability_to_comply_with_schedule_of_at_home_tests_with_qmat_system :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_ability_to_comply_with_routine_of_at_home_tests_with_qmat_system_responsibly :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_ability_to_perform_qmat_testing :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_current_enrollment_in_12_n_0137 patient_has_planned_enrollment_in_12_n_0137) :named REQ5_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
