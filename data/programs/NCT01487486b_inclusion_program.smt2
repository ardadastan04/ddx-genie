;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_is_undergoing_controlled_ovarian_stimulation_now Bool)
(declare-const patient_is_undergoing_transvaginal_oocyte_recovery_now Bool)
(declare-const patient_is_undergoing_ultrasonography_of_uterus_with_saline_infusion_now Bool)
(declare-const patient_is_undergoing_uterine_lavage_now Bool)
(declare-const patient_is_undergoing_uterine_lavage_now@@collected_during_ultrasonography_of_uterus_with_saline_infusion Bool)
(declare-const patient_age_value_recorded_at_time_of_in_vitro_fertilization_in_years Real)
(declare-const patient_is_younger_than_35_years_old_at_time_of_in_vitro_fertilization Bool)
(declare-const patient_has_finding_of_normal_ovarian_function_now Bool)
(declare-const patient_pituitary_follicle_stimulating_hormone_value_recorded_now_withunit_pg_per_ml Real)
(declare-const patient_pituitary_follicle_stimulating_hormone_value_recorded_now_withunit_pg_per_ml@@measured_on_day_3 Bool)
(declare-const patient_mullerian_regression_factor_value_recorded_now_withunit_ng_per_ml Real)
(declare-const patient_has_diagnosis_of_polycystic_ovary_syndrome_now Bool)
(declare-const patient_has_diagnosis_of_polycystic_ovary_syndrome_now@@diagnosed_by_rotterdam_criteria Bool)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_uterine_lavage_now@@collected_during_ultrasonography_of_uterus_with_saline_infusion patient_is_undergoing_uterine_lavage_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_undergoing_uterine_lavage_now@@collected_during_ultrasonography_of_uterus_with_saline_infusion patient_is_undergoing_ultrasonography_of_uterus_with_saline_infusion_now) :named REQ0_AUXILIARY1))
(assert (! (= patient_is_younger_than_35_years_old_at_time_of_in_vitro_fertilization (< patient_age_value_recorded_at_time_of_in_vitro_fertilization_in_years 35)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_finding_of_normal_ovarian_function_now (or (and patient_pituitary_follicle_stimulating_hormone_value_recorded_now_withunit_pg_per_ml@@measured_on_day_3 (< patient_pituitary_follicle_stimulating_hormone_value_recorded_now_withunit_pg_per_ml 8.0)) (>= patient_mullerian_regression_factor_value_recorded_now_withunit_ng_per_ml 1.0))) :named REQ2_AUXILIARY0))
(assert (! (=> patient_pituitary_follicle_stimulating_hormone_value_recorded_now_withunit_pg_per_ml@@measured_on_day_3 true) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_polycystic_ovary_syndrome_now@@diagnosed_by_rotterdam_criteria patient_has_diagnosis_of_polycystic_ovary_syndrome_now) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_undergoing_controlled_ovarian_stimulation_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_undergoing_transvaginal_oocyte_recovery_now :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_is_undergoing_uterine_lavage_now@@collected_during_ultrasonography_of_uterus_with_saline_infusion :named REQ0_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! patient_is_younger_than_35_years_old_at_time_of_in_vitro_fertilization :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_normal_ovarian_function_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_polycystic_ovary_syndrome_now@@diagnosed_by_rotterdam_criteria :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 25.0) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
