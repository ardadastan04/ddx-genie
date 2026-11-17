;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_cirrhosis_of_liver_now Bool)
(declare-const patient_has_finding_of_hepatobiliary_malignancy_now Bool)
(declare-const patient_has_finding_of_malignant_neoplasm_of_pancreas_now Bool)

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_cirrhosis_of_liver_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hepatobiliary_malignancy_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_malignant_neoplasm_of_pancreas_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
