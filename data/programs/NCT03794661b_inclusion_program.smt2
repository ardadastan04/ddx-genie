;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_essential_tremor_inthehistory Bool)
(declare-const patient_has_diagnosis_of_essential_tremor_inthehistory@@diagnosed_according_to_standard_practice Bool)
(declare-const duration_of_essential_tremor_diagnosis_value_recorded_in_years Real)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast1months Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast1months@@indicated_as_best_medical_management_for_anti_tremor Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast1months@@maintained_at_constant_dose_for_entire_window Bool)
(declare-const patient_is_able_to_comply_with_follow_up_schedule_for_length_of_study Bool)
(declare-const patient_has_undergone_deep_brain_stimulation_inthepast12months Bool)
(declare-const patient_has_undergone_deep_brain_stimulation_inthepast12months@@used_8_channel_directional_infinity_system Bool)
(declare-const patient_has_undergone_deep_brain_stimulation_inthepast12months@@performed_in_ventral_intermediate_nucleus_of_thalamus Bool)
(declare-const time_since_implantation_of_8_channel_directional_infinity_deep_brain_stimulation_system_in_ventral_intermediate_nucleus_of_thalamus_in_months Real)
(declare-const patient_is_undergoing_deep_brain_stimulation_now Bool)
(declare-const patient_is_undergoing_deep_brain_stimulation_now@@stable_programming_settings_for_at_least_1_month_prior_to_enrollment Bool)
(declare-const programming_settings_stability_duration_prior_to_study_enrollment_in_months Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_essential_tremor_inthehistory@@diagnosed_according_to_standard_practice patient_has_diagnosis_of_essential_tremor_inthehistory) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_inthepast1months@@indicated_as_best_medical_management_for_anti_tremor patient_is_exposed_to_drug_or_medicament_inthepast1months) :named REQ3_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_inthepast1months@@maintained_at_constant_dose_for_entire_window patient_is_exposed_to_drug_or_medicament_inthepast1months) :named REQ3_AUXILIARY1))
(assert (! (=> patient_has_undergone_deep_brain_stimulation_inthepast12months@@used_8_channel_directional_infinity_system patient_has_undergone_deep_brain_stimulation_inthepast12months) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_undergone_deep_brain_stimulation_inthepast12months@@performed_in_ventral_intermediate_nucleus_of_thalamus patient_has_undergone_deep_brain_stimulation_inthepast12months) :named REQ5_AUXILIARY1))
(assert (! (= patient_has_undergone_deep_brain_stimulation_inthepast12months (<= time_since_implantation_of_8_channel_directional_infinity_deep_brain_stimulation_system_in_ventral_intermediate_nucleus_of_thalamus_in_months 12.0)) :named REQ5_AUXILIARY2))
(assert (! (=> patient_is_undergoing_deep_brain_stimulation_now@@stable_programming_settings_for_at_least_1_month_prior_to_enrollment patient_is_undergoing_deep_brain_stimulation_now) :named REQ6_AUXILIARY0))
(assert (! (= patient_is_undergoing_deep_brain_stimulation_now@@stable_programming_settings_for_at_least_1_month_prior_to_enrollment (and patient_is_undergoing_deep_brain_stimulation_now (>= programming_settings_stability_duration_prior_to_study_enrollment_in_months 1.0))) :named REQ6_AUXILIARY1))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 80) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_essential_tremor_inthehistory@@diagnosed_according_to_standard_practice :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= duration_of_essential_tremor_diagnosis_value_recorded_in_years 4) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_comply_with_follow_up_schedule_for_length_of_study :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and patient_has_undergone_deep_brain_stimulation_inthepast12months@@used_8_channel_directional_infinity_system patient_has_undergone_deep_brain_stimulation_inthepast12months@@performed_in_ventral_intermediate_nucleus_of_thalamus patient_has_undergone_deep_brain_stimulation_inthepast12months) :named REQ5_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_undergoing_deep_brain_stimulation_now@@stable_programming_settings_for_at_least_1_month_prior_to_enrollment :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
