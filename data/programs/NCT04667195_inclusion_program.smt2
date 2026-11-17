;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_suspicion_of_acute_pyelonephritis_now Bool)
(declare-const patient_has_suspicion_of_acute_pyelonephritis_now@@assessed_by_receiving_physician Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_suspicion_of_acute_pyelonephritis_now@@assessed_by_receiving_physician patient_has_suspicion_of_acute_pyelonephritis_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_suspicion_of_acute_pyelonephritis_now@@assessed_by_receiving_physician :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
