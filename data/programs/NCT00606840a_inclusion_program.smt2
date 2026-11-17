;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_age_value_recorded_now_in_years_is_known Bool)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter Real)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter_is_known Bool)
(declare-const patient_is_interested_in_preventing_weight_gain Bool)
(declare-const patient_is_interested_in_preventing_weight_gain_is_known Bool)

;; Existing auxiliary assertions
(assert (! patient_age_value_recorded_now_in_years_is_known :named REQ0_AUXILIARY_AGE_VALUE_MUST_BE_KNOWN))
(assert (! patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter_is_known :named REQ1_AUXILIARY_BMI_VALUE_MUST_BE_KNOWN))
(assert (! patient_is_interested_in_preventing_weight_gain_is_known :named REQ2_AUXILIARY_INTEREST_STATUS_MUST_BE_KNOWN))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (<= patient_age_value_recorded_now_in_years 35) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 23.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 30.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_interested_in_preventing_weight_gain :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
