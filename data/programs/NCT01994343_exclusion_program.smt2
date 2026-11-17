;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_pain_value_recorded_now_withunit_months Real)
(declare-const patient_is_pregnant_inthepast12months Bool)

;; Other kept assertions
(assert (! (not (< patient_pain_value_recorded_now_withunit_months 6)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_inthepast12months) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
