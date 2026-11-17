;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_multiple_system_atrophy_now Bool)
(declare-const patient_has_diagnosis_of_multiple_system_atrophy_now@@diagnosed_by_two_movement_disorder_neurologists Bool)
(declare-const patient_has_diagnosis_of_multiple_system_atrophy_now@@diagnosed_according_to_international_parkinson_and_movement_disorder_society_second_consensus_criteria_2019 Bool)
(declare-const patient_has_diagnosis_of_multiple_system_atrophy_now@@probable Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const disease_duration_value_recorded_now_in_years Real)
(declare-const patient_has_metabolic_brain_network_detected_by_fluorine_18_labelled_fluorodeoxyglucose_positron_emission_tomography_now Bool)
(declare-const patient_has_metabolic_brain_network_detected_by_fluorine_18_labelled_fluorodeoxyglucose_positron_emission_tomography_now@@consistent_with_multiple_system_atrophy_related_pattern Bool)
(declare-const patient_is_exposed_to_fluorodeoxyglucose_now Bool)
(declare-const patient_is_exposed_to_fluorodeoxyglucose_now@@labelled_with_fluorine_18 Bool)
(declare-const patient_has_ability_to_complete_questionnaires_now Bool)
(declare-const patient_is_willing_to_be_assessed_by_neurologist_during_off_medication_state Bool)
(declare-const patient_is_exposed_to_anti_parkinsons_disease_medication_now Bool)
(declare-const patient_is_exposed_to_anti_parkinsons_disease_medication_now@@discontinued_for_at_least_12_hours_before_assessment Bool)
(declare-const patient_is_willing_to_be_assessed_by_neurologist_during_off_medication_state@@discontinued_anti_parkinsons_disease_medication_for_at_least_12_hours_before_assessment Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_multiple_system_atrophy_now@@diagnosed_by_two_movement_disorder_neurologists patient_has_diagnosis_of_multiple_system_atrophy_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_multiple_system_atrophy_now@@diagnosed_according_to_international_parkinson_and_movement_disorder_society_second_consensus_criteria_2019 patient_has_diagnosis_of_multiple_system_atrophy_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_multiple_system_atrophy_now@@probable patient_has_diagnosis_of_multiple_system_atrophy_now) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_metabolic_brain_network_detected_by_fluorine_18_labelled_fluorodeoxyglucose_positron_emission_tomography_now@@consistent_with_multiple_system_atrophy_related_pattern patient_has_metabolic_brain_network_detected_by_fluorine_18_labelled_fluorodeoxyglucose_positron_emission_tomography_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_fluorodeoxyglucose_now@@labelled_with_fluorine_18 patient_is_exposed_to_fluorodeoxyglucose_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_is_exposed_to_anti_parkinsons_disease_medication_now@@discontinued_for_at_least_12_hours_before_assessment patient_is_exposed_to_anti_parkinsons_disease_medication_now) :named REQ5_AUXILIARY0))
(assert (! (= patient_is_willing_to_be_assessed_by_neurologist_during_off_medication_state@@discontinued_anti_parkinsons_disease_medication_for_at_least_12_hours_before_assessment (and patient_is_willing_to_be_assessed_by_neurologist_during_off_medication_state patient_is_exposed_to_anti_parkinsons_disease_medication_now@@discontinued_for_at_least_12_hours_before_assessment)) :named REQ5_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_willing_to_be_assessed_by_neurologist_during_off_medication_state@@discontinued_anti_parkinsons_disease_medication_for_at_least_12_hours_before_assessment patient_is_willing_to_be_assessed_by_neurologist_during_off_medication_state) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (and patient_has_diagnosis_of_multiple_system_atrophy_now@@probable patient_has_diagnosis_of_multiple_system_atrophy_now@@diagnosed_by_two_movement_disorder_neurologists patient_has_diagnosis_of_multiple_system_atrophy_now@@diagnosed_according_to_international_parkinson_and_movement_disorder_society_second_consensus_criteria_2019) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 50) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 75) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (< disease_duration_value_recorded_now_in_years 1) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_has_metabolic_brain_network_detected_by_fluorine_18_labelled_fluorodeoxyglucose_positron_emission_tomography_now@@consistent_with_multiple_system_atrophy_related_pattern :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_ability_to_complete_questionnaires_now :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
