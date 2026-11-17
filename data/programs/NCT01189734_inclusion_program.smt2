;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_common_bile_duct_calculus_inthehistory Bool)
(declare-const patient_has_diagnosis_of_common_bile_duct_calculus_inthehistory@@diagnosed_preoperatively Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_common_bile_duct_calculus_inthehistory@@diagnosed_preoperatively patient_has_diagnosis_of_common_bile_duct_calculus_inthehistory) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_common_bile_duct_calculus_inthehistory@@diagnosed_preoperatively :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
