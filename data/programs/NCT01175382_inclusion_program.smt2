;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_community_dwelling_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_reports_urgency_now Bool)
(declare-const patient_reports_urgency_now@@patient_reported Bool)
(declare-const number_of_voids_per_24_hour_day_on_average_recorded_on_7_day_baseline_bladder_diary_value_withunit_per_24_hour_day Real)
(declare-const number_of_voids_per_24_hour_day_on_average_recorded_on_7_day_baseline_bladder_diary_value_withunit_per_24_hour_day@@patient_reported Bool)
(declare-const patient_has_undergone_urinary_frequency_volume_chart_now Bool)
(declare-const patient_has_undergone_urinary_frequency_volume_chart_now@@baseline_7_day Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_reports_urgency_now@@patient_reported patient_reports_urgency_now) :named REQ2_AUXILIARY0))
(assert (! (=> number_of_voids_per_24_hour_day_on_average_recorded_on_7_day_baseline_bladder_diary_value_withunit_per_24_hour_day@@patient_reported (>= number_of_voids_per_24_hour_day_on_average_recorded_on_7_day_baseline_bladder_diary_value_withunit_per_24_hour_day 0)) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_undergone_urinary_frequency_volume_chart_now@@baseline_7_day patient_has_undergone_urinary_frequency_volume_chart_now) :named REQ2_AUXILIARY2))

;; Other kept assertions
(assert (! (and patient_is_community_dwelling_now patient_sex_is_male_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 40.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_reports_urgency_now@@patient_reported :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and number_of_voids_per_24_hour_day_on_average_recorded_on_7_day_baseline_bladder_diary_value_withunit_per_24_hour_day@@patient_reported (>= number_of_voids_per_24_hour_day_on_average_recorded_on_7_day_baseline_bladder_diary_value_withunit_per_24_hour_day 9.0)) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
