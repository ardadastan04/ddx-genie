;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@diagnosis_supported_by_serological_or_electrophysiological_testing Bool)
(declare-const patient_has_undergone_acetylcholine_receptor_antibody_testing_ever Bool)
(declare-const patient_has_undergone_muscle_specific_kinase_antibody_testing_ever Bool)
(declare-const patient_has_undergone_anti_low_density_lipoprotein_receptor_related_protein_4_antibody_testing_ever Bool)
(declare-const patient_has_undergone_repetitive_nerve_stimulation_testing_ever Bool)
(declare-const patient_has_undergone_single_fiber_electromyography_testing_ever Bool)
(declare-const patient_has_finding_of_mgfa_class_ii_now Bool)
(declare-const patient_has_finding_of_mgfa_class_iii_now Bool)
(declare-const patient_has_finding_of_mgfa_class_iv_now Bool)
(declare-const quantitative_myasthenia_gravis_score_value_recorded_now_withunit_points Real)
(declare-const generalized_myasthenia_gravis_impairment_index_score_value_recorded_now_withunit_points Real)
(declare-const patient_has_moderate_myasthenia_gravis_now Bool)
(declare-const patient_has_severe_myasthenia_gravis_now Bool)
(declare-const patient_is_eligible_by_myasthenia_gravis_severity_now Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_diagnosis_of_myasthenia_gravis_now@@diagnosis_supported_by_serological_or_electrophysiological_testing (or patient_has_undergone_acetylcholine_receptor_antibody_testing_ever patient_has_undergone_muscle_specific_kinase_antibody_testing_ever patient_has_undergone_anti_low_density_lipoprotein_receptor_related_protein_4_antibody_testing_ever patient_has_undergone_repetitive_nerve_stimulation_testing_ever patient_has_undergone_single_fiber_electromyography_testing_ever)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_moderate_myasthenia_gravis_now (> quantitative_myasthenia_gravis_score_value_recorded_now_withunit_points 10)) :named REQ3_AUXILIARY0))
(assert (! (= patient_has_severe_myasthenia_gravis_now (> generalized_myasthenia_gravis_impairment_index_score_value_recorded_now_withunit_points 11)) :named REQ3_AUXILIARY1))
(assert (! (= patient_is_eligible_by_myasthenia_gravis_severity_now (or patient_has_moderate_myasthenia_gravis_now patient_has_severe_myasthenia_gravis_now)) :named REQ3_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@diagnosis_supported_by_serological_or_electrophysiological_testing patient_has_diagnosis_of_myasthenia_gravis_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_myasthenia_gravis_now@@diagnosis_supported_by_serological_or_electrophysiological_testing :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_mgfa_class_ii_now patient_has_finding_of_mgfa_class_iii_now patient_has_finding_of_mgfa_class_iv_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_eligible_by_myasthenia_gravis_severity_now :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
