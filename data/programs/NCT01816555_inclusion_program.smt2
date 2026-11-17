;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_infiltrating_duct_carcinoma_of_breast_now Bool)
(declare-const patient_has_diagnosis_of_infiltrating_duct_carcinoma_of_breast_now@@newly_diagnosed Bool)
(declare-const patient_has_diagnosis_of_infiltrating_duct_carcinoma_of_breast_now@@stage_i_or_stage_ii Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory Bool)
(declare-const patient_has_undergone_radiotherapy_inthehistory Bool)
(declare-const southwest_oncology_group_performance_status_value_now_withunit_none Real)
(declare-const patient_hemoglobin_concentration_dipstick_finding_value_recorded_now_withunit_grams_per_deciliter Real)
(declare-const patient_white_blood_cell_count_value_recorded_now_withunit_cells_per_microliter Real)
(declare-const patient_platelet_count_finding_value_recorded_now_withunit_cells_per_microliter Real)
(declare-const patient_bilirubin_level_finding_value_recorded_now_withunit_milligrams_per_deciliter Real)
(declare-const patient_aspartate_aminotransferase_value_recorded_now_withunit_units_per_liter Real)
(declare-const patient_aspartate_aminotransferase_upper_limit_of_normal_value_now_withunit_units_per_liter Real)
(declare-const patient_creatinine_level_finding_value_recorded_now_withunit_milligrams_per_deciliter Real)
(declare-const patient_creatinine_renal_clearance_value_recorded_now_withunit_milliliters_per_minute Real)
(declare-const patient_has_adequate_organ_function_now Bool)
(declare-const serum_calcium_phosphate_product_value_recorded_withunit_mg2_dl2 Real)
(declare-const patient_has_recovered_from_prior_surgery Bool)
(declare-const patient_is_willing_to_use_contraception_now Bool)
(declare-const patient_is_willing_to_use_contraception_now@@contraception_is_appropriate Bool)
(declare-const patient_is_exposed_to_cholecalciferol_now Bool)
(declare-const patient_is_exposed_to_cholecalciferol_now@@standard_of_care_maintenance_dose Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_infiltrating_duct_carcinoma_of_breast_now@@newly_diagnosed patient_has_diagnosis_of_infiltrating_duct_carcinoma_of_breast_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_infiltrating_duct_carcinoma_of_breast_now@@stage_i_or_stage_ii patient_has_diagnosis_of_infiltrating_duct_carcinoma_of_breast_now) :named REQ1_AUXILIARY1))
(assert (! (= patient_has_adequate_organ_function_now (and (> patient_hemoglobin_concentration_dipstick_finding_value_recorded_now_withunit_grams_per_deciliter 8.0) (> patient_white_blood_cell_count_value_recorded_now_withunit_cells_per_microliter 3500.0) (> patient_platelet_count_finding_value_recorded_now_withunit_cells_per_microliter 100000.0) (< patient_bilirubin_level_finding_value_recorded_now_withunit_milligrams_per_deciliter 2.0) (< patient_aspartate_aminotransferase_value_recorded_now_withunit_units_per_liter (* 4.0 patient_aspartate_aminotransferase_upper_limit_of_normal_value_now_withunit_units_per_liter)) (or (< patient_creatinine_level_finding_value_recorded_now_withunit_milligrams_per_deciliter 2.0) (> patient_creatinine_renal_clearance_value_recorded_now_withunit_milliliters_per_minute 50.0)))) :named REQ4_AUXILIARY0))
(assert (! (=> patient_is_willing_to_use_contraception_now@@contraception_is_appropriate patient_is_willing_to_use_contraception_now) :named REQ7_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_cholecalciferol_now@@standard_of_care_maintenance_dose patient_is_exposed_to_cholecalciferol_now) :named REQ8_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_diagnosis_of_infiltrating_duct_carcinoma_of_breast_now@@newly_diagnosed patient_has_diagnosis_of_infiltrating_duct_carcinoma_of_breast_now@@stage_i_or_stage_ii) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_surgical_procedure_inthehistory :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_radiotherapy_inthehistory :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or (= southwest_oncology_group_performance_status_value_now_withunit_none 0) (= southwest_oncology_group_performance_status_value_now_withunit_none 1) (= southwest_oncology_group_performance_status_value_now_withunit_none 2)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_adequate_organ_function_now :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< serum_calcium_phosphate_product_value_recorded_withunit_mg2_dl2 70) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_recovered_from_prior_surgery :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
