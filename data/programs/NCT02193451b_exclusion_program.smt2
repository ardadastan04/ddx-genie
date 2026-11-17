;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_retention_of_urine_now Bool)
(declare-const patient_has_finding_of_retention_of_urine_now@@at_the_time_of_long_term_follow_up Bool)
(declare-const patient_has_diagnosis_of_neurological_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_neurological_disease_inthehistory@@would_preclude_completion_of_long_term_follow_up_assessments Bool)
(declare-const patient_has_diagnosis_of_cerebrovascular_accident_inthehistory Bool)
(declare-const patient_has_diagnosis_of_cerebrovascular_accident_inthehistory@@would_preclude_completion_of_long_term_follow_up_assessments Bool)
(declare-const patient_is_undergoing_malignant_neoplasm_of_prostate_now Bool)
(declare-const patient_is_undergoing_malignant_neoplasm_of_prostate_now@@at_the_time_of_long_term_follow_up Bool)
(declare-const patient_is_undergoing_malignant_neoplasm_of_urinary_bladder_now Bool)
(declare-const patient_is_undergoing_malignant_neoplasm_of_urinary_bladder_now@@at_the_time_of_long_term_follow_up Bool)
(declare-const patient_has_undergone_operation_on_prostate_inthehistory Bool)
(declare-const patient_has_undergone_operation_on_prostate_inthehistory@@temporalcontext_prior_to_enrollment_in_upstream_phase_i Bool)
(declare-const patient_is_unable_to_complete_outcome_assessments_at_time_of_long_term_follow_up Bool)
(declare-const patient_has_provided_consent_for_random_assignment_during_upstream_phase_i_enrollment Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_retention_of_urine_now@@at_the_time_of_long_term_follow_up patient_has_finding_of_retention_of_urine_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_cerebrovascular_accident_inthehistory@@would_preclude_completion_of_long_term_follow_up_assessments patient_has_diagnosis_of_neurological_disease_inthehistory@@would_preclude_completion_of_long_term_follow_up_assessments) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_neurological_disease_inthehistory@@would_preclude_completion_of_long_term_follow_up_assessments patient_has_diagnosis_of_neurological_disease_inthehistory) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_cerebrovascular_accident_inthehistory@@would_preclude_completion_of_long_term_follow_up_assessments patient_has_diagnosis_of_cerebrovascular_accident_inthehistory) :named REQ1_AUXILIARY2))
(assert (! (=> patient_is_undergoing_malignant_neoplasm_of_prostate_now@@at_the_time_of_long_term_follow_up patient_is_undergoing_malignant_neoplasm_of_prostate_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_undergoing_malignant_neoplasm_of_urinary_bladder_now@@at_the_time_of_long_term_follow_up patient_is_undergoing_malignant_neoplasm_of_urinary_bladder_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_undergone_operation_on_prostate_inthehistory@@temporalcontext_prior_to_enrollment_in_upstream_phase_i patient_has_undergone_operation_on_prostate_inthehistory) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_retention_of_urine_now@@at_the_time_of_long_term_follow_up) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_neurological_disease_inthehistory@@would_preclude_completion_of_long_term_follow_up_assessments) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_malignant_neoplasm_of_prostate_now@@at_the_time_of_long_term_follow_up) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_malignant_neoplasm_of_urinary_bladder_now@@at_the_time_of_long_term_follow_up) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_operation_on_prostate_inthehistory@@temporalcontext_prior_to_enrollment_in_upstream_phase_i) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_complete_outcome_assessments_at_time_of_long_term_follow_up) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_has_provided_consent_for_random_assignment_during_upstream_phase_i_enrollment)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
