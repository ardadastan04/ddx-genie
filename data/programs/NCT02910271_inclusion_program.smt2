;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=4
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory Bool)
(declare-const patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory@@diagnosed_before_age_30_years Bool)
(declare-const patient_age_value_recorded_inthehistory_in_years Real)
(declare-const patient_glucose_measurement_plasma_value_recorded_now_withunit_milligrams_per_deciliter Real)
(declare-const patient_glucose_measurement_plasma_value_recorded_now_withunit_milligrams_per_deciliter@@measured_at_2_hours_in_oral_glucose_tolerance_test Bool)
(declare-const patient_glycosylated_hemoglobin_value_recorded_now_withunit_percent Real)
(declare-const patient_glycosylated_hemoglobin_value_recorded_now_withunit_percent@@certified_by_national_glycohemoglobin_standardized_program Bool)
(declare-const patient_glycosylated_hemoglobin_value_recorded_now_withunit_percent@@standardized_according_to_diabetes_control_and_complication_trial Bool)
(declare-const patient_has_diagnosis_of_diabetic_ketoacidosis_now Bool)
(declare-const patient_has_finding_of_hyperglycemia_now@@with_acute_decompensation Bool)
(declare-const patient_has_finding_of_polydipsia_now Bool)
(declare-const patient_has_finding_of_polyuria_now Bool)
(declare-const patient_has_finding_of_unexplained_weight_loss_now Bool)
(declare-const patient_has_undergone_glucose_tolerance_test_now Bool)
(declare-const patient_has_undergone_glucose_tolerance_test_now@@performed_with_75_grams_glucose Bool)
(declare-const patient_plasma_fasting_glucose_measurement_value_recorded_now_withunit_milligrams_per_deciliter Real)
(declare-const patient_plasma_fasting_glucose_measurement_value_recorded_now_withunit_milligrams_per_deciliter@@measured_after_fasting_for_at_least_8_hours Bool)
(declare-const patient_fasting_plasma_glucose_criterion_confirmed Bool)
(declare-const patient_2h_ogtt_plasma_glucose_criterion_confirmed Bool)
(declare-const patient_glycohemoglobin_criterion_confirmed Bool)
(declare-const patient_meets_diabetes_criterion_a_now Bool)
(declare-const patient_meets_diabetes_criterion_b_now Bool)
(declare-const patient_meets_diabetes_criterion_c_now Bool)
(declare-const patient_meets_diabetes_criterion_d_now Bool)
(declare-const patient_meets_any_diabetes_criterion_now Bool)
(declare-const patient_has_undergone_autoantibody_serology_inthehistory_outcome_is_positive Bool)
(declare-const patient_is_exposed_to_islet_cell_cytoplasmic_antibody_inthehistory Bool)
(declare-const patient_is_exposed_to_anti_insulin_antibody_inthehistory Bool)
(declare-const patient_is_exposed_to_glutamic_acid_decarboxylase_antibody_inthehistory Bool)
(declare-const patient_has_finding_of_hyperglycemia_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory@@diagnosed_before_age_30_years patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory) :named REQ0_AUXILIARY0))
(assert (! (=> (< patient_age_value_recorded_inthehistory_in_years 30) patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory@@diagnosed_before_age_30_years) :named REQ0_AUXILIARY1))
(assert (! (= patient_meets_diabetes_criterion_a_now (or (and patient_has_finding_of_polyuria_now patient_has_finding_of_polydipsia_now patient_has_finding_of_unexplained_weight_loss_now (>= patient_glucose_measurement_plasma_value_recorded_now_withunit_milligrams_per_deciliter 200.0)) patient_has_diagnosis_of_diabetic_ketoacidosis_now)) :named REQ1_AUXILIARY0))
(assert (! (= patient_meets_diabetes_criterion_b_now (and (>= patient_plasma_fasting_glucose_measurement_value_recorded_now_withunit_milligrams_per_deciliter 126.0) patient_plasma_fasting_glucose_measurement_value_recorded_now_withunit_milligrams_per_deciliter@@measured_after_fasting_for_at_least_8_hours (or patient_has_finding_of_hyperglycemia_now@@with_acute_decompensation patient_fasting_plasma_glucose_criterion_confirmed))) :named REQ1_AUXILIARY1))
(assert (! (= patient_meets_diabetes_criterion_c_now (and (>= patient_glucose_measurement_plasma_value_recorded_now_withunit_milligrams_per_deciliter 200.0) patient_glucose_measurement_plasma_value_recorded_now_withunit_milligrams_per_deciliter@@measured_at_2_hours_in_oral_glucose_tolerance_test patient_has_undergone_glucose_tolerance_test_now patient_has_undergone_glucose_tolerance_test_now@@performed_with_75_grams_glucose (or patient_has_finding_of_hyperglycemia_now@@with_acute_decompensation patient_2h_ogtt_plasma_glucose_criterion_confirmed))) :named REQ1_AUXILIARY2))
(assert (! (= patient_meets_diabetes_criterion_d_now (and (>= patient_glycosylated_hemoglobin_value_recorded_now_withunit_percent 6.5) patient_glycosylated_hemoglobin_value_recorded_now_withunit_percent@@certified_by_national_glycohemoglobin_standardized_program patient_glycosylated_hemoglobin_value_recorded_now_withunit_percent@@standardized_according_to_diabetes_control_and_complication_trial (or patient_has_finding_of_hyperglycemia_now@@with_acute_decompensation patient_glycohemoglobin_criterion_confirmed))) :named REQ1_AUXILIARY3))
(assert (! (= patient_meets_any_diabetes_criterion_now (or patient_meets_diabetes_criterion_a_now patient_meets_diabetes_criterion_b_now patient_meets_diabetes_criterion_c_now patient_meets_diabetes_criterion_d_now)) :named REQ1_AUXILIARY4))
(assert (! (= patient_has_undergone_autoantibody_serology_inthehistory_outcome_is_positive (or patient_is_exposed_to_islet_cell_cytoplasmic_antibody_inthehistory patient_is_exposed_to_anti_insulin_antibody_inthehistory patient_is_exposed_to_glutamic_acid_decarboxylase_antibody_inthehistory)) :named REQ2_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_hyperglycemia_now@@with_acute_decompensation patient_has_finding_of_hyperglycemia_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_undergone_glucose_tolerance_test_now@@performed_with_75_grams_glucose patient_has_undergone_glucose_tolerance_test_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory@@diagnosed_before_age_30_years :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_meets_any_diabetes_criterion_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_autoantibody_serology_inthehistory_outcome_is_positive :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
