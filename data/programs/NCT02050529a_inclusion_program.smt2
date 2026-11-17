;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_postpartum_now Bool)
(declare-const patients_systolic_blood_pressure_value_recorded_after_15_minutes_rest_repeat_measurement_withunit_mm_hg Real)
(declare-const patients_diastolic_blood_pressure_value_recorded_after_15_minutes_rest_repeat_measurement_withunit_mm_hg Real)
(declare-const patient_meets_blood_pressure_criteria_now Bool)
(declare-const pregnancy_gestational_age_value_recorded_prior_to_20_weeks_in_weeks Real)
(declare-const pregnancy_gestational_age_value_recorded_at_first_prenatal_visit_in_weeks Real)
(declare-const pregnancy_gestational_age_value_recorded_by_last_menstrual_period_in_weeks Real)
(declare-const patient_has_pregnancy_greater_than_28_weeks_now Bool)
(declare-const patient_has_diagnosis_of_pregnancy_induced_hypertension_now Bool)
(declare-const patient_has_diagnosis_of_severe_pre_eclampsia_now Bool)
(declare-const patient_has_diagnosis_of_hypertensive_disorder_now@@chronic Bool)
(declare-const patient_has_diagnosis_of_pre_eclampsia_added_to_pre_existing_hypertension_now Bool)
(declare-const patient_has_diagnosis_of_eclampsia_now Bool)
(declare-const patient_has_diagnosis_of_hypertensive_disorder_now@@unclassified Bool)
(declare-const patient_has_eligible_hypertensive_diagnosis_now Bool)
(declare-const hours_since_delivery_value_recorded_now_withunit_hr Real)
(declare-const patient_has_diagnosis_of_gestational_hypertension_now Bool)
(declare-const patient_has_diagnosis_of_hypertensive_disorder_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_meets_blood_pressure_criteria_now (or (>= patients_systolic_blood_pressure_value_recorded_after_15_minutes_rest_repeat_measurement_withunit_mm_hg 160.0) (>= patients_diastolic_blood_pressure_value_recorded_after_15_minutes_rest_repeat_measurement_withunit_mm_hg 110.0))) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_pregnancy_greater_than_28_weeks_now (or (> pregnancy_gestational_age_value_recorded_prior_to_20_weeks_in_weeks 28) (> pregnancy_gestational_age_value_recorded_at_first_prenatal_visit_in_weeks 28) (> pregnancy_gestational_age_value_recorded_by_last_menstrual_period_in_weeks 28))) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_eligible_hypertensive_diagnosis_now (or patient_has_diagnosis_of_pregnancy_induced_hypertension_now patient_has_diagnosis_of_severe_pre_eclampsia_now patient_has_diagnosis_of_hypertensive_disorder_now@@chronic patient_has_diagnosis_of_pre_eclampsia_added_to_pre_existing_hypertension_now patient_has_diagnosis_of_eclampsia_now patient_has_diagnosis_of_hypertensive_disorder_now@@unclassified)) :named REQ1_AUXILIARY1))
(assert (! (= patient_has_eligible_hypertensive_diagnosis_now (or patient_has_diagnosis_of_gestational_hypertension_now patient_has_diagnosis_of_severe_pre_eclampsia_now patient_has_diagnosis_of_hypertensive_disorder_now@@chronic patient_has_diagnosis_of_pre_eclampsia_added_to_pre_existing_hypertension_now patient_has_diagnosis_of_eclampsia_now patient_has_diagnosis_of_hypertensive_disorder_now@@unclassified)) :named REQ2_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_hypertensive_disorder_now@@chronic patient_has_diagnosis_of_hypertensive_disorder_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_diagnosis_of_hypertensive_disorder_now@@unclassified patient_has_diagnosis_of_hypertensive_disorder_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (or patient_is_pregnant_now patient_is_postpartum_now) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_meets_blood_pressure_criteria_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (=> patient_is_pregnant_now patient_has_pregnancy_greater_than_28_weeks_now) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_eligible_hypertensive_diagnosis_now :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (=> patient_is_postpartum_now (<= hours_since_delivery_value_recorded_now_withunit_hr 72.0)) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (=> patient_is_postpartum_now (>= hours_since_delivery_value_recorded_now_withunit_hr 0.0)) :named REQ2_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_eligible_hypertensive_diagnosis_now :named REQ2_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! true :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
