;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)
(declare-const patient_has_finding_of_lipid_level_finding_now Bool)
(declare-const patient_total_cholesterol_measurement_value_recorded_now_withunit_g_per_dl Real)
(declare-const patient_low_density_lipoprotein_cholesterol_measurement_value_recorded_now_withunit_g_per_dl Real)
(declare-const patient_high_density_lipoprotein_cholesterol_measurement_value_recorded_now_withunit_g_per_dl Real)
(declare-const patient_triglycerides_measurement_value_recorded_now_withunit_g_per_dl Real)
(declare-const patient_has_finding_of_lipid_level_finding_now@@total_cholesterol_high Bool)
(declare-const patient_has_finding_of_lipid_level_finding_now@@ldl_cholesterol_high Bool)
(declare-const patient_has_finding_of_lipid_level_finding_now@@hdl_cholesterol_low Bool)
(declare-const patient_has_finding_of_lipid_level_finding_now@@triglycerides_in_range Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_lipid_level_finding_now@@total_cholesterol_high (>= patient_total_cholesterol_measurement_value_recorded_now_withunit_g_per_dl 200.0)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_finding_of_lipid_level_finding_now@@ldl_cholesterol_high (>= patient_low_density_lipoprotein_cholesterol_measurement_value_recorded_now_withunit_g_per_dl 175.0)) :named REQ1_AUXILIARY1))
(assert (! (= patient_has_finding_of_lipid_level_finding_now@@hdl_cholesterol_low (<= patient_high_density_lipoprotein_cholesterol_measurement_value_recorded_now_withunit_g_per_dl 50.0)) :named REQ1_AUXILIARY2))
(assert (! (= patient_has_finding_of_lipid_level_finding_now@@triglycerides_in_range (and (>= patient_triglycerides_measurement_value_recorded_now_withunit_g_per_dl 150.0) (<= patient_triglycerides_measurement_value_recorded_now_withunit_g_per_dl 400.0))) :named REQ1_AUXILIARY3))
(assert (! (=> patient_has_finding_of_lipid_level_finding_now@@total_cholesterol_high patient_has_finding_of_lipid_level_finding_now) :named REQ1_AUXILIARY4))
(assert (! (=> patient_has_finding_of_lipid_level_finding_now@@ldl_cholesterol_high patient_has_finding_of_lipid_level_finding_now) :named REQ1_AUXILIARY5))
(assert (! (=> patient_has_finding_of_lipid_level_finding_now@@hdl_cholesterol_low patient_has_finding_of_lipid_level_finding_now) :named REQ1_AUXILIARY6))
(assert (! (=> patient_has_finding_of_lipid_level_finding_now@@triglycerides_in_range patient_has_finding_of_lipid_level_finding_now) :named REQ1_AUXILIARY7))

;; Other kept assertions
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 27) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 34.9) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_finding_of_lipid_level_finding_now@@total_cholesterol_high patient_has_finding_of_lipid_level_finding_now@@ldl_cholesterol_high patient_has_finding_of_lipid_level_finding_now@@hdl_cholesterol_low patient_has_finding_of_lipid_level_finding_now@@triglycerides_in_range) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_sex_is_female_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ2_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (<= patient_age_value_recorded_now_in_years 60) :named REQ2_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
