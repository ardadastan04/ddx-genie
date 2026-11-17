;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_disorder_of_immune_function_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_immune_function_now@@excluding_myasthenia_gravis_and_thymoma Bool)
(declare-const patient_has_diagnosis_of_multiple_sclerosis_now Bool)
(declare-const patient_has_diagnosis_of_rheumatoid_arthritis_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_diagnosis_of_rheumatoid_arthritis_now patient_has_diagnosis_of_multiple_sclerosis_now) patient_has_diagnosis_of_disorder_of_immune_function_now@@excluding_myasthenia_gravis_and_thymoma) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_disorder_of_immune_function_now@@excluding_myasthenia_gravis_and_thymoma patient_has_diagnosis_of_disorder_of_immune_function_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_disorder_of_immune_function_now@@excluding_myasthenia_gravis_and_thymoma) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
