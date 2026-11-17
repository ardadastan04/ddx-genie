;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=6 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_now Bool)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_now@@primary_diagnosis Bool)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_now@@moderate_severity Bool)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_now@@without_psychotic_features Bool)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_now@@duration_at_least_4_weeks Bool)
(declare-const patient_has_diagnosis_of_severe_major_depression_without_psychotic_features_now Bool)
(declare-const patient_has_diagnosis_of_severe_major_depression_without_psychotic_features_now@@primary_diagnosis Bool)
(declare-const patient_has_diagnosis_of_severe_major_depression_without_psychotic_features_now@@duration_at_least_4_weeks Bool)
(declare-const patient_number_of_previous_major_depressive_disorder_episodes_in_the_history Int)
(declare-const patient_is_adult_now Bool)
(declare-const patient_has_at_least_one_previous_major_depressive_disorder_episode_in_the_history Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_has_childbearing_potential_now Bool)
(declare-const patient_agrees_to_use_protocol_specified_contraception_now Bool)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)
(declare-const patient_has_finding_of_liver_function_tests_within_reference_range_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_at_least_one_previous_major_depressive_disorder_episode_in_the_history (>= patient_number_of_previous_major_depressive_disorder_episodes_in_the_history 1)) :named REQ0_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_major_depressive_disorder_now@@duration_at_least_4_weeks patient_has_diagnosis_of_major_depressive_disorder_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_diagnosis_of_major_depressive_disorder_now@@moderate_severity patient_has_diagnosis_of_major_depressive_disorder_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_diagnosis_of_major_depressive_disorder_now@@primary_diagnosis patient_has_diagnosis_of_major_depressive_disorder_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_diagnosis_of_major_depressive_disorder_now@@without_psychotic_features patient_has_diagnosis_of_major_depressive_disorder_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_has_diagnosis_of_severe_major_depression_without_psychotic_features_now@@duration_at_least_4_weeks patient_has_diagnosis_of_severe_major_depression_without_psychotic_features_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))
(assert (! (=> patient_has_diagnosis_of_severe_major_depression_without_psychotic_features_now@@primary_diagnosis patient_has_diagnosis_of_severe_major_depression_without_psychotic_features_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_5))

;; Other kept assertions
(assert (! (or (and patient_has_diagnosis_of_major_depressive_disorder_now patient_has_diagnosis_of_major_depressive_disorder_now@@primary_diagnosis patient_has_diagnosis_of_major_depressive_disorder_now@@moderate_severity patient_has_diagnosis_of_major_depressive_disorder_now@@without_psychotic_features patient_has_diagnosis_of_major_depressive_disorder_now@@duration_at_least_4_weeks patient_has_at_least_one_previous_major_depressive_disorder_episode_in_the_history) (and patient_has_diagnosis_of_severe_major_depression_without_psychotic_features_now patient_has_diagnosis_of_severe_major_depression_without_psychotic_features_now@@primary_diagnosis patient_has_diagnosis_of_severe_major_depression_without_psychotic_features_now@@duration_at_least_4_weeks patient_has_at_least_one_previous_major_depressive_disorder_episode_in_the_history)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_adult_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_sex_is_male_now (and patient_sex_is_female_now (or (not patient_has_childbearing_potential_now) patient_agrees_to_use_protocol_specified_contraception_now))) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 18.5) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 35.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_liver_function_tests_within_reference_range_now :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
