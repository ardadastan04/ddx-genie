;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_consecutive_patient_referred_for_endoscopic_ultrasonography Bool)

;; Other kept assertions
(assert (! patient_is_consecutive_patient_referred_for_endoscopic_ultrasonography :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
