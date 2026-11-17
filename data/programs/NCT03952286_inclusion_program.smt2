;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_been_treated_for_asthma_exacerbation_in_the_history Bool)
(declare-const patient_has_been_treated_for_asthma_exacerbation_in_the_history@@determined_clinically_by_principal_hospital_emergency_department_provider_based_on_symptoms Bool)
(declare-const patient_has_finding_of_dyspnea_now Bool)
(declare-const patient_has_finding_of_cough_now Bool)
(declare-const patient_has_finding_of_wheezing_now Bool)
(declare-const number_of_albuterol_doses_administered_in_current_encounter Real)
(declare-const number_of_systemic_corticosteroid_doses_administered_in_current_encounter Real)
(declare-const patient_can_be_safely_discharged_home_now Bool)
(declare-const symptoms_improve_after_albuterol_and_systemic_corticosteroid_in_current_encounter Bool)
(declare-const symptoms_improve_after_albuterol_in_current_encounter Bool)
(declare-const symptoms_improve_after_systemic_corticosteroid_in_current_encounter Bool)
(declare-const patient_has_diagnosis_of_asthma_now Bool)
(declare-const patient_has_diagnosis_of_asthma_now@@diagnosed_by_physician Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_been_treated_for_asthma_exacerbation_in_the_history@@determined_clinically_by_principal_hospital_emergency_department_provider_based_on_symptoms patient_has_been_treated_for_asthma_exacerbation_in_the_history) :named REQ1_AUXILIARY0))
(assert (! (=> (or patient_has_finding_of_dyspnea_now patient_has_finding_of_cough_now patient_has_finding_of_wheezing_now) patient_has_been_treated_for_asthma_exacerbation_in_the_history@@determined_clinically_by_principal_hospital_emergency_department_provider_based_on_symptoms) :named REQ1_AUXILIARY1))
(assert (! (= symptoms_improve_after_albuterol_and_systemic_corticosteroid_in_current_encounter (and symptoms_improve_after_albuterol_in_current_encounter symptoms_improve_after_systemic_corticosteroid_in_current_encounter)) :named REQ2_AUXILIARY0))
(assert (! (= symptoms_improve_after_albuterol_in_current_encounter (> number_of_albuterol_doses_administered_in_current_encounter 1)) :named REQ2_AUXILIARY1))
(assert (! (= symptoms_improve_after_systemic_corticosteroid_in_current_encounter (> number_of_systemic_corticosteroid_doses_administered_in_current_encounter 1)) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_diagnosis_of_asthma_now@@diagnosed_by_physician patient_has_diagnosis_of_asthma_now) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 6.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 12.0) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_been_treated_for_asthma_exacerbation_in_the_history@@determined_clinically_by_principal_hospital_emergency_department_provider_based_on_symptoms :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! symptoms_improve_after_albuterol_in_current_encounter :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! symptoms_improve_after_systemic_corticosteroid_in_current_encounter :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_can_be_safely_discharged_home_now :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_asthma_now@@diagnosed_by_physician :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
