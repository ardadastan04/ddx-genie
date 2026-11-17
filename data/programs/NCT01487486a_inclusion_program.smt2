;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_is_undergoing_controlled_ovarian_stimulation_now Bool)
(declare-const patient_is_undergoing_transvaginal_oocyte_recovery_now Bool)
(declare-const patient_is_undergoing_ultrasonography_of_uterus_with_saline_infusion_now Bool)
(declare-const patient_is_undergoing_uterine_lavage_now Bool)
(declare-const patient_is_donating_oocytes_now Bool)
(declare-const patient_is_undergoing_transvaginal_oocyte_recovery_now@@indication_is_exclusively_male_factor_infertility_no_female_causes Bool)
(declare-const patient_age_value_recorded_at_time_of_in_vitro_fertilization_in_years Real)
(declare-const anti_mullerian_hormone_value_recorded_now_withunit_nanograms_per_milliliter Real)
(declare-const follicle_stimulating_hormone_value_recorded_day_3_withunit_picograms_per_milliliter Real)
(declare-const patient_has_finding_of_normal_female_reproductive_function_now Bool)
(declare-const patient_has_finding_of_normal_menstrual_cycle_now Bool)
(declare-const patient_has_childbearing_potential_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_transvaginal_oocyte_recovery_now@@indication_is_exclusively_male_factor_infertility_no_female_causes patient_is_undergoing_transvaginal_oocyte_recovery_now) :named REQ2_AUXILIARY0))
(assert (! (= patient_has_finding_of_normal_female_reproductive_function_now (or (< follicle_stimulating_hormone_value_recorded_day_3_withunit_picograms_per_milliliter 8.0) (>= anti_mullerian_hormone_value_recorded_now_withunit_nanograms_per_milliliter 1.0))) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_finding_of_normal_menstrual_cycle_now patient_has_childbearing_potential_now) :named REQ5_AUXILIARY0))

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_undergoing_controlled_ovarian_stimulation_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_undergoing_transvaginal_oocyte_recovery_now :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (and (and patient_is_undergoing_ultrasonography_of_uterus_with_saline_infusion_now patient_is_undergoing_uterine_lavage_now) (or patient_is_donating_oocytes_now patient_is_undergoing_transvaginal_oocyte_recovery_now@@indication_is_exclusively_male_factor_infertility_no_female_causes)) :named REQ0_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (< patient_age_value_recorded_at_time_of_in_vitro_fertilization_in_years 35.0) :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_normal_female_reproductive_function_now :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_normal_menstrual_cycle_now :named REQ5_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
