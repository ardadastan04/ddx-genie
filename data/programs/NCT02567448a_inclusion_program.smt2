;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_moderate_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_finding_of_moderate_chronic_obstructive_pulmonary_disease_now@@determined_by_spirometry Bool)
(declare-const patient_has_finding_of_severe_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_finding_of_severe_chronic_obstructive_pulmonary_disease_now@@determined_by_spirometry Bool)
(declare-const patient_post_bronchodilator_fev1_fvc_ratio_value_recorded_now_withunit_ratio Real)
(declare-const patient_post_bronchodilator_fev1_percent_predicted_value_recorded_now_withunit_percent Real)
(declare-const patient_meets_spirometry_criteria_for_moderate_copd_now Bool)
(declare-const patient_meets_spirometry_criteria_for_severe_copd_now Bool)
(declare-const patient_smoking_history_value_recorded_lifetime_withunit_pack_years Real)

;; Existing auxiliary assertions
(assert (! (= patient_meets_spirometry_criteria_for_moderate_copd_now (and (< patient_post_bronchodilator_fev1_fvc_ratio_value_recorded_now_withunit_ratio 0.70) (>= patient_post_bronchodilator_fev1_percent_predicted_value_recorded_now_withunit_percent 50.0) (< patient_post_bronchodilator_fev1_percent_predicted_value_recorded_now_withunit_percent 80.0))) :named REQ1_AUXILIARY0))
(assert (! (= patient_meets_spirometry_criteria_for_severe_copd_now (and (< patient_post_bronchodilator_fev1_fvc_ratio_value_recorded_now_withunit_ratio 0.70) (< patient_post_bronchodilator_fev1_percent_predicted_value_recorded_now_withunit_percent 50.0))) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_moderate_chronic_obstructive_pulmonary_disease_now@@determined_by_spirometry patient_has_finding_of_moderate_chronic_obstructive_pulmonary_disease_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_finding_of_severe_chronic_obstructive_pulmonary_disease_now@@determined_by_spirometry patient_has_finding_of_severe_chronic_obstructive_pulmonary_disease_now) :named REQ1_AUXILIARY3))
(assert (! (= patient_has_finding_of_moderate_chronic_obstructive_pulmonary_disease_now@@determined_by_spirometry patient_meets_spirometry_criteria_for_moderate_copd_now) :named REQ1_AUXILIARY4))
(assert (! (= patient_has_finding_of_severe_chronic_obstructive_pulmonary_disease_now@@determined_by_spirometry patient_meets_spirometry_criteria_for_severe_copd_now) :named REQ1_AUXILIARY5))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 40) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 70) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_moderate_chronic_obstructive_pulmonary_disease_now@@determined_by_spirometry patient_has_finding_of_severe_chronic_obstructive_pulmonary_disease_now@@determined_by_spirometry) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_smoking_history_value_recorded_lifetime_withunit_pack_years 10.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
