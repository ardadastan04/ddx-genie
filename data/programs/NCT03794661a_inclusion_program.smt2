;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_according_to_standard_practice Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_parkinson_s_disease_diagnosis_duration_value_recorded_now_withunit_years Real)
(declare-const patient_is_willing_to_maintain_constant_dose_of_anti_parkinsons_disease_medication_prior_to_study_enrollment Bool)
(declare-const patient_is_willing_to_maintain_constant_dose_of_anti_parkinsons_disease_medication_prior_to_study_enrollment@@indicated_as_best_medical_management Bool)
(declare-const patient_is_able_to_comply_with_follow_up_schedule_for_study_duration Bool)
(declare-const patient_has_undergone_deep_brain_stimulation_inthehistory Bool)
(declare-const patient_has_undergone_deep_brain_stimulation_inthehistory@@performed_in_subthalamic_nucleus Bool)
(declare-const patient_has_undergone_deep_brain_stimulation_inthehistory@@performed_with_8_channel_directional_infinity_system Bool)
(declare-const patient_has_undergone_deep_brain_stimulation_inthehistory@@temporalcontext_within12months_prior_to_study_enrollment Bool)
(declare-const patient_has_undergone_deep_brain_stimulation_inthehistory@@programming_settings_stable_for_gte_1_month_prior_to_study_enrollment Bool)
(declare-const programming_settings_stable_duration_prior_to_study_enrollment_in_months Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_according_to_standard_practice patient_has_diagnosis_of_parkinson_s_disease_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_willing_to_maintain_constant_dose_of_anti_parkinsons_disease_medication_prior_to_study_enrollment@@indicated_as_best_medical_management patient_is_willing_to_maintain_constant_dose_of_anti_parkinsons_disease_medication_prior_to_study_enrollment) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_undergone_deep_brain_stimulation_inthehistory@@performed_in_subthalamic_nucleus patient_has_undergone_deep_brain_stimulation_inthehistory) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_undergone_deep_brain_stimulation_inthehistory@@performed_with_8_channel_directional_infinity_system patient_has_undergone_deep_brain_stimulation_inthehistory) :named REQ5_AUXILIARY1))
(assert (! (=> patient_has_undergone_deep_brain_stimulation_inthehistory@@temporalcontext_within12months_prior_to_study_enrollment patient_has_undergone_deep_brain_stimulation_inthehistory) :named REQ5_AUXILIARY2))
(assert (! (= patient_has_undergone_deep_brain_stimulation_inthehistory@@programming_settings_stable_for_gte_1_month_prior_to_study_enrollment (and patient_has_undergone_deep_brain_stimulation_inthehistory (>= programming_settings_stable_duration_prior_to_study_enrollment_in_months 1.0))) :named REQ6_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_deep_brain_stimulation_inthehistory@@programming_settings_stable_for_gte_1_month_prior_to_study_enrollment patient_has_undergone_deep_brain_stimulation_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 80) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_according_to_standard_practice :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_parkinson_s_disease_diagnosis_duration_value_recorded_now_withunit_years 4.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_comply_with_follow_up_schedule_for_study_duration :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and patient_has_undergone_deep_brain_stimulation_inthehistory@@performed_in_subthalamic_nucleus patient_has_undergone_deep_brain_stimulation_inthehistory@@performed_with_8_channel_directional_infinity_system) :named REQ5_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_deep_brain_stimulation_inthehistory@@temporalcontext_within12months_prior_to_study_enrollment :named REQ5_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_deep_brain_stimulation_inthehistory@@programming_settings_stable_for_gte_1_month_prior_to_study_enrollment :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
