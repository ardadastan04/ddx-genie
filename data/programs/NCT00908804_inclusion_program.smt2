;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_suspicion_of_acute_appendicitis_now Bool)
(declare-const patient_can_undergo_laparoscopy_now Bool)
(declare-const patient_age_value_recorded_now_in_years_is_known Bool)
(declare-const patient_has_suspicion_of_acute_appendicitis_now_is_known Bool)
(declare-const patient_can_undergo_laparoscopy_now_is_known Bool)

;; Existing auxiliary assertions
(assert (! patient_age_value_recorded_now_in_years_is_known :named REQ0_AUXILIARY_AGE_KNOWN_REQUIRED))
(assert (! patient_has_suspicion_of_acute_appendicitis_now_is_known :named REQ1_AUXILIARY_SUSPICION_KNOWN_REQUIRED))
(assert (! patient_can_undergo_laparoscopy_now_is_known :named REQ2_AUXILIARY_LAPAROSCOPY_SUITABILITY_KNOWN_REQUIRED))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 15) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_suspicion_of_acute_appendicitis_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_can_undergo_laparoscopy_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
