;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=1 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_able_to_read_danish_now Bool)
(declare-const patient_is_able_to_read_english_now Bool)
(declare-const patient_is_able_to_understand_danish_now Bool)
(declare-const patient_is_able_to_understand_english_now Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@classified_as_i_iv_on_mgfa_clinical_classification Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@mild Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@moderate Bool)
(declare-const patient_is_exposed_to_acetylcholine_receptor_antibody_inthehistory Bool)
(declare-const patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_inthehistory Bool)
(declare-const patient_has_undergone_repetitive_nerve_stimulation_inthehistory_outcome_is_abnormal Bool)
(declare-const patient_has_undergone_single_fiber_emg_inthehistory_outcome_is_abnormal Bool)
(declare-const patient_has_finding_of_single_muscle_fiber_jitter_inthehistory Bool)
(declare-const patient_is_exposed_to_acetylcholinesterase_inhibitor_inthehistory@@symptom_improvement_with_acetylcholinesterase_inhibitor Bool)
(declare-const patient_is_on_oral_corticosteroids_now Bool)
(declare-const oral_corticosteroid_dose_is_stable_for_1_month_prior_to_inclusion Bool)
(declare-const patient_is_exposed_to_acetylcholinesterase_inhibitor_now Bool)
(declare-const patient_is_exposed_to_acetylcholinesterase_inhibitor_now@@dose_stable_for_2_weeks_prior_to_inclusion Bool)
(declare-const patient_is_exposed_to_acetylcholinesterase_inhibitor_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@classified_as_i_iv_on_mgfa_clinical_classification patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@mild patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@moderate patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ2_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_exposed_to_acetylcholinesterase_inhibitor_inthehistory@@symptom_improvement_with_acetylcholinesterase_inhibitor patient_is_exposed_to_acetylcholinesterase_inhibitor_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_is_exposed_to_acetylcholinesterase_inhibitor_now@@dose_stable_for_2_weeks_prior_to_inclusion patient_is_exposed_to_acetylcholinesterase_inhibitor_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (or patient_is_able_to_read_danish_now patient_is_able_to_read_english_now patient_is_able_to_understand_danish_now patient_is_able_to_understand_english_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and patient_has_diagnosis_of_myasthenia_gravis_now@@mild patient_has_diagnosis_of_myasthenia_gravis_now@@classified_as_i_iv_on_mgfa_clinical_classification) (and patient_has_diagnosis_of_myasthenia_gravis_now@@moderate patient_has_diagnosis_of_myasthenia_gravis_now@@classified_as_i_iv_on_mgfa_clinical_classification)) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_is_exposed_to_acetylcholine_receptor_antibody_inthehistory patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_inthehistory patient_has_undergone_repetitive_nerve_stimulation_inthehistory_outcome_is_abnormal patient_has_undergone_single_fiber_emg_inthehistory_outcome_is_abnormal patient_has_finding_of_single_muscle_fiber_jitter_inthehistory patient_is_exposed_to_acetylcholinesterase_inhibitor_inthehistory@@symptom_improvement_with_acetylcholinesterase_inhibitor) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (not patient_is_on_oral_corticosteroids_now) oral_corticosteroid_dose_is_stable_for_1_month_prior_to_inclusion) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
