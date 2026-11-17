;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_asthma_now@@first_diagnosis Bool)
(declare-const patient_has_diagnosis_of_asthma_now@@diagnosed_according_to_global_initiative_for_asthma_recommendations Bool)
(declare-const patient_has_finding_of_wheezing_inthehistory Bool)
(declare-const patient_has_finding_of_dyspnea_inthehistory Bool)
(declare-const patient_has_finding_of_tight_chest_inthehistory Bool)
(declare-const patient_has_finding_of_cough_inthehistory Bool)
(declare-const patient_is_exposed_to_smoke_inthehistory Bool)
(declare-const patient_is_exposed_to_mold_inthehistory Bool)
(declare-const patient_is_exposed_to_vehicular_traffic_inthehistory Bool)
(declare-const patient_has_undergone_spirometry_now@@at_baseline Bool)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_liters@@at_baseline Real)
(declare-const patient_forced_vital_capacity_value_recorded_now_withunit_liters@@at_baseline Real)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_after_bronchodilator_withunit_liters Real)
(declare-const patient_has_undergone_skin_prick_test_now Bool)
(declare-const patient_has_history_of_respiratory_symptoms Bool)
(declare-const patient_has_history_of_environmental_exposures Bool)
(declare-const patient_spirometry_fev1_fvc_ratio_below_0_90_at_baseline Bool)
(declare-const patient_spirometry_fev1_increase_after_bronchodilator_gt_12_percent Bool)
(declare-const patient_spirometry_criteria_met Bool)
(declare-const patient_asthma_diagnosis_criteria_met Bool)
(declare-const patient_has_diagnosis_of_asthma_now Bool)
(declare-const patient_has_undergone_spirometry_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_wheezing_inthehistory patient_has_finding_of_dyspnea_inthehistory patient_has_finding_of_tight_chest_inthehistory patient_has_finding_of_cough_inthehistory) patient_has_history_of_respiratory_symptoms) :named REQ2_AUXILIARY0))
(assert (! (=> (or patient_is_exposed_to_smoke_inthehistory patient_is_exposed_to_mold_inthehistory patient_is_exposed_to_vehicular_traffic_inthehistory) patient_has_history_of_environmental_exposures) :named REQ2_AUXILIARY1))
(assert (! (= patient_spirometry_fev1_fvc_ratio_below_0_90_at_baseline (< (/ patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_liters@@at_baseline patient_forced_vital_capacity_value_recorded_now_withunit_liters@@at_baseline) 0.90)) :named REQ2_AUXILIARY2))
(assert (! (= patient_spirometry_fev1_increase_after_bronchodilator_gt_12_percent (> (/ (- patient_forced_expired_volume_in_1_second_value_recorded_after_bronchodilator_withunit_liters patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_liters@@at_baseline) patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_liters@@at_baseline) 0.12)) :named REQ2_AUXILIARY3))
(assert (! (= patient_spirometry_criteria_met (and patient_has_undergone_spirometry_now@@at_baseline patient_spirometry_fev1_fvc_ratio_below_0_90_at_baseline patient_spirometry_fev1_increase_after_bronchodilator_gt_12_percent)) :named REQ2_AUXILIARY4))
(assert (! (= patient_asthma_diagnosis_criteria_met (and patient_has_diagnosis_of_asthma_now@@first_diagnosis patient_has_diagnosis_of_asthma_now@@diagnosed_according_to_global_initiative_for_asthma_recommendations patient_has_history_of_respiratory_symptoms patient_has_history_of_environmental_exposures patient_spirometry_criteria_met patient_has_undergone_skin_prick_test_now)) :named REQ2_AUXILIARY5))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_asthma_now@@diagnosed_according_to_global_initiative_for_asthma_recommendations patient_has_diagnosis_of_asthma_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_diagnosis_of_asthma_now@@first_diagnosis patient_has_diagnosis_of_asthma_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_undergone_spirometry_now@@at_baseline patient_has_undergone_spirometry_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 6) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 16) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_asthma_diagnosis_criteria_met :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
