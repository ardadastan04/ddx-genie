;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=5 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@confirmed_by_typical_clinical_features_of_fluctuating_muscle_weakness Bool)
(declare-const patient_has_finding_of_muscle_weakness_now Bool)
(declare-const patient_has_finding_of_muscle_weakness_now@@fluctuating Bool)
(declare-const patient_is_exposed_to_acetylcholinesterase_inhibitor_now@@elicits_positive_clinical_response Bool)
(declare-const patient_is_exposed_to_acetylcholine_receptor_antibody_now@@positive_on_testing Bool)
(declare-const patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_now@@positive_on_testing Bool)
(declare-const patient_has_undergone_repetitive_nerve_stimulation_now@@shows_decrement_greater_than_10_percent Bool)
(declare-const patient_has_undergone_single_fiber_emg_now@@shows_increased_jitter Bool)
(declare-const mgfa_clinical_classification_value_now Real)
(declare-const patient_has_mgfa_clinical_classification_now Bool)
(declare-const patient_has_mgfa_clinical_classification_now@@classified_as_class_i_ii_iii_or_iv Bool)
(declare-const myasthenia_gravis_activities_of_daily_living_score_value_recorded_baseline_withunit_points Real)
(declare-const disease_course_duration_from_onset_to_enrollment_value_recorded_now_in_months Real)
(declare-const patient_has_undergone_single_fiber_emg_now Bool)
(declare-const patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_now Bool)
(declare-const patient_is_exposed_to_acetylcholinesterase_inhibitor_now Bool)
(declare-const patient_has_undergone_repetitive_nerve_stimulation_now Bool)
(declare-const patient_is_exposed_to_acetylcholine_receptor_antibody_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@confirmed_by_typical_clinical_features_of_fluctuating_muscle_weakness patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_muscle_weakness_now@@fluctuating patient_has_finding_of_muscle_weakness_now) :named REQ1_AUXILIARY1))
(assert (! (= patient_has_mgfa_clinical_classification_now@@classified_as_class_i_ii_iii_or_iv (and patient_has_mgfa_clinical_classification_now (or (= mgfa_clinical_classification_value_now 1.0) (= mgfa_clinical_classification_value_now 2.0) (= mgfa_clinical_classification_value_now 3.0) (= mgfa_clinical_classification_value_now 4.0)))) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_mgfa_clinical_classification_now@@classified_as_class_i_ii_iii_or_iv patient_has_mgfa_clinical_classification_now) :named REQ2_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_repetitive_nerve_stimulation_now@@shows_decrement_greater_than_10_percent patient_has_undergone_repetitive_nerve_stimulation_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_undergone_single_fiber_emg_now@@shows_increased_jitter patient_has_undergone_single_fiber_emg_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_is_exposed_to_acetylcholine_receptor_antibody_now@@positive_on_testing patient_is_exposed_to_acetylcholine_receptor_antibody_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_is_exposed_to_acetylcholinesterase_inhibitor_now@@elicits_positive_clinical_response patient_is_exposed_to_acetylcholinesterase_inhibitor_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_now@@positive_on_testing patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_diagnosis_of_myasthenia_gravis_now patient_has_diagnosis_of_myasthenia_gravis_now@@confirmed_by_typical_clinical_features_of_fluctuating_muscle_weakness) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_is_exposed_to_acetylcholinesterase_inhibitor_now@@elicits_positive_clinical_response patient_is_exposed_to_acetylcholine_receptor_antibody_now@@positive_on_testing patient_is_exposed_to_muscle_specific_tyrosine_kinase_antibody_now@@positive_on_testing patient_has_undergone_repetitive_nerve_stimulation_now@@shows_decrement_greater_than_10_percent patient_has_undergone_single_fiber_emg_now@@shows_increased_jitter) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_mgfa_clinical_classification_now@@classified_as_class_i_ii_iii_or_iv :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= myasthenia_gravis_activities_of_daily_living_score_value_recorded_baseline_withunit_points 3) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= disease_course_duration_from_onset_to_enrollment_value_recorded_now_in_months 12.0) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
