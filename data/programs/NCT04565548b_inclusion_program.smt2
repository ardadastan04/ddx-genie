;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_owns_mobile_phone_now Bool)
(declare-const patient_is_able_to_use_mobile_phone_now Bool)
(declare-const patient_has_finding_of_main_spoken_language_cantonese_now Bool)
(declare-const patient_has_finding_of_reads_chinese_now Bool)
(declare-const patient_has_diagnosis_of_hypertensive_disorder_now Bool)
(declare-const patient_is_exposed_to_hypotensive_agent_now Bool)
(declare-const patient_systolic_blood_pressure_value_recorded_now_withunit_millimeters_of_mercury Real)
(declare-const patient_diastolic_blood_pressure_value_recorded_now_withunit_millimeters_of_mercury Real)

;; Other kept assertions
(assert (! patient_owns_mobile_phone_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_able_to_use_mobile_phone_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_main_spoken_language_cantonese_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_reads_chinese_now :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_hypertensive_disorder_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_exposed_to_hypotensive_agent_now :named REQ2_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (and (>= patient_systolic_blood_pressure_value_recorded_now_withunit_millimeters_of_mercury 131.0) (<= patient_systolic_blood_pressure_value_recorded_now_withunit_millimeters_of_mercury 159.0)) (and (>= patient_diastolic_blood_pressure_value_recorded_now_withunit_millimeters_of_mercury 81.0) (<= patient_diastolic_blood_pressure_value_recorded_now_withunit_millimeters_of_mercury 99.0))) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
