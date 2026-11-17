;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_able_to_read_norwegian_now Bool)
(declare-const patient_is_able_to_communicate_in_norwegian_now Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory@@excluding_current_diagnosis_of_early_stage_breast_cancer Bool)
(declare-const patient_has_finding_of_dementia_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory@@excluding_current_diagnosis_of_early_stage_breast_cancer patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_is_able_to_read_norwegian_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_able_to_communicate_in_norwegian_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory@@excluding_current_diagnosis_of_early_stage_breast_cancer) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_dementia_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
