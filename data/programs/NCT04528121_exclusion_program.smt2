;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_difficulty_communicating_now Bool)
(declare-const patient_has_finding_of_difficulty_understanding_program_instructions_now Bool)
(declare-const patient_has_finding_of_neurological_deficit_now Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@other_than_remitting_relapsing_multiple_sclerosis Bool)
(declare-const patient_has_finding_of_orthopedic_abnormality_now Bool)
(declare-const patient_has_finding_of_musculoskeletal_complication_now Bool)
(declare-const patient_has_finding_of_musculoskeletal_complication_now@@secondary Bool)
(declare-const patient_has_finding_of_peripheral_vestibular_disease_now Bool)
(declare-const patient_has_finding_of_disease_of_liver_now Bool)
(declare-const patient_has_finding_of_kidney_disease_now Bool)
(declare-const patient_has_finding_of_hemopoietic_disease_now Bool)
(declare-const patient_has_finding_of_disorder_of_thyroid_gland_now Bool)
(declare-const patient_has_finding_of_disorder_of_cardiovascular_system_now Bool)
(declare-const patient_has_finding_of_impaired_cognition_now Bool)
(declare-const patient_has_finding_of_hearing_loss_now Bool)
(declare-const patient_has_finding_of_epilepsy_now Bool)
(declare-const patient_has_finding_of_electroencephalogram_abnormal_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@other_than_remitting_relapsing_multiple_sclerosis patient_has_finding_of_neurological_deficit_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_musculoskeletal_complication_now@@secondary patient_has_finding_of_musculoskeletal_complication_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not (or patient_has_finding_of_difficulty_communicating_now patient_has_finding_of_difficulty_understanding_program_instructions_now)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_neurological_deficit_now@@other_than_remitting_relapsing_multiple_sclerosis) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_orthopedic_abnormality_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_musculoskeletal_complication_now@@secondary) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_peripheral_vestibular_disease_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disease_of_liver_now) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_kidney_disease_now) :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hemopoietic_disease_now) :named REQ3_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_thyroid_gland_now) :named REQ3_COMPONENT4_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_cardiovascular_system_now) :named REQ3_COMPONENT5_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_impaired_cognition_now) :named REQ3_COMPONENT6_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hearing_loss_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_epilepsy_now) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_electroencephalogram_abnormal_now) :named REQ4_COMPONENT2_OTHER_REQUIREMENTS))
