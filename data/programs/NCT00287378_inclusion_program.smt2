;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_forced_vital_capacity_value_recorded_now_withunit_percent_predicted Real)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent_predicted Real)
(declare-const patient_forced_expired_volume_in_one_second_forced_vital_capacity_ratio_value_recorded_now_withunit_percent_predicted Real)
(declare-const patient_has_finding_of_allergy_to_dust_mite_protein_now Bool)
(declare-const patient_hemoglobin_saturation_with_oxygen_value_recorded_now_withunit_percent Real)
(declare-const patient_systolic_blood_pressure_value_recorded_now_withunit_mm_hg Real)
(declare-const patient_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg Real)
(declare-const num_symptom_scores_greater_or_equal_3 Int)
(declare-const total_symptom_score_value_recorded_withunit_points Real)
(declare-const individual_symptom_scores_value_recorded_now_all_scores_leq_3 Bool)
(declare-const patient_immunoglobulin_e_measurement_value_recorded_now_withunit_international_units_per_ml Real)
(declare-const patient_weight_finding_value_recorded_now_withunit_kilograms Real)

;; Other kept assertions
(assert (! (> patient_forced_vital_capacity_value_recorded_now_withunit_percent_predicted 80) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent_predicted 80) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (> patient_forced_expired_volume_in_one_second_forced_vital_capacity_ratio_value_recorded_now_withunit_percent_predicted 80) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_allergy_to_dust_mite_protein_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_hemoglobin_saturation_with_oxygen_value_recorded_now_withunit_percent 94) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_systolic_blood_pressure_value_recorded_now_withunit_mm_hg 90) (<= patient_systolic_blood_pressure_value_recorded_now_withunit_mm_hg 150)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg 60) (<= patient_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg 90)) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and (<= total_symptom_score_value_recorded_withunit_points 20.0) individual_symptom_scores_value_recorded_now_all_scores_leq_3 (<= num_symptom_scores_greater_or_equal_3 1)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_immunoglobulin_e_measurement_value_recorded_now_withunit_international_units_per_ml 30) (<= patient_immunoglobulin_e_measurement_value_recorded_now_withunit_international_units_per_ml 700)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_weight_finding_value_recorded_now_withunit_kilograms 30.0) (<= patient_weight_finding_value_recorded_now_withunit_kilograms 90.0)) :named REQ5_COMPONENT1_OTHER_REQUIREMENTS))
