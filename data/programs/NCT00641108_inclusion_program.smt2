;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_now Bool)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_now@@diagnosed_according_to_dsm_iv Bool)
(declare-const patient_is_exposed_to_psychotropic_agent_inthehistory Bool)
(declare-const patient_is_exposed_to_psychotropic_agent_inthehistory@@temporalcontext_more_than_6_months_before_study_entry Bool)
(declare-const patient_is_exposed_to_psychotropic_agent_inthehistory@@temporalcontext_within_6_months_before_study_entry Bool)
(declare-const patient_ham_d_hamilton_rating_scale_for_depression_score_value_recorded_now_withunit_score Real)
(declare-const patient_ham_d_hamilton_rating_scale_for_depression_score_value_recorded_now_withunit_score@@is_recorded Bool)
(declare-const patient_has_childbearing_potential_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const pregnancy_test_result_value_recorded_within_48_hours_of_scanning_in_milliunits_per_milliliter@@is_negative Bool)
(declare-const patient_is_woman_of_childbearing_age_now Bool)
(declare-const pregnancy_test_performed_within_48_hours_of_scanning_now Bool)
(declare-const pregnancy_test_result_value_recorded_within_48_hours_of_scanning_in_milliunits_per_milliliter Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_major_depressive_disorder_now@@diagnosed_according_to_dsm_iv patient_has_diagnosis_of_major_depressive_disorder_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_psychotropic_agent_inthehistory@@temporalcontext_more_than_6_months_before_study_entry patient_is_exposed_to_psychotropic_agent_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_psychotropic_agent_inthehistory@@temporalcontext_within_6_months_before_study_entry patient_is_exposed_to_psychotropic_agent_inthehistory) :named REQ1_AUXILIARY1))
(assert (! (= patient_is_woman_of_childbearing_age_now (and patient_sex_is_female_now patient_has_childbearing_potential_now)) :named REQ3_AUXILIARY0))
(assert (! (=> pregnancy_test_result_value_recorded_within_48_hours_of_scanning_in_milliunits_per_milliliter@@is_negative pregnancy_test_performed_within_48_hours_of_scanning_now) :named REQ3_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> pregnancy_test_result_value_recorded_within_48_hours_of_scanning_in_milliunits_per_milliliter@@is_negative pregnancy_test_result_value_recorded_within_48_hours_of_scanning_in_milliunits_per_milliliter) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_major_depressive_disorder_now@@diagnosed_according_to_dsm_iv :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (not patient_is_exposed_to_psychotropic_agent_inthehistory) patient_is_exposed_to_psychotropic_agent_inthehistory@@temporalcontext_more_than_6_months_before_study_entry) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_is_exposed_to_psychotropic_agent_inthehistory@@temporalcontext_within_6_months_before_study_entry) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_ham_d_hamilton_rating_scale_for_depression_score_value_recorded_now_withunit_score 16) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_ham_d_hamilton_rating_scale_for_depression_score_value_recorded_now_withunit_score@@is_recorded :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! true :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (=> patient_is_woman_of_childbearing_age_now (and pregnancy_test_performed_within_48_hours_of_scanning_now pregnancy_test_result_value_recorded_within_48_hours_of_scanning_in_milliunits_per_milliliter@@is_negative)) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
