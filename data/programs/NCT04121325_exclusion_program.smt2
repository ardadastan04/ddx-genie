;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_able_to_provide_informed_consent_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_active_health_problem_now_that_renders_unable_to_complete_study Bool)

;; Other kept assertions
(assert (! (not patient_is_able_to_provide_informed_consent_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_active_health_problem_now_that_renders_unable_to_complete_study) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
