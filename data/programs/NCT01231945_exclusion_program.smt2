;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_married_now Bool)
(declare-const patient_has_finding_of_sexual_intercourse_finding_inthehistory Bool)
(declare-const patient_has_undergone_total_hysterectomy_inthehistory Bool)
(declare-const patient_has_diagnosis_of_malignant_tumor_of_cervix_inthehistory Bool)
(declare-const patient_can_undergo_screening_for_malignant_neoplasm_of_cervix_now Bool)
(declare-const patient_can_undergo_screening_for_malignant_neoplasm_of_cervix_now@@routine Bool)
(declare-const patient_can_provide_informed_consent_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_pregnant_inthepast1months Bool)
(declare-const patient_has_finding_of_finding_of_menstrual_bleeding_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_can_undergo_screening_for_malignant_neoplasm_of_cervix_now@@routine patient_can_undergo_screening_for_malignant_neoplasm_of_cervix_now) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! (not (and (not patient_is_married_now) (not patient_has_finding_of_sexual_intercourse_finding_inthehistory))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_total_hysterectomy_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_malignant_tumor_of_cervix_inthehistory) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_can_undergo_screening_for_malignant_neoplasm_of_cervix_now@@routine :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_can_provide_informed_consent_now :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_inthepast1months) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_finding_of_menstrual_bleeding_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
