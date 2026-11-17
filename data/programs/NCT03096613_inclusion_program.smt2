;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=3
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_systolic_heart_failure_now Bool)
(declare-const patient_has_finding_of_nyha_class_ii_now Bool)
(declare-const patient_has_finding_of_nyha_class_iii_now Bool)
(declare-const patient_left_ventricular_ejection_fraction_value_recorded_now_withunit_percent Real)
(declare-const patient_left_ventricular_ejection_fraction_value_recorded_now_withunit_percent@@measured_by_echocardiography Bool)
(declare-const patient_left_ventricular_ejection_fraction_value_recorded_now_withunit_percent@@measured_during_screening Bool)
(declare-const patient_left_ventricular_ejection_fraction_value_recorded_now_withunit_percent@@measured_during_randomization Bool)
(declare-const patient_has_finding_of_subclinical_hypothyroidism_now Bool)
(declare-const thyroid_stimulating_hormone_value_recorded_now_withunit_miu_per_l Real)
(declare-const thyroid_stimulating_hormone_upper_limit_of_normal_now_withunit_miu_per_l Real)
(declare-const free_thyroxine_value_recorded_now_withunit_ng_per_dl Real)
(declare-const free_thyroxine_reference_range_lower_bound_now_withunit_ng_per_dl Real)
(declare-const free_thyroxine_reference_range_upper_bound_now_withunit_ng_per_dl Real)
(declare-const patient_has_undergone_cardiac_failure_therapy_inthehistory Bool)
(declare-const patient_has_undergone_cardiac_failure_therapy_inthehistory@@duration_at_least_2_weeks Bool)
(declare-const patient_has_undergone_cardiac_failure_therapy_inthehistory@@reached_target_or_maximum_tolerable_dose Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_subclinical_hypothyroidism_now (and (>= thyroid_stimulating_hormone_value_recorded_now_withunit_miu_per_l thyroid_stimulating_hormone_upper_limit_of_normal_now_withunit_miu_per_l) (<= thyroid_stimulating_hormone_value_recorded_now_withunit_miu_per_l 10.0) (>= free_thyroxine_value_recorded_now_withunit_ng_per_dl free_thyroxine_reference_range_lower_bound_now_withunit_ng_per_dl) (<= free_thyroxine_value_recorded_now_withunit_ng_per_dl free_thyroxine_reference_range_upper_bound_now_withunit_ng_per_dl))) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_undergone_cardiac_failure_therapy_inthehistory@@duration_at_least_2_weeks patient_has_undergone_cardiac_failure_therapy_inthehistory) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_undergone_cardiac_failure_therapy_inthehistory@@reached_target_or_maximum_tolerable_dose patient_has_undergone_cardiac_failure_therapy_inthehistory) :named REQ4_AUXILIARY1))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_systolic_heart_failure_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_finding_of_nyha_class_ii_now patient_has_finding_of_nyha_class_iii_now) :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_left_ventricular_ejection_fraction_value_recorded_now_withunit_percent@@measured_by_echocardiography patient_left_ventricular_ejection_fraction_value_recorded_now_withunit_percent@@measured_during_screening (< patient_left_ventricular_ejection_fraction_value_recorded_now_withunit_percent 40.0)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_left_ventricular_ejection_fraction_value_recorded_now_withunit_percent@@measured_by_echocardiography patient_left_ventricular_ejection_fraction_value_recorded_now_withunit_percent@@measured_during_randomization (< patient_left_ventricular_ejection_fraction_value_recorded_now_withunit_percent 40.0)) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_subclinical_hypothyroidism_now :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_cardiac_failure_therapy_inthehistory@@duration_at_least_2_weeks :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_cardiac_failure_therapy_inthehistory@@reached_target_or_maximum_tolerable_dose :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
