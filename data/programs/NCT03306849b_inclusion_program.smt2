;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_time_since_menarche_value_recorded_now_in_years Real)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter Real)
(declare-const ovaries_have_good_visibility_on_ultrasound_now Bool)
(declare-const menstrual_cycle_length_value_recorded_now_in_days Real)
(declare-const patient_has_finding_of_irregular_periods_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_irregular_periods_now (> menstrual_cycle_length_value_recorded_now_in_days 35)) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 45) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_time_since_menarche_value_recorded_now_in_years 2.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 18.5) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! ovaries_have_good_visibility_on_ultrasound_now :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_irregular_periods_now :named REQ4_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
