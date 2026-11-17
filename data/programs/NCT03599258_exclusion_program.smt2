;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_meets_all_inclusion_criteria Bool)

;; Other kept assertions
(assert (! (not (not patient_meets_all_inclusion_criteria)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
