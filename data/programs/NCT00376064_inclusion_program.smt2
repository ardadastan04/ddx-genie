;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_history_of_surgery_for_pituitary_microadenoma Bool)
(declare-const patient_has_history_of_surgery_for_pituitary_macroadenoma Bool)
(declare-const octreotide_lar_dose_value_recorded_chronic_treatment_with_unit_mg Real)
(declare-const octreotide_lar_treatment_duration_value_recorded_chronic_treatment_with_unit_months Real)
(declare-const patient_has_chronic_treatment_with_octreotide_lar Bool)
(declare-const patient_has_partial_responsiveness_to_octreotide_lar_monotherapy_within_6_months Bool)
(declare-const growth_hormone_value_recorded_during_monotherapy_with_unit_ng_per_ml Real)
(declare-const growth_hormone_value_recorded_pre_monotherapy_with_unit_ng_per_ml Real)
(declare-const insulin_like_growth_factor_1_value_recorded_during_monotherapy_with_unit_ng_per_ml Real)
(declare-const insulin_like_growth_factor_1_value_recorded_pre_monotherapy_with_unit_ng_per_ml Real)
(declare-const patient_growth_hormone_nadir_value_after_75g_ogtt_within_4_weeks_prior_to_visit_1_withunit_micrograms_per_liter Real)
(declare-const patient_has_lack_of_suppression_of_growth_hormone_nadir_after_75g_ogtt_within_4_weeks_prior_to_visit_1 Bool)
(declare-const patient_igf1_value_within_4_weeks_prior_to_visit_1_withunit_micrograms_per_liter Real)
(declare-const patient_igf1_normal_range_adjusted_for_age_and_gender_brabant_2003_withunit_micrograms_per_liter Real)
(declare-const patient_has_acromegaly_symptoms_inadequately_controlled_now_as_judged_by_investigator Bool)
(declare-const patient_has_finding_of_abnormal_human_growth_hormone_now Bool)
(declare-const patient_has_finding_of_abnormal_igf1_value_within_4_weeks_prior_to_visit_1 Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_partial_responsiveness_to_octreotide_lar_monotherapy_within_6_months (and patient_has_chronic_treatment_with_octreotide_lar (>= octreotide_lar_dose_value_recorded_chronic_treatment_with_unit_mg 30.0) (>= octreotide_lar_treatment_duration_value_recorded_chronic_treatment_with_unit_months 6.0) (<= growth_hormone_value_recorded_during_monotherapy_with_unit_ng_per_ml (* 0.75 growth_hormone_value_recorded_pre_monotherapy_with_unit_ng_per_ml)) (<= insulin_like_growth_factor_1_value_recorded_during_monotherapy_with_unit_ng_per_ml (* 0.75 insulin_like_growth_factor_1_value_recorded_pre_monotherapy_with_unit_ng_per_ml)))) :named REQ2_AUXILIARY0))
(assert (! (= patient_has_lack_of_suppression_of_growth_hormone_nadir_after_75g_ogtt_within_4_weeks_prior_to_visit_1 (< patient_growth_hormone_nadir_value_after_75g_ogtt_within_4_weeks_prior_to_visit_1_withunit_micrograms_per_liter 1.0)) :named REQ3_AUXILIARY0))
(assert (! (= patient_has_finding_of_abnormal_igf1_value_within_4_weeks_prior_to_visit_1 (>= patient_igf1_value_within_4_weeks_prior_to_visit_1_withunit_micrograms_per_liter (+ (* 1.10 patient_igf1_normal_range_adjusted_for_age_and_gender_brabant_2003_withunit_micrograms_per_liter)))) :named REQ3_AUXILIARY1))
(assert (! (= patient_has_finding_of_abnormal_human_growth_hormone_now (not patient_has_lack_of_suppression_of_growth_hormone_nadir_after_75g_ogtt_within_4_weeks_prior_to_visit_1)) :named REQ3_AUXILIARY2))

;; Other kept assertions
(assert (! (or patient_sex_is_male_now patient_sex_is_female_now) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_history_of_surgery_for_pituitary_microadenoma patient_has_history_of_surgery_for_pituitary_macroadenoma) :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_chronic_treatment_with_octreotide_lar (= octreotide_lar_dose_value_recorded_chronic_treatment_with_unit_mg 30.0) (>= octreotide_lar_treatment_duration_value_recorded_chronic_treatment_with_unit_months 6.0)) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_partial_responsiveness_to_octreotide_lar_monotherapy_within_6_months :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and patient_has_lack_of_suppression_of_growth_hormone_nadir_after_75g_ogtt_within_4_weeks_prior_to_visit_1 patient_has_finding_of_abnormal_igf1_value_within_4_weeks_prior_to_visit_1) (and patient_has_acromegaly_symptoms_inadequately_controlled_now_as_judged_by_investigator (or patient_has_finding_of_abnormal_human_growth_hormone_now patient_has_finding_of_abnormal_igf1_value_within_4_weeks_prior_to_visit_1))) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
