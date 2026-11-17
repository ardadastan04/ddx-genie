;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_renal_hypertension_now Bool)
(declare-const patient_mini_cog_test_score_value_recorded_now_withunit_score Real)

;; Other kept assertions
(assert (! (not patient_has_finding_of_renal_hypertension_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_mini_cog_test_score_value_recorded_now_withunit_score 3)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
