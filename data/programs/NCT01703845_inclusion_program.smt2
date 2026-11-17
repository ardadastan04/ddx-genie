;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_relatively_stable_airway_obstruction_now Bool)
(declare-const patient_fev1_after_bronchodilation_value_recorded_now_withunit_percent_predicted Real)
(declare-const patient_fev1_to_fvc_ratio_after_bronchodilation_value_recorded_now_withunit_percent Real)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_nationality_is_japanese_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_smoker_value_recorded_inthehistory_withunit_pack_years Real)

;; Other kept assertions
(assert (! patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_relatively_stable_airway_obstruction_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_fev1_after_bronchodilation_value_recorded_now_withunit_percent_predicted 30.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (< patient_fev1_after_bronchodilation_value_recorded_now_withunit_percent_predicted 80.0) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (< patient_fev1_to_fvc_ratio_after_bronchodilation_value_recorded_now_withunit_percent 70.0) :named REQ1_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (or (and patient_sex_is_male_now patient_nationality_is_japanese_now) (and patient_sex_is_female_now patient_nationality_is_japanese_now (>= patient_age_value_recorded_now_in_years 40.0))) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_smoker_value_recorded_inthehistory_withunit_pack_years 10.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
