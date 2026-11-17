;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now Bool)
(declare-const patient_has_diagnosis_of_overlap_syndrome_now Bool)
(declare-const patient_is_receiving_non_invasive_ventilation_now Bool)
(declare-const patient_has_finding_of_malignant_neoplastic_disease_progression_now Bool)
(declare-const patient_is_unable_to_complete_questionnaires Bool)
(declare-const patient_is_able_to_attend_outpatient_clinic Bool)

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_overlap_syndrome_now) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_receiving_non_invasive_ventilation_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_malignant_neoplastic_disease_progression_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_complete_questionnaires) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_able_to_attend_outpatient_clinic) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
