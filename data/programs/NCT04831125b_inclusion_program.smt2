;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_cardiac_resynchronization_therapy_now Bool)
(declare-const patient_has_undergone_cardiac_resynchronization_therapy_now@@eligibility_determined_by_acc_aha_hrs_guidelines Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_cardiac_resynchronization_therapy_now@@eligibility_determined_by_acc_aha_hrs_guidelines patient_has_undergone_cardiac_resynchronization_therapy_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_undergone_cardiac_resynchronization_therapy_now@@eligibility_determined_by_acc_aha_hrs_guidelines :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
