;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const duration_of_symptoms_of_acute_pancreatitis_in_hours Real)
(declare-const patient_has_symptoms_of_acute_pancreatitis_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_unable_to_provide_consent_now Bool)

;; Other kept assertions
(assert (! (not (and patient_has_symptoms_of_acute_pancreatitis_now (> duration_of_symptoms_of_acute_pancreatitis_in_hours 72))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_provide_consent_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
