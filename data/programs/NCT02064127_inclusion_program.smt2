;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_abdominal_pain_now Bool)
(declare-const patient_has_finding_of_abdominal_pain_now@@is_main_complaint Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_abdominal_pain_now@@is_main_complaint patient_has_finding_of_abdominal_pain_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 16.0) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_abdominal_pain_now@@is_main_complaint :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
