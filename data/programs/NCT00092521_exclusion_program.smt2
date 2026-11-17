;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_administration_of_human_papilloma_virus_vaccine_inthehistory Bool)
(declare-const patient_has_finding_of_abnormal_cervical_papanicolaou_smear_inthehistory Bool)
(declare-const patient_has_history_of_abnormal_pap_test Bool)
(declare-const patient_has_history_of_abnormal_pap_test@@strong_clinical_support Bool)
(declare-const patient_has_diagnosis_of_genital_warts_inthehistory Bool)
(declare-const patient_has_history_of_genital_warts Bool)
(declare-const patient_has_history_of_genital_warts@@strong_clinical_support Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_abnormal_cervical_papanicolaou_smear_inthehistory patient_has_history_of_abnormal_pap_test) :named REQ1_AUXILIARY_BRIDGE1))
(assert (! (=> patient_has_history_of_abnormal_pap_test@@strong_clinical_support patient_has_history_of_abnormal_pap_test) :named REQ1_AUXILIARY_BRIDGE2))
(assert (! (=> patient_has_diagnosis_of_genital_warts_inthehistory patient_has_history_of_genital_warts) :named REQ2_AUXILIARY_BRIDGE1))
(assert (! (=> patient_has_history_of_genital_warts@@strong_clinical_support patient_has_history_of_genital_warts) :named REQ2_AUXILIARY_BRIDGE2))

;; Other kept assertions
(assert (! (not patient_has_undergone_administration_of_human_papilloma_virus_vaccine_inthehistory) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_history_of_abnormal_pap_test) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_history_of_genital_warts) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
