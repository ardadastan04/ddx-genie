;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_bronchitis_now Bool)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_diagnosis_of_lung_disease_other_than_asthma_now Bool)
(declare-const patient_has_diagnosis_of_vocal_cord_dysfunction_now Bool)
(declare-const patient_has_suspicion_of_vocal_cord_dysfunction_now Bool)
(declare-const patient_has_significant_medical_illness_other_than_asthma_now Bool)
(declare-const patient_has_finding_of_respiratory_tract_infection_inthehistory Bool)
(declare-const patient_has_finding_of_respiratory_tract_infection_inthehistory@@temporalcontext_within4weeks_prior_to_study_entry Bool)
(declare-const patient_has_finding_of_acute_asthma_inthepast4weeks Bool)
(declare-const patient_has_finding_of_acute_asthma_inthepast4weeks@@significant Bool)
(declare-const patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory Bool)
(declare-const patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory@@inthepast5years_prior_to_study_entry Bool)
(declare-const patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory@@required_treatment_with_intubation Bool)
(declare-const patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory@@required_treatment_with_mechanical_ventilation Bool)
(declare-const patient_is_receiving_hyposensitization_therapy_now Bool)
(declare-const patient_is_receiving_established_maintenance_regimen_now Bool)
(declare-const patient_has_inability_to_coordinate_use_of_delivery_devices_used_in_study_based_on_investigator_opinion Bool)
(declare-const patient_has_inability_to_coordinate_use_of_delivery_devices_used_in_study_based_on_clinical_coordinator_opinion Bool)
(declare-const patient_is_pregnant_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now patient_has_diagnosis_of_chronic_bronchitis_now) patient_has_diagnosis_of_lung_disease_other_than_asthma_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_respiratory_tract_infection_inthehistory@@temporalcontext_within4weeks_prior_to_study_entry patient_has_finding_of_respiratory_tract_infection_inthehistory) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_acute_asthma_inthepast4weeks@@significant patient_has_finding_of_acute_asthma_inthepast4weeks) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory@@inthepast5years_prior_to_study_entry patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory@@required_treatment_with_intubation patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory) :named REQ5_AUXILIARY1))
(assert (! (=> patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory@@required_treatment_with_mechanical_ventilation patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory) :named REQ5_AUXILIARY2))

;; Other kept assertions
(assert (! (not (or patient_has_diagnosis_of_lung_disease_other_than_asthma_now patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now patient_has_diagnosis_of_chronic_bronchitis_now)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_vocal_cord_dysfunction_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_suspicion_of_vocal_cord_dysfunction_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_significant_medical_illness_other_than_asthma_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_respiratory_tract_infection_inthehistory@@temporalcontext_within4weeks_prior_to_study_entry) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_acute_asthma_inthepast4weeks@@significant) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory@@required_treatment_with_intubation patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory@@required_treatment_with_mechanical_ventilation patient_has_finding_of_life_threatening_acute_exacerbation_of_asthma_inthehistory@@inthepast5years_prior_to_study_entry)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_receiving_hyposensitization_therapy_now (not patient_is_receiving_established_maintenance_regimen_now))) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_inability_to_coordinate_use_of_delivery_devices_used_in_study_based_on_investigator_opinion) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_inability_to_coordinate_use_of_delivery_devices_used_in_study_based_on_clinical_coordinator_opinion) :named REQ7_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ8_COMPONENT0_OTHER_REQUIREMENTS))
