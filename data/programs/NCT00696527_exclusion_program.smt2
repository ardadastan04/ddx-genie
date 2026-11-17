;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_malignant_neoplastic_disease_now Bool)
(declare-const patient_has_finding_of_malignant_neoplastic_disease_now@@is_another_malignant_tumor Bool)
(declare-const patient_has_finding_of_malignant_neoplastic_disease_now@@is_in_situ_cervical_carcinoma Bool)
(declare-const patient_has_finding_of_malignant_neoplastic_disease_now@@is_treated_basal_cell_carcinoma Bool)
(declare-const patient_has_diagnosis_of_ductal_carcinoma_in_situ_of_breast_now Bool)
(declare-const patient_has_diagnosis_of_lobular_carcinoma_in_situ_of_breast_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_malignant_neoplastic_disease_now@@is_another_malignant_tumor patient_has_finding_of_malignant_neoplastic_disease_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_malignant_neoplastic_disease_now@@is_in_situ_cervical_carcinoma patient_has_finding_of_malignant_neoplastic_disease_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_malignant_neoplastic_disease_now@@is_treated_basal_cell_carcinoma patient_has_finding_of_malignant_neoplastic_disease_now) :named REQ0_AUXILIARY2))

;; Other kept assertions
(assert (! (not (and patient_has_finding_of_malignant_neoplastic_disease_now@@is_another_malignant_tumor (not (or patient_has_finding_of_malignant_neoplastic_disease_now@@is_in_situ_cervical_carcinoma patient_has_finding_of_malignant_neoplastic_disease_now@@is_treated_basal_cell_carcinoma)))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_ductal_carcinoma_in_situ_of_breast_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_lobular_carcinoma_in_situ_of_breast_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
