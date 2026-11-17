;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_fasting_blood_glucose_measurement_value_recorded_now_withunit_g_per_dl Real)

;; Other kept assertions
(assert (! (and (>= patient_age_value_recorded_now_in_years 19) (<= patient_age_value_recorded_now_in_years 80)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_fasting_blood_glucose_measurement_value_recorded_now_withunit_g_per_dl 100.0) (<= patient_fasting_blood_glucose_measurement_value_recorded_now_withunit_g_per_dl 140.0)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
