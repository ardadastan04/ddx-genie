;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@stable Bool)
(declare-const patient_has_finding_of_hypoxemia_now Bool)
(declare-const patient_has_finding_of_hypoxemia_now@@chronic_resting Bool)
(declare-const patient_is_exposed_to_oxygen_now Bool)
(declare-const patient_is_exposed_to_oxygen_now@@active_prescription Bool)
(declare-const patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast30days Bool)
(declare-const patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast30days@@inpatient_setting Bool)
(declare-const patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast30days@@outpatient_setting Bool)
(declare-const patient_smoker_value_recorded_inthehistory_withunit_pack_years Real)
(declare-const patient_oxygen_saturation_measurement_value_recorded_now_withunit_percent Real)
(declare-const patient_oxygen_saturation_measurement_value_recorded_now_withunit_percent@@measured_at_rest Bool)
(declare-const patient_oxygen_saturation_measurement_value_recorded_now_withunit_percent@@measured_on_room_air Bool)
(declare-const patient_forced_expiratory_volume_in_one_second_to_forced_vital_capacity_ratio_value_recorded_inthehistory_withunit_ratio Real)
(declare-const patient_has_finding_of_pulmonary_emphysema_inthehistory Bool)
(declare-const patient_has_finding_of_pulmonary_emphysema_inthehistory@@evidence_on_computed_tomography_scan Bool)
(declare-const patient_has_spirometry_consistent_with_copd_inthehistory Bool)
(declare-const patient_has_ability_and_willingness_to_participate_in_virtual_video_visits_with_study_staff_using_va_approved_software Bool)
(declare-const patient_has_ability_to_participate_in_virtual_video_visits_with_study_staff_using_va_approved_software Bool)
(declare-const patient_has_willingness_to_participate_in_virtual_video_visits_with_study_staff_using_va_approved_software Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@stable patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_hypoxemia_now@@chronic_resting patient_has_finding_of_hypoxemia_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_is_exposed_to_oxygen_now@@active_prescription patient_is_exposed_to_oxygen_now) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast30days@@inpatient_setting patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast30days) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast30days@@outpatient_setting patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast30days) :named REQ3_AUXILIARY1))
(assert (! (= patient_has_spirometry_consistent_with_copd_inthehistory (< patient_forced_expiratory_volume_in_one_second_to_forced_vital_capacity_ratio_value_recorded_inthehistory_withunit_ratio 0.70)) :named REQ6_AUXILIARY0))
(assert (! (=> patient_has_finding_of_pulmonary_emphysema_inthehistory@@evidence_on_computed_tomography_scan patient_has_finding_of_pulmonary_emphysema_inthehistory) :named REQ6_AUXILIARY1))
(assert (! (= patient_has_ability_and_willingness_to_participate_in_virtual_video_visits_with_study_staff_using_va_approved_software (and patient_has_ability_to_participate_in_virtual_video_visits_with_study_staff_using_va_approved_software patient_has_willingness_to_participate_in_virtual_video_visits_with_study_staff_using_va_approved_software)) :named REQ8_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 40.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@stable :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hypoxemia_now@@chronic_resting) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_exposed_to_oxygen_now@@active_prescription :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (or (not patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast30days@@inpatient_setting) (not patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast30days@@outpatient_setting)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_smoker_value_recorded_inthehistory_withunit_pack_years 10) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (> patient_oxygen_saturation_measurement_value_recorded_now_withunit_percent 88.0) patient_oxygen_saturation_measurement_value_recorded_now_withunit_percent@@measured_at_rest patient_oxygen_saturation_measurement_value_recorded_now_withunit_percent@@measured_on_room_air) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_spirometry_consistent_with_copd_inthehistory patient_has_finding_of_pulmonary_emphysema_inthehistory@@evidence_on_computed_tomography_scan) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
