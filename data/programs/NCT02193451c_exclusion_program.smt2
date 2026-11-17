;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_retention_of_urine_now Bool)
(declare-const patient_has_finding_of_retention_of_urine_now@@at_time_of_original_upstream_phase_i_randomisation Bool)
(declare-const patient_has_finding_of_neurological_disease_at_time_of_original_upstream_phase_i_randomisation Bool)
(declare-const patient_has_finding_of_malignant_neoplasm_of_prostate_now@@undergoing_treatment_at_time_of_original_upstream_phase_i_randomisation Bool)
(declare-const patient_has_finding_of_malignant_neoplasm_of_urinary_bladder_now@@undergoing_treatment_at_time_of_original_upstream_phase_i_randomisation Bool)
(declare-const patient_has_undergone_operation_on_prostate_inthehistory Bool)
(declare-const patient_has_undergone_operation_on_prostate_inthehistory@@temporalcontext_prior_to_original_upstream_phase_i_randomisation Bool)
(declare-const patient_is_medically_fit_for_surgery_now Bool)
(declare-const patient_was_able_to_complete_outcome_assessments_now Bool)
(declare-const patient_has_consented_to_random_assignment_to_pathway_at_time_of_original_upstream_phase_1_randomisation Bool)
(declare-const patient_has_finding_of_malignant_neoplasm_of_prostate_now Bool)
(declare-const patient_has_finding_of_malignant_neoplasm_of_urinary_bladder_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_retention_of_urine_now@@at_time_of_original_upstream_phase_i_randomisation patient_has_finding_of_retention_of_urine_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_operation_on_prostate_inthehistory@@temporalcontext_prior_to_original_upstream_phase_i_randomisation patient_has_undergone_operation_on_prostate_inthehistory) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_malignant_neoplasm_of_prostate_now@@undergoing_treatment_at_time_of_original_upstream_phase_i_randomisation patient_has_finding_of_malignant_neoplasm_of_prostate_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_malignant_neoplasm_of_urinary_bladder_now@@undergoing_treatment_at_time_of_original_upstream_phase_i_randomisation patient_has_finding_of_malignant_neoplasm_of_urinary_bladder_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_retention_of_urine_now@@at_time_of_original_upstream_phase_i_randomisation) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_neurological_disease_at_time_of_original_upstream_phase_i_randomisation) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_malignant_neoplasm_of_prostate_now@@undergoing_treatment_at_time_of_original_upstream_phase_i_randomisation) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_malignant_neoplasm_of_urinary_bladder_now@@undergoing_treatment_at_time_of_original_upstream_phase_i_randomisation) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_operation_on_prostate_inthehistory@@temporalcontext_prior_to_original_upstream_phase_i_randomisation) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_is_medically_fit_for_surgery_now)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_was_able_to_complete_outcome_assessments_now)) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_consented_to_random_assignment_to_pathway_at_time_of_original_upstream_phase_1_randomisation) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
