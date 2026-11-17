;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_finding_of_sleep_apnea_now Bool)
(declare-const patient_is_receiving_noninvasive_ventilation_at_home_now Bool)
(declare-const patient_is_affiliated_to_french_social_security_now Bool)
(declare-const patient_has_contraindication_to_high_flow_nasal_oxygen_therapy_now Bool)
(declare-const patient_has_contraindication_to_noninvasive_ventilation_now Bool)
(declare-const patient_was_previously_included_in_study Bool)

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_sleep_apnea_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_receiving_noninvasive_ventilation_at_home_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_affiliated_to_french_social_security_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or patient_has_contraindication_to_noninvasive_ventilation_now patient_has_contraindication_to_high_flow_nasal_oxygen_therapy_now)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_was_previously_included_in_study) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
