;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_fit_and_well_now Bool)
(declare-const patient_is_adult_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_has_volunteered_to_participate_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter Real)
(declare-const patient_is_willing_to_avoid_pregnancy_by_use_of_diaphragm_with_spermicide_now Bool)
(declare-const patient_has_finding_of_uses_sheath_with_spermicide_now@@initiated_at_least_14_days_before_dosing Bool)
(declare-const patient_has_finding_of_uses_iud_intrauterine_device_contraception_now@@initiated_at_least_4_weeks_prior_to_dosing Bool)
(declare-const patient_has_finding_of_uses_hormonal_contraception_now@@initiated_at_least_4_weeks_prior_to_dosing Bool)
(declare-const patient_is_willing_to_avoid_pregnancy_by_use_of_at_least_one_permitted_method_now Bool)
(declare-const patient_is_considered_reliable Bool)
(declare-const patient_is_capable_of_understanding_responsibility_of_patient Bool)
(declare-const patient_is_capable_of_understanding_role_of_patient_in_study Bool)
(declare-const patient_has_finding_of_uses_sheath_with_spermicide_now Bool)
(declare-const patient_has_finding_of_uses_hormonal_contraception_now Bool)
(declare-const patient_has_finding_of_uses_iud_intrauterine_device_contraception_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_willing_to_avoid_pregnancy_by_use_of_at_least_one_permitted_method_now (or patient_is_willing_to_avoid_pregnancy_by_use_of_diaphragm_with_spermicide_now patient_has_finding_of_uses_sheath_with_spermicide_now@@initiated_at_least_14_days_before_dosing patient_has_finding_of_uses_iud_intrauterine_device_contraception_now@@initiated_at_least_4_weeks_prior_to_dosing patient_has_finding_of_uses_hormonal_contraception_now@@initiated_at_least_4_weeks_prior_to_dosing)) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_uses_hormonal_contraception_now@@initiated_at_least_4_weeks_prior_to_dosing patient_has_finding_of_uses_hormonal_contraception_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_uses_iud_intrauterine_device_contraception_now@@initiated_at_least_4_weeks_prior_to_dosing patient_has_finding_of_uses_iud_intrauterine_device_contraception_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_uses_sheath_with_spermicide_now@@initiated_at_least_14_days_before_dosing patient_has_finding_of_uses_sheath_with_spermicide_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! (or (and patient_has_finding_of_fit_and_well_now patient_is_adult_now patient_sex_is_male_now patient_has_volunteered_to_participate_now) (and patient_has_finding_of_fit_and_well_now patient_is_adult_now patient_sex_is_female_now patient_has_volunteered_to_participate_now)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 45.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 19.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 30.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_sex_is_female_now :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_considered_reliable :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_capable_of_understanding_responsibility_of_patient :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_capable_of_understanding_role_of_patient_in_study :named REQ4_COMPONENT2_OTHER_REQUIREMENTS))
