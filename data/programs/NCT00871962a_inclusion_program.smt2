;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=3
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_needs_to_undergo_long_term_oxygen_therapy_now Bool)
(declare-const patient_oxygen_measurement_partial_pressure_arterial_value_recorded_now_withunit_mmhg@@measured_at_rest Real)
(declare-const patient_oxygen_measurement_partial_pressure_arterial_value_recorded_now_withunit_mmhg@@measured_during_sleeping Real)
(declare-const patient_oxygen_measurement_partial_pressure_arterial_value_recorded_now_withunit_mmhg@@measured_during_exercise Real)
(declare-const patient_supplemental_oxygen_demonstrated_to_improve_exercise_associated_hypoxia_now Bool)
(declare-const patient_has_finding_of_patient_s_condition_stable_now Bool)
(declare-const patient_has_oxygen_device_of_antadir_network_now Bool)

;; Other kept assertions
(assert (! patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_needs_to_undergo_long_term_oxygen_therapy_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_needs_to_undergo_long_term_oxygen_therapy_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (< patient_oxygen_measurement_partial_pressure_arterial_value_recorded_now_withunit_mmhg@@measured_at_rest 55) (< patient_oxygen_measurement_partial_pressure_arterial_value_recorded_now_withunit_mmhg@@measured_during_sleeping 55) (and (< patient_oxygen_measurement_partial_pressure_arterial_value_recorded_now_withunit_mmhg@@measured_during_exercise 55) patient_supplemental_oxygen_demonstrated_to_improve_exercise_associated_hypoxia_now)) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_patient_s_condition_stable_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_oxygen_device_of_antadir_network_now :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
