;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_days Real)
(declare-const patient_has_finding_of_jaundice_now Bool)
(declare-const gestational_age_value_recorded_now_in_weeks Real)

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_days 2.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_days 28.0) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_jaundice_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= gestational_age_value_recorded_now_in_weeks 35.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= gestational_age_value_recorded_now_in_weeks 42.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
