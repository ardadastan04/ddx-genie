;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_asthma_now Bool)
(declare-const patient_has_previously_participated_in_studies Bool)
(declare-const patient_has_expressed_interest_in_participating_in_studies Bool)

;; Other kept assertions
(assert (! (and patient_has_diagnosis_of_asthma_now (or patient_has_previously_participated_in_studies patient_has_expressed_interest_in_participating_in_studies)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
