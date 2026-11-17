;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_undergoing_operation_on_abdominal_region_now Bool)
(declare-const patient_expected_30_day_mortality_rate_value_recorded_preop_withunit_percent Real)
(declare-const patient_is_undergoing_operation_on_colorectal_region_now Bool)
(declare-const patient_is_undergoing_operation_on_stomach_now Bool)
(declare-const patient_is_undergoing_operation_on_pancreas_now Bool)
(declare-const patient_is_undergoing_operation_on_liver_now Bool)
(declare-const patient_is_undergoing_qualifying_abdominal_surgery_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_risk_of_cardiovascular_disease_now Bool)
(declare-const patient_has_diagnosis_of_congestive_heart_failure_now Bool)
(declare-const patient_has_diagnosis_of_peripheral_arterial_disease_now Bool)
(declare-const patient_has_diagnosis_of_intermittent_claudication_now Bool)
(declare-const patient_has_undergone_vascular_surgery_procedure_inthehistory Bool)
(declare-const patient_has_diagnosis_of_type_1_diabetes_mellitus_now Bool)
(declare-const patient_has_diagnosis_of_type_2_diabetes_mellitus_now Bool)
(declare-const patient_has_diagnosis_of_coronary_arteriosclerosis_now Bool)
(declare-const patient_has_diagnosis_of_coronary_arteriosclerosis_now@@confirmed_on_cardiac_tests Bool)
(declare-const patient_has_diagnosis_of_myocardial_infarction_inthehistory Bool)
(declare-const patient_has_diagnosis_of_stable_angina_inthehistory Bool)
(declare-const patient_has_diagnosis_of_myocardial_ischemia_inthehistory Bool)
(declare-const patient_has_undergone_electrocardiographic_procedure_inthehistory Bool)
(declare-const patient_has_undergone_nuclear_medicine_imaging_procedure_inthehistory Bool)
(declare-const patient_has_undergone_echocardiography_inthehistory Bool)
(declare-const patient_has_undergone_angiography_of_coronary_artery_inthehistory Bool)
(declare-const patient_has_diagnosis_of_cerebrovascular_accident_inthehistory Bool)
(declare-const patient_has_diagnosis_of_renal_insufficiency_now Bool)
(declare-const patient_creatinine_value_recorded_now_in_micromoles_per_liter Real)
(declare-const patient_has_diagnosis_of_aortic_valve_stenosis_now Bool)
(declare-const patient_aortic_valve_area_value_recorded_now_in_square_centimeters Real)

;; Existing auxiliary assertions
(assert (! (= patient_is_undergoing_qualifying_abdominal_surgery_now (or patient_is_undergoing_operation_on_colorectal_region_now patient_is_undergoing_operation_on_stomach_now patient_is_undergoing_operation_on_pancreas_now patient_is_undergoing_operation_on_liver_now)) :named REQ0_AUXILIARY0))
(assert (! (=> (or patient_has_diagnosis_of_intermittent_claudication_now patient_has_undergone_vascular_surgery_procedure_inthehistory) patient_has_diagnosis_of_peripheral_arterial_disease_now) :named REQ1_AUXILIARY0))
(assert (! (=> (or patient_has_diagnosis_of_myocardial_infarction_inthehistory patient_has_diagnosis_of_stable_angina_inthehistory patient_has_diagnosis_of_myocardial_ischemia_inthehistory patient_has_diagnosis_of_coronary_arteriosclerosis_now@@confirmed_on_cardiac_tests) patient_has_diagnosis_of_coronary_arteriosclerosis_now) :named REQ1_AUXILIARY1))
(assert (! (=> (or patient_has_undergone_electrocardiographic_procedure_inthehistory patient_has_undergone_nuclear_medicine_imaging_procedure_inthehistory patient_has_undergone_echocardiography_inthehistory patient_has_undergone_angiography_of_coronary_artery_inthehistory) patient_has_diagnosis_of_coronary_arteriosclerosis_now@@confirmed_on_cardiac_tests) :named REQ1_AUXILIARY2))
(assert (! (= patient_has_diagnosis_of_renal_insufficiency_now (> patient_creatinine_value_recorded_now_in_micromoles_per_liter 150.0)) :named REQ1_AUXILIARY3))
(assert (! (= patient_has_diagnosis_of_aortic_valve_stenosis_now (< patient_aortic_valve_area_value_recorded_now_in_square_centimeters 1.0)) :named REQ1_AUXILIARY4))
(assert (! (= patient_has_finding_of_risk_of_cardiovascular_disease_now (or patient_has_diagnosis_of_congestive_heart_failure_now patient_has_diagnosis_of_peripheral_arterial_disease_now patient_has_diagnosis_of_type_1_diabetes_mellitus_now patient_has_diagnosis_of_type_2_diabetes_mellitus_now patient_has_diagnosis_of_coronary_arteriosclerosis_now patient_has_diagnosis_of_cerebrovascular_accident_inthehistory patient_has_diagnosis_of_renal_insufficiency_now patient_has_diagnosis_of_aortic_valve_stenosis_now)) :named REQ1_AUXILIARY5))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_coronary_arteriosclerosis_now@@confirmed_on_cardiac_tests patient_has_diagnosis_of_coronary_arteriosclerosis_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (and patient_is_undergoing_operation_on_abdominal_region_now (> patient_expected_30_day_mortality_rate_value_recorded_preop_withunit_percent 2.0)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_undergoing_qualifying_abdominal_surgery_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_age_value_recorded_now_in_years 45.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_risk_of_cardiovascular_disease_now :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
