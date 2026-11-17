;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_thyroid_stimulating_hormone_cec28a_value_recorded_now_withunit_milli_international_units_per_liter Real)
(declare-const patient_thyroid_stimulating_hormone_cec28a_value_recorded_now_withunit_milli_international_units_per_liter@@measured_as_outpatient Bool)
(declare-const patient_has_ability_to_provide_informed_consent_now Bool)

;; Other kept assertions
(assert (! (or (and patient_sex_is_male_now (>= patient_age_value_recorded_now_in_years 70.0)) (and patient_sex_is_female_now (>= patient_age_value_recorded_now_in_years 70.0))) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= patient_thyroid_stimulating_hormone_cec28a_value_recorded_now_withunit_milli_international_units_per_liter 4.5) patient_thyroid_stimulating_hormone_cec28a_value_recorded_now_withunit_milli_international_units_per_liter@@measured_as_outpatient) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (<= patient_thyroid_stimulating_hormone_cec28a_value_recorded_now_withunit_milli_international_units_per_liter 19.9) patient_thyroid_stimulating_hormone_cec28a_value_recorded_now_withunit_milli_international_units_per_liter@@measured_as_outpatient) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_ability_to_provide_informed_consent_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
