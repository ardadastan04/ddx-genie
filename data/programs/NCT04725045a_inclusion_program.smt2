;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_by_movement_disorder_specialist Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_according_to_movement_disorder_society_criteria_2015 Bool)
(declare-const patient_hoehn_and_yahr_scale_score_value_recorded_now_withunit_none Real)
(declare-const onset_of_symptoms_value_recorded_in_years_ago Real)
(declare-const mds_updrs_part_iii_score_value_without_medication_or_without_deep_brain_stimulation_withunit_points Real)
(declare-const patient_has_electrodes_implanted_in_subthalamic_nucleus_now Bool)
(declare-const number_of_post_operative_implanted_electrodes_now Real)
(declare-const number_of_post_operative_implanted_electrodes_that_are_open_now Real)
(declare-const number_of_post_operative_implanted_electrodes_that_are_shorted_now Real)
(declare-const patient_has_post_operative_implanted_electrodes_that_pass_integrity_check_now Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_now Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_now@@stable Bool)
(declare-const patient_has_diagnosis_of_dementia_now Bool)
(declare-const patient_has_diagnosis_of_depressive_disorder_now Bool)
(declare-const patient_is_able_to_comply_with_all_visits_and_study_related_procedures Bool)
(declare-const patient_drug_or_medicament_value_recorded_now_withunit_hours Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_by_movement_disorder_specialist patient_has_diagnosis_of_parkinson_s_disease_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_according_to_movement_disorder_society_criteria_2015 patient_has_diagnosis_of_parkinson_s_disease_now) :named REQ0_AUXILIARY1))
(assert (! (= patient_has_post_operative_implanted_electrodes_that_pass_integrity_check_now (and (> number_of_post_operative_implanted_electrodes_now 0) (= number_of_post_operative_implanted_electrodes_that_are_open_now 0) (= number_of_post_operative_implanted_electrodes_that_are_shorted_now 0))) :named REQ4_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_now@@stable patient_is_exposed_to_drug_or_medicament_now) :named REQ5_AUXILIARY0))

;; Other kept assertions
(assert (! (and patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_by_movement_disorder_specialist patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_according_to_movement_disorder_society_criteria_2015) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_hoehn_and_yahr_scale_score_value_recorded_now_withunit_none 2.0) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (> onset_of_symptoms_value_recorded_in_years_ago 5.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= mds_updrs_part_iii_score_value_without_medication_or_without_deep_brain_stimulation_withunit_points 30) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_electrodes_implanted_in_subthalamic_nucleus_now :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_post_operative_implanted_electrodes_that_pass_integrity_check_now :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_exposed_to_drug_or_medicament_now@@stable :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (not patient_has_diagnosis_of_dementia_now) (not patient_has_diagnosis_of_depressive_disorder_now)) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_comply_with_all_visits_and_study_related_procedures :named REQ7_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_drug_or_medicament_value_recorded_now_withunit_hours 12.0) :named REQ9_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_comply_with_all_visits_and_study_related_procedures :named REQ9_COMPONENT1_OTHER_REQUIREMENTS))
