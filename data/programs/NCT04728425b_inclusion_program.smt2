;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@confirmed_by_clinical_criteria_including_fatiguable_weakness Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_serological_testing_for_acetylcholine_receptor_antibodies Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_serological_testing_for_muscle_specific_kinase_antibodies Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_serological_testing_for_anti_low_density_lipoprotein_receptor_related_protein_4_antibodies Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_electrophysiological_testing_with_repetitive_nerve_stimulation Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_electrophysiological_testing_with_single_fiber_electromyography Bool)
(declare-const patient_has_finding_of_mgfa_class_ii_now Bool)
(declare-const patient_has_finding_of_mgfa_class_iii_now Bool)
(declare-const patient_has_finding_of_mgfa_class_iv_now Bool)
(declare-const patient_has_finding_of_moderate_myasthenia_gravis_now Bool)
(declare-const patient_has_finding_of_severe_myasthenia_gravis_now Bool)
(declare-const quantitative_myasthenia_gravis_score_value_recorded_now_withunit_points Real)
(declare-const generalized_myasthenia_gravis_impairment_index_score_value_recorded_now_withunit_points Real)
(declare-const patient_has_finding_of_moderate_myasthenia_gravis_now@@as_defined_by_quantitative_myasthenia_gravis_score_gt_10 Bool)
(declare-const patient_has_finding_of_severe_myasthenia_gravis_now@@as_defined_by_generalized_myasthenia_gravis_impairment_index_score_gt_11 Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@confirmed_by_clinical_criteria_including_fatiguable_weakness patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_serological_testing_for_acetylcholine_receptor_antibodies patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_serological_testing_for_muscle_specific_kinase_antibodies patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_serological_testing_for_anti_low_density_lipoprotein_receptor_related_protein_4_antibodies patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ1_AUXILIARY3))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_electrophysiological_testing_with_repetitive_nerve_stimulation patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ1_AUXILIARY4))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_electrophysiological_testing_with_single_fiber_electromyography patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ1_AUXILIARY5))
(assert (! (= patient_has_finding_of_moderate_myasthenia_gravis_now@@as_defined_by_quantitative_myasthenia_gravis_score_gt_10 (and patient_has_finding_of_moderate_myasthenia_gravis_now (> quantitative_myasthenia_gravis_score_value_recorded_now_withunit_points 10))) :named REQ3_AUXILIARY0))
(assert (! (= patient_has_finding_of_severe_myasthenia_gravis_now@@as_defined_by_generalized_myasthenia_gravis_impairment_index_score_gt_11 (and patient_has_finding_of_severe_myasthenia_gravis_now (> generalized_myasthenia_gravis_impairment_index_score_value_recorded_now_withunit_points 11))) :named REQ3_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_moderate_myasthenia_gravis_now@@as_defined_by_quantitative_myasthenia_gravis_score_gt_10 patient_has_finding_of_moderate_myasthenia_gravis_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_severe_myasthenia_gravis_now@@as_defined_by_generalized_myasthenia_gravis_impairment_index_score_gt_11 patient_has_finding_of_severe_myasthenia_gravis_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_myasthenia_gravis_now@@confirmed_by_clinical_criteria_including_fatiguable_weakness :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_serological_testing_for_acetylcholine_receptor_antibodies patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_serological_testing_for_muscle_specific_kinase_antibodies patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_serological_testing_for_anti_low_density_lipoprotein_receptor_related_protein_4_antibodies patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_electrophysiological_testing_with_repetitive_nerve_stimulation patient_has_diagnosis_of_myasthenia_gravis_now@@supported_by_electrophysiological_testing_with_single_fiber_electromyography) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_mgfa_class_ii_now patient_has_finding_of_mgfa_class_iii_now patient_has_finding_of_mgfa_class_iv_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_moderate_myasthenia_gravis_now@@as_defined_by_quantitative_myasthenia_gravis_score_gt_10 patient_has_finding_of_severe_myasthenia_gravis_now@@as_defined_by_generalized_myasthenia_gravis_impairment_index_score_gt_11) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
