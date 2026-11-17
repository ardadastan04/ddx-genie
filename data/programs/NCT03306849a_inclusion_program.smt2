;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_years_since_menarche_value_recorded_in_years Real)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter Real)
(declare-const ovaries_have_good_visibility_on_ultrasound_examination_now Bool)
(declare-const patient_has_undergone_ultrasonography_now Bool)
(declare-const patient_measure_of_duration_of_menstrual_cycle_value_recorded_now_withunit_days Real)
(declare-const patient_has_regular_menstrual_cycles_now Bool)

;; Existing auxiliary assertions
(assert (! (=> ovaries_have_good_visibility_on_ultrasound_examination_now patient_has_undergone_ultrasonography_now) :named REQ3_AUXILIARY0))
(assert (! (= patient_has_regular_menstrual_cycles_now (and (>= patient_measure_of_duration_of_menstrual_cycle_value_recorded_now_withunit_days 21.0) (<= patient_measure_of_duration_of_menstrual_cycle_value_recorded_now_withunit_days 35.0))) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 45) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_years_since_menarche_value_recorded_in_years 2.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 18.5) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! ovaries_have_good_visibility_on_ultrasound_examination_now :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_regular_menstrual_cycles_now :named REQ4_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
