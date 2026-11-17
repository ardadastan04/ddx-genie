;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_asthma_now Bool)
(declare-const patient_has_diagnosis_of_asthma_now@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_heart_block_now Bool)
(declare-const patient_has_finding_of_heart_failure_now Bool)
(declare-const patient_has_finding_of_heart_block_now@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_heart_failure_now@@strong_clinical_support Bool)
(declare-const patient_has_pacing_device_in_place_now Bool)
(declare-const patient_has_finding_of_cardiac_arrhythmia_now Bool)
(declare-const patient_has_finding_of_cardiac_arrhythmia_now@@strong_clinical_support Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_asthma_now@@strong_clinical_support patient_has_diagnosis_of_asthma_now) :named REQ0_AUXILIARY0_BRIDGE_STRONG_SUPPORT_TO_DIAGNOSIS))
(assert (! (=> patient_has_finding_of_heart_failure_now@@strong_clinical_support patient_has_finding_of_heart_failure_now) :named REQ1_AUXILIARY0_BRIDGE_STRONG_SUPPORT_TO_FINDING_HEART_FAILURE))
(assert (! (=> patient_has_finding_of_heart_block_now@@strong_clinical_support patient_has_finding_of_heart_block_now) :named REQ1_AUXILIARY1_BRIDGE_STRONG_SUPPORT_TO_FINDING_HEART_BLOCK))
(assert (! (=> patient_has_finding_of_cardiac_arrhythmia_now@@strong_clinical_support patient_has_finding_of_cardiac_arrhythmia_now) :named REQ2_AUXILIARY0_BRIDGE_STRONG_SUPPORT_TO_FINDING_ARRHYTHMIA))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_asthma_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or patient_has_finding_of_heart_failure_now patient_has_finding_of_heart_block_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_pacing_device_in_place_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_cardiac_arrhythmia_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
