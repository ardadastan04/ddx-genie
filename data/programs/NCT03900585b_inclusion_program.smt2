;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=4 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_able_to_read_danish_now Bool)
(declare-const patient_is_able_to_read_english_now Bool)
(declare-const patient_is_able_to_understand_danish_now Bool)
(declare-const patient_is_able_to_understand_english_now Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@severity_mild Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@severity_moderate Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@mgfa_class_i_iv Bool)
(declare-const patient_is_exposed_to_acetylcholine_receptor_antibody_inthehistory@@positive Bool)
(declare-const patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_inthehistory@@positive Bool)
(declare-const patient_has_undergone_repetitive_nerve_stimulation_inthehistory_outcome_is_abnormal@@performed_on_electromyography Bool)
(declare-const patient_has_undergone_single_fiber_emg_inthehistory_outcome_is_abnormal@@shows_conduction_block_or_jitter Bool)
(declare-const patient_has_clinical_history Bool)
(declare-const patient_has_symptom_improvement_with_acetylcholinesterase_inhibitors Bool)
(declare-const patient_is_undergoing_oral_steroid_therapy_now Bool)
(declare-const patient_is_undergoing_oral_steroid_therapy_now@@dose_stable_for_at_least_1_month_prior_to_inclusion Bool)
(declare-const patient_is_exposed_to_acetylcholinesterase_inhibitor_now Bool)
(declare-const patient_is_exposed_to_acetylcholinesterase_inhibitor_now@@dose_stable_for_2_weeks_prior_to_inclusion Bool)
(declare-const patient_is_exposed_to_acetylcholine_receptor_antibody_inthehistory Bool)
(declare-const patient_has_undergone_single_fiber_emg_inthehistory_outcome_is_abnormal Bool)
(declare-const patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_inthehistory Bool)
(declare-const patient_has_undergone_repetitive_nerve_stimulation_inthehistory_outcome_is_abnormal Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@severity_mild patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@severity_moderate patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@mgfa_class_i_iv patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ2_AUXILIARY2))
(assert (! (=> patient_is_undergoing_oral_steroid_therapy_now@@dose_stable_for_at_least_1_month_prior_to_inclusion patient_is_undergoing_oral_steroid_therapy_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_acetylcholinesterase_inhibitor_now@@dose_stable_for_2_weeks_prior_to_inclusion patient_is_exposed_to_acetylcholinesterase_inhibitor_now) :named REQ5_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_repetitive_nerve_stimulation_inthehistory_outcome_is_abnormal@@performed_on_electromyography patient_has_undergone_repetitive_nerve_stimulation_inthehistory_outcome_is_abnormal) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_undergone_single_fiber_emg_inthehistory_outcome_is_abnormal@@shows_conduction_block_or_jitter patient_has_undergone_single_fiber_emg_inthehistory_outcome_is_abnormal) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_is_exposed_to_acetylcholine_receptor_antibody_inthehistory@@positive patient_is_exposed_to_acetylcholine_receptor_antibody_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_inthehistory@@positive patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))

;; Other kept assertions
(assert (! (or patient_is_able_to_read_danish_now patient_is_able_to_read_english_now patient_is_able_to_understand_danish_now patient_is_able_to_understand_english_now) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (and patient_has_diagnosis_of_myasthenia_gravis_now@@severity_mild patient_has_diagnosis_of_myasthenia_gravis_now@@mgfa_class_i_iv) (and patient_has_diagnosis_of_myasthenia_gravis_now@@severity_moderate patient_has_diagnosis_of_myasthenia_gravis_now@@mgfa_class_i_iv)) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_is_exposed_to_acetylcholine_receptor_antibody_inthehistory@@positive patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_inthehistory@@positive patient_has_undergone_repetitive_nerve_stimulation_inthehistory_outcome_is_abnormal@@performed_on_electromyography patient_has_undergone_single_fiber_emg_inthehistory_outcome_is_abnormal@@shows_conduction_block_or_jitter (and patient_has_clinical_history patient_has_symptom_improvement_with_acetylcholinesterase_inhibitors)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (not patient_is_undergoing_oral_steroid_therapy_now) patient_is_undergoing_oral_steroid_therapy_now@@dose_stable_for_at_least_1_month_prior_to_inclusion) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
