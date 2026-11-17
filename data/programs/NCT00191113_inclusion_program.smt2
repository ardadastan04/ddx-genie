;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_has_diagnosis_of_turner_syndrome_now Bool)
(declare-const patient_has_finding_of_pre_pubertal_now Bool)
(declare-const patient_has_finding_of_tanner_stage_i_breast_development_now Bool)
(declare-const patient_body_height_measure_value_recorded_now_withunit_centimeter_per_year Real)
(declare-const patient_body_height_percentile_for_age_and_sex_value_recorded_now_withunit_percent Real)
(declare-const patient_body_height_measurement_duration_available_for_height_velocity_calculation_in_months Real)
(declare-const patient_has_finding_of_decreased_thyroxine_level_now Bool)
(declare-const patient_has_taken_thyroxine_inthehistory@@as_replacement_therapy Bool)
(declare-const patient_has_finding_of_thyroid_function_tests_normal_inthepast6months@@continuous_for_6_months_prior_to_enrollment Bool)
(declare-const patient_has_finding_of_thyroid_function_tests_normal_inthepast6months Bool)
(declare-const patient_has_taken_thyroxine_inthehistory Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_thyroid_function_tests_normal_inthepast6months@@continuous_for_6_months_prior_to_enrollment patient_has_finding_of_thyroid_function_tests_normal_inthepast6months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_taken_thyroxine_inthehistory@@as_replacement_therapy patient_has_taken_thyroxine_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_turner_syndrome_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_pre_pubertal_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_tanner_stage_i_breast_development_now :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (< patient_body_height_measure_value_recorded_now_withunit_centimeter_per_year 6.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_body_height_percentile_for_age_and_sex_value_recorded_now_withunit_percent 10.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_body_height_measurement_duration_available_for_height_velocity_calculation_in_months 6.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (not patient_has_finding_of_decreased_thyroxine_level_now) patient_has_taken_thyroxine_inthehistory@@as_replacement_therapy) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (not patient_has_finding_of_decreased_thyroxine_level_now) patient_has_finding_of_thyroid_function_tests_normal_inthepast6months@@continuous_for_6_months_prior_to_enrollment) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
