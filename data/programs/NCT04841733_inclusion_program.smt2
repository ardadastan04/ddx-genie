;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_semi_professional_soccer_player Bool)
(declare-const patient_soccer_value_recorded_inthehistory_withunit_minutes Real)
(declare-const patient_experience_of_practicing_soccer_duration_value_in_years Real)
(declare-const patient_has_experience_of_practicing_soccer Bool)

;; Existing auxiliary assertions
(assert (! (=> (>= patient_experience_of_practicing_soccer_duration_value_in_years 5) patient_has_experience_of_practicing_soccer) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! patient_is_semi_professional_soccer_player :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_soccer_value_recorded_inthehistory_withunit_minutes 75.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_experience_of_practicing_soccer_duration_value_in_years 5) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
