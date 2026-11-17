;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now Bool)
(declare-const patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now@@contrast_enhanced_computed_tomography Bool)
(declare-const patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now@@magnetic_resonance_imaging Bool)
(declare-const patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now@@transabdominal_ultrasonography Bool)
(declare-const patient_has_finding_of_abdominal_pain_characteristic_now Bool)
(declare-const patient_serum_lipase_measurement_value_recorded_now_withunit_u_per_l Real)
(declare-const patient_amylase_measurement_serum_value_recorded_now_withunit_u_per_l Real)
(declare-const patient_has_undergone_imaging_now Bool)
(declare-const patient_serum_lipase_upper_limit_of_normal_value_now_withunit_u_per_l Real)
(declare-const patient_serum_amylase_upper_limit_of_normal_value_now_withunit_u_per_l Real)
(declare-const patient_has_elevation_in_serum_lipase_to_three_times_or_greater_than_upper_limit_of_normal_now Bool)
(declare-const patient_has_elevation_in_serum_amylase_to_three_times_or_greater_than_upper_limit_of_normal_now Bool)
(declare-const patient_meets_biochemical_criteria_for_acute_pancreatitis_now Bool)
(declare-const patient_meets_clinical_criteria_for_acute_pancreatitis_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now (or patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now@@contrast_enhanced_computed_tomography patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now@@magnetic_resonance_imaging patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now@@transabdominal_ultrasonography)) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now@@contrast_enhanced_computed_tomography patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now@@magnetic_resonance_imaging patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now@@transabdominal_ultrasonography patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now) :named REQ0_AUXILIARY3))
(assert (! (= patient_has_elevation_in_serum_lipase_to_three_times_or_greater_than_upper_limit_of_normal_now (>= patient_serum_lipase_measurement_value_recorded_now_withunit_u_per_l (* 3.0 patient_serum_lipase_upper_limit_of_normal_value_now_withunit_u_per_l))) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_elevation_in_serum_amylase_to_three_times_or_greater_than_upper_limit_of_normal_now (>= patient_amylase_measurement_serum_value_recorded_now_withunit_u_per_l (* 3.0 patient_serum_amylase_upper_limit_of_normal_value_now_withunit_u_per_l))) :named REQ1_AUXILIARY1))
(assert (! (= patient_meets_biochemical_criteria_for_acute_pancreatitis_now (or patient_has_elevation_in_serum_lipase_to_three_times_or_greater_than_upper_limit_of_normal_now patient_has_elevation_in_serum_amylase_to_three_times_or_greater_than_upper_limit_of_normal_now)) :named REQ1_AUXILIARY2))
(assert (! (= patient_meets_clinical_criteria_for_acute_pancreatitis_now (and patient_has_finding_of_abdominal_pain_characteristic_now patient_meets_biochemical_criteria_for_acute_pancreatitis_now)) :named REQ1_AUXILIARY3))

;; Other kept assertions
(assert (! patient_has_characteristic_findings_of_acute_pancreatitis_on_imaging_now :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (=> patient_meets_clinical_criteria_for_acute_pancreatitis_now (not patient_has_undergone_imaging_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
