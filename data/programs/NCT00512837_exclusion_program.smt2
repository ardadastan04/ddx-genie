;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_adequate_command_of_english_language_now Bool)
(declare-const patient_possesses_mobile_phone_now Bool)

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 12)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and (not patient_possesses_mobile_phone_now) (not patient_has_adequate_command_of_english_language_now))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
