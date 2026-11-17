;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_clinically_significant_medical_history_that_increases_preoperative_complications Bool)
(declare-const patient_has_clinically_significant_medical_history_that_increases_postoperative_complications Bool)
(declare-const patient_has_diagnosis_of_heart_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_disorder_of_lung_inthehistory Bool)
(declare-const patient_has_diagnosis_of_poor_hypertension_control_inthehistory Bool)
(declare-const patient_has_diagnosis_of_diabetes_mellitus_inthehistory Bool)
(declare-const patient_has_diagnosis_of_secondary_parkinsonism_now Bool)
(declare-const patient_has_diagnosis_of_atypical_parkinsonism_now Bool)
(declare-const patient_has_finding_of_cerebrovascular_accident_inthehistory Bool)
(declare-const patient_has_finding_of_encephalitis_inthehistory Bool)
(declare-const patient_is_exposed_to_toxin_inthehistory Bool)
(declare-const patient_is_exposed_to_anti_psychotic_agent_inthehistory Bool)
(declare-const patient_has_finding_of_upper_motor_neuron_involvement_now Bool)
(declare-const patient_has_finding_of_cerebellar_involvement_now Bool)
(declare-const patient_has_clinical_signs_of_supranuclear_gaze_palsy_now Bool)
(declare-const patient_has_finding_of_significant_autonomic_dysfunction_now Bool)
(declare-const patient_has_finding_of_cerebral_atrophy_now Bool)
(declare-const patient_has_finding_of_lacunar_infarction_now Bool)
(declare-const patient_has_finding_of_iron_deposits_in_putamen_now Bool)
(declare-const mattis_dementia_rating_scale_value_recorded_most_recent_withunit_score Real)
(declare-const patient_meets_dsm_iv_criterion_for_dementia_now Bool)
(declare-const patient_has_diagnosis_of_anxiety_disorder_now Bool)
(declare-const patient_has_diagnosis_of_depressive_disorder_now Bool)
(declare-const patient_has_diagnosis_of_psychotic_disorder_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_diagnosis_of_heart_disease_inthehistory patient_has_diagnosis_of_disorder_of_lung_inthehistory patient_has_diagnosis_of_poor_hypertension_control_inthehistory patient_has_diagnosis_of_diabetes_mellitus_inthehistory) patient_has_clinically_significant_medical_history_that_increases_preoperative_complications) :named REQ0_AUXILIARY0))
(assert (! (=> (or patient_has_diagnosis_of_heart_disease_inthehistory patient_has_diagnosis_of_disorder_of_lung_inthehistory patient_has_diagnosis_of_poor_hypertension_control_inthehistory patient_has_diagnosis_of_diabetes_mellitus_inthehistory) patient_has_clinically_significant_medical_history_that_increases_postoperative_complications) :named REQ0_AUXILIARY1))
(assert (! (=> (or patient_has_finding_of_cerebrovascular_accident_inthehistory patient_has_finding_of_encephalitis_inthehistory patient_is_exposed_to_toxin_inthehistory patient_is_exposed_to_anti_psychotic_agent_inthehistory patient_has_finding_of_upper_motor_neuron_involvement_now patient_has_finding_of_cerebellar_involvement_now patient_has_clinical_signs_of_supranuclear_gaze_palsy_now patient_has_finding_of_significant_autonomic_dysfunction_now patient_has_finding_of_cerebral_atrophy_now patient_has_finding_of_lacunar_infarction_now patient_has_finding_of_iron_deposits_in_putamen_now) patient_has_diagnosis_of_atypical_parkinsonism_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_clinically_significant_medical_history_that_increases_preoperative_complications) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_clinically_significant_medical_history_that_increases_postoperative_complications) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_secondary_parkinsonism_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_atypical_parkinsonism_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (< mattis_dementia_rating_scale_value_recorded_most_recent_withunit_score 116)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_meets_dsm_iv_criterion_for_dementia_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (or patient_has_diagnosis_of_anxiety_disorder_now patient_has_diagnosis_of_depressive_disorder_now patient_has_diagnosis_of_psychotic_disorder_now)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
