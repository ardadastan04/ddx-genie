;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_retention_of_urine_now Bool)
(declare-const patient_has_diagnosis_of_cerebrovascular_accident_inthehistory Bool)
(declare-const patient_has_diagnosis_of_neurological_disease_ever Bool)
(declare-const patient_has_diagnosis_of_neurological_disease_ever@@relevant Bool)
(declare-const patient_is_undergoing_malignant_neoplasm_of_prostate_now Bool)
(declare-const patient_is_undergoing_malignant_neoplasm_of_urinary_bladder_now Bool)
(declare-const patient_has_undergone_operation_on_prostate_inthehistory Bool)
(declare-const patient_can_undergo_surgical_procedure_now Bool)
(declare-const patient_is_able_to_complete_outcome_assessments Bool)
(declare-const patient_consents_to_random_assignment_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_cerebrovascular_accident_inthehistory patient_has_diagnosis_of_neurological_disease_ever@@relevant) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_neurological_disease_ever@@relevant patient_has_diagnosis_of_neurological_disease_ever) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_retention_of_urine_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_neurological_disease_ever@@relevant) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_malignant_neoplasm_of_prostate_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_malignant_neoplasm_of_urinary_bladder_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_operation_on_prostate_inthehistory) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_can_undergo_surgical_procedure_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_able_to_complete_outcome_assessments) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (not patient_consents_to_random_assignment_now)) :named REQ5_COMPONENT0_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
