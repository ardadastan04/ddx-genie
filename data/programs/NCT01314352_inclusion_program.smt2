;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=9 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_healthy_adult_man_now@@volunteers_to_participate Bool)
(declare-const patient_is_healthy_adult_woman_now@@volunteers_to_participate Bool)
(declare-const patient_is_normal_adult_man_now@@volunteers_to_participate Bool)
(declare-const patient_is_normal_adult_woman_now@@volunteers_to_participate Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)
(declare-const patient_has_finding_of_sexual_intercourse_finding_now@@with_nonsterile_male_partner Bool)
(declare-const patient_has_finding_of_uses_diaphragm_with_spermicide_now@@initiated_at_least_14_days_before_dosing Bool)
(declare-const patient_has_finding_of_uses_sheath_with_spermicide_now@@initiated_at_least_14_days_before_dosing Bool)
(declare-const patient_has_finding_of_uses_intrauterine_contraceptive_device_now@@initiated_at_least_4_weeks_prior_to_dosing Bool)
(declare-const patient_has_finding_of_uses_hormonal_contraceptives_now@@initiated_at_least_4_weeks_prior_to_dosing Bool)
(declare-const patient_is_willing_to_avoid_pregnancy_by_abstinence_or_contraception_now Bool)
(declare-const patient_is_willing_to_avoid_pregnancy_by_abstinence_now Bool)
(declare-const patient_is_willing_to_avoid_pregnancy_by_contraception_now Bool)
(declare-const patient_is_considered_reliable_now Bool)
(declare-const patient_is_capable_of_understanding_responsibility_now Bool)
(declare-const patient_is_capable_of_understanding_role_in_study_now Bool)
(declare-const patient_has_finding_of_uses_diaphragm_with_spermicide_now Bool)
(declare-const patient_has_finding_of_sexual_intercourse_finding_now Bool)
(declare-const patient_is_healthy_adult_woman_now Bool)
(declare-const patient_is_normal_adult_man_now Bool)
(declare-const patient_is_normal_adult_woman_now Bool)
(declare-const patient_has_finding_of_uses_hormonal_contraceptives_now Bool)
(declare-const patient_has_finding_of_uses_intrauterine_contraceptive_device_now Bool)
(declare-const patient_has_finding_of_uses_sheath_with_spermicide_now Bool)
(declare-const patient_is_healthy_adult_man_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_willing_to_avoid_pregnancy_by_abstinence_now (not patient_has_finding_of_sexual_intercourse_finding_now@@with_nonsterile_male_partner)) :named REQ3_AUXILIARY0))
(assert (! (= patient_is_willing_to_avoid_pregnancy_by_contraception_now (or patient_has_finding_of_uses_diaphragm_with_spermicide_now@@initiated_at_least_14_days_before_dosing patient_has_finding_of_uses_sheath_with_spermicide_now@@initiated_at_least_14_days_before_dosing patient_has_finding_of_uses_intrauterine_contraceptive_device_now@@initiated_at_least_4_weeks_prior_to_dosing patient_has_finding_of_uses_hormonal_contraceptives_now@@initiated_at_least_4_weeks_prior_to_dosing)) :named REQ3_AUXILIARY1))
(assert (! (= patient_is_willing_to_avoid_pregnancy_by_abstinence_or_contraception_now (or patient_is_willing_to_avoid_pregnancy_by_abstinence_now patient_is_willing_to_avoid_pregnancy_by_contraception_now)) :named REQ3_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_sexual_intercourse_finding_now@@with_nonsterile_male_partner patient_has_finding_of_sexual_intercourse_finding_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_uses_diaphragm_with_spermicide_now@@initiated_at_least_14_days_before_dosing patient_has_finding_of_uses_diaphragm_with_spermicide_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_uses_hormonal_contraceptives_now@@initiated_at_least_4_weeks_prior_to_dosing patient_has_finding_of_uses_hormonal_contraceptives_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_finding_of_uses_intrauterine_contraceptive_device_now@@initiated_at_least_4_weeks_prior_to_dosing patient_has_finding_of_uses_intrauterine_contraceptive_device_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_has_finding_of_uses_sheath_with_spermicide_now@@initiated_at_least_14_days_before_dosing patient_has_finding_of_uses_sheath_with_spermicide_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))
(assert (! (=> patient_is_healthy_adult_man_now@@volunteers_to_participate patient_is_healthy_adult_man_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_5))
(assert (! (=> patient_is_healthy_adult_woman_now@@volunteers_to_participate patient_is_healthy_adult_woman_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_6))
(assert (! (=> patient_is_normal_adult_man_now@@volunteers_to_participate patient_is_normal_adult_man_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_7))
(assert (! (=> patient_is_normal_adult_woman_now@@volunteers_to_participate patient_is_normal_adult_woman_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_8))

;; Other kept assertions
(assert (! (and (or patient_is_healthy_adult_man_now@@volunteers_to_participate patient_is_healthy_adult_woman_now@@volunteers_to_participate) (or patient_is_normal_adult_man_now@@volunteers_to_participate patient_is_normal_adult_woman_now@@volunteers_to_participate)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 45) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 19.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 30.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_considered_reliable_now :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_capable_of_understanding_responsibility_now :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_capable_of_understanding_role_in_study_now :named REQ4_COMPONENT2_OTHER_REQUIREMENTS))
