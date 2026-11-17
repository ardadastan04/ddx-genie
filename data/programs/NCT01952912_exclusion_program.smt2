;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_disorder_of_lung_now Bool)
(declare-const patient_has_finding_of_disorder_of_lung_now@@severe Bool)
(declare-const patient_has_finding_of_heart_disease_now Bool)
(declare-const patient_has_finding_of_heart_disease_now@@severe Bool)
(declare-const patient_has_finding_of_blood_coagulation_disorder_now Bool)
(declare-const patient_has_finding_of_neurogenic_urinary_bladder_now Bool)
(declare-const patient_has_finding_of_urinary_bladder_stone_now Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplasm_of_urinary_bladder_now Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplasm_of_prostate_now Bool)
(declare-const patient_has_diagnosis_of_urethral_stricture_now Bool)
(declare-const patient_has_undergone_operation_on_prostate_inthehistory Bool)
(declare-const patient_has_undergone_operation_on_urethra_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_disorder_of_lung_now@@severe patient_has_finding_of_disorder_of_lung_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_heart_disease_now@@severe patient_has_finding_of_heart_disease_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_disorder_of_lung_now@@severe) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_heart_disease_now@@severe) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_blood_coagulation_disorder_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_neurogenic_urinary_bladder_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_urinary_bladder_stone_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_malignant_neoplasm_of_urinary_bladder_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_malignant_neoplasm_of_prostate_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_urethral_stricture_now) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_operation_on_prostate_inthehistory) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_operation_on_urethra_inthehistory) :named REQ7_COMPONENT1_OTHER_REQUIREMENTS))
