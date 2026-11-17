;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_postpartum_now Bool)
(declare-const patient_systolic_blood_pressure_value_recorded_now_withunit_mm_hg Real)
(declare-const patient_systolic_blood_pressure_value_recorded_now_withunit_mm_hg@@repeat_measurement_after_15_minutes_rest Bool)
(declare-const patient_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg Real)
(declare-const patient_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg@@repeat_measurement_after_15_minutes_rest Bool)
(declare-const patient_is_pregnant_or_postpartum_now Bool)
(declare-const pregnancy_gestational_age_value_recorded_now_in_weeks Real)
(declare-const patient_has_finding_of_pregnancy_induced_hypertension_now Bool)
(declare-const patient_has_finding_of_severe_pre_eclampsia_now Bool)
(declare-const patient_has_finding_of_essential_hypertension_now Bool)
(declare-const patient_has_finding_of_pre_eclampsia_added_to_pre_existing_hypertension_now Bool)
(declare-const patient_has_finding_of_eclampsia_now Bool)
(declare-const patient_has_finding_of_hypertensive_disorder_now Bool)
(declare-const postpartum_time_since_delivery_value_in_hours Real)
(declare-const patient_has_singleton_pregnancy_now Bool)
(declare-const patient_has_multiple_pregnancy_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_pregnant_or_postpartum_now (or patient_is_pregnant_now patient_is_postpartum_now)) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_is_pregnant_or_postpartum_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (and patient_systolic_blood_pressure_value_recorded_now_withunit_mm_hg@@repeat_measurement_after_15_minutes_rest (>= patient_systolic_blood_pressure_value_recorded_now_withunit_mm_hg 160.0)) (and patient_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg@@repeat_measurement_after_15_minutes_rest (>= patient_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg 110.0))) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (=> patient_is_pregnant_now (> pregnancy_gestational_age_value_recorded_now_in_weeks 28.0)) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (=> patient_is_pregnant_now (or patient_has_finding_of_pregnancy_induced_hypertension_now patient_has_finding_of_severe_pre_eclampsia_now patient_has_finding_of_essential_hypertension_now patient_has_finding_of_pre_eclampsia_added_to_pre_existing_hypertension_now patient_has_finding_of_eclampsia_now patient_has_finding_of_hypertensive_disorder_now)) :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (=> patient_is_postpartum_now (<= postpartum_time_since_delivery_value_in_hours 72.0)) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (=> patient_is_postpartum_now (or patient_has_finding_of_pregnancy_induced_hypertension_now patient_has_finding_of_severe_pre_eclampsia_now patient_has_finding_of_essential_hypertension_now patient_has_finding_of_pre_eclampsia_added_to_pre_existing_hypertension_now patient_has_finding_of_eclampsia_now patient_has_finding_of_hypertensive_disorder_now)) :named REQ2_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (=> patient_is_pregnant_now (or patient_has_singleton_pregnancy_now patient_has_multiple_pregnancy_now)) :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
