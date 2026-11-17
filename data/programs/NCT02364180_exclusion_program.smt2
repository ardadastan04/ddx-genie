;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_taking_pyridostigmine_now Bool)
(declare-const patient_is_taking_pyridostigmine_now@@for_treatment_of_myasthenia_gravis Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_taking_pyridostigmine_now@@for_treatment_of_myasthenia_gravis patient_is_taking_pyridostigmine_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_is_taking_pyridostigmine_now@@for_treatment_of_myasthenia_gravis) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
