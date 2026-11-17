;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_liter Real)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent_predicted Real)
(declare-const patient_forced_vital_capacity_value_recorded_now_withunit_liter Real)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_undergone_post_bronchodilator_spirometry_now Bool)
(declare-const patient_fev1_fvc_ratio_value_recorded_now Real)
(declare-const patient_has_normal_spirometry_now Bool)
(declare-const patient_cigarette_smoking_tobacco_value_recorded_inthehistory_withunit_count Real)

;; Existing auxiliary assertions
(assert (! (= patient_fev1_fvc_ratio_value_recorded_now (/ patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_liter patient_forced_vital_capacity_value_recorded_now_withunit_liter)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_normal_spirometry_now (and patient_has_undergone_post_bronchodilator_spirometry_now (> patient_fev1_fvc_ratio_value_recorded_now 0.70) (>= patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent_predicted 80.0))) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_normal_spirometry_now (not patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now)) :named REQ1_AUXILIARY2))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 40) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 70) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and (not patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now) patient_has_normal_spirometry_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< patient_cigarette_smoking_tobacco_value_recorded_inthehistory_withunit_count 100) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
