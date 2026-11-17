;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_organ_failure_on_first_day_of_presentation Bool)
(declare-const patient_has_organ_failure_on_first_day_of_presentation@@as_determined_by_atlanta_criteria Bool)
(declare-const patient_has_clinical_signs_of_sepsis_now Bool)
(declare-const patient_has_symptoms_of_sepsis_now Bool)
(declare-const patient_has_diagnosis_of_alcohol_induced_acute_pancreatitis_now Bool)
(declare-const patient_has_undergone_imaging_of_abdomen_inthehistory Bool)
(declare-const patient_has_undergone_imaging_of_abdomen_inthehistory@@demonstrates_dilated_pancreatic_duct Bool)
(declare-const patient_has_undergone_imaging_of_abdomen_inthehistory@@demonstrates_pancreatic_calcifications Bool)
(declare-const international_normalized_ratio_value_recorded_now_withunit_ratio Real)
(declare-const platelet_count_value_recorded_now_withunit_per_microliter Real)
(declare-const patient_has_finding_of_blood_coagulation_disorder_now Bool)
(declare-const patient_has_finding_of_co_morbid_conditions_now Bool)
(declare-const patient_has_finding_of_co_morbid_conditions_now@@requires_hospitalization Bool)
(declare-const patient_has_finding_of_acute_myocardial_infarction_now Bool)
(declare-const patient_has_finding_of_malignancy_now Bool)
(declare-const patient_has_finding_of_cirrhosis_now Bool)
(declare-const patient_has_finding_of_chronic_kidney_disease_now Bool)
(declare-const patient_has_finding_of_chronic_pulmonary_disease_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_organ_failure_on_first_day_of_presentation@@as_determined_by_atlanta_criteria patient_has_organ_failure_on_first_day_of_presentation) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_imaging_of_abdomen_inthehistory@@demonstrates_dilated_pancreatic_duct patient_has_undergone_imaging_of_abdomen_inthehistory) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_undergone_imaging_of_abdomen_inthehistory@@demonstrates_pancreatic_calcifications patient_has_undergone_imaging_of_abdomen_inthehistory) :named REQ3_AUXILIARY1))
(assert (! (= patient_has_finding_of_blood_coagulation_disorder_now (or (> international_normalized_ratio_value_recorded_now_withunit_ratio 1) (< platelet_count_value_recorded_now_withunit_per_microliter 50000))) :named REQ4_AUXILIARY0))
(assert (! (=> (or patient_has_finding_of_acute_myocardial_infarction_now patient_has_finding_of_malignancy_now patient_has_finding_of_cirrhosis_now patient_has_finding_of_chronic_kidney_disease_now patient_has_finding_of_chronic_pulmonary_disease_now) patient_has_finding_of_co_morbid_conditions_now@@requires_hospitalization) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_finding_of_co_morbid_conditions_now@@requires_hospitalization patient_has_finding_of_co_morbid_conditions_now) :named REQ5_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_organ_failure_on_first_day_of_presentation@@as_determined_by_atlanta_criteria) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_clinical_signs_of_sepsis_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_symptoms_of_sepsis_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_alcohol_induced_acute_pancreatitis_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_imaging_of_abdomen_inthehistory@@demonstrates_dilated_pancreatic_duct) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_imaging_of_abdomen_inthehistory@@demonstrates_pancreatic_calcifications) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_blood_coagulation_disorder_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_co_morbid_conditions_now@@requires_hospitalization) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
