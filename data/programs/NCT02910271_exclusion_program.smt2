;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_peripheral_arterial_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_diabetic_foot_inthehistory Bool)
(declare-const patient_has_undergone_amputation_of_lower_limb_inthehistory Bool)
(declare-const patient_has_symptoms_of_peripheral_arterial_disease_now Bool)
(declare-const patient_has_symptoms_of_peripheral_arterial_disease_now@@identified_according_to_edinburgh_questionnaire_for_intermittent_claudication Bool)
(declare-const patient_has_diagnosis_of_type_2_diabetes_mellitus_inthehistory Bool)
(declare-const patient_has_diagnosis_of_gestational_diabetes_mellitus_inthehistory Bool)
(declare-const patient_has_diagnosis_of_latent_autoimmune_diabetes_mellitus_in_adult_inthehistory Bool)
(declare-const patient_has_diagnosis_of_maturity_onset_diabetes_of_the_young_inthehistory Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_institutionalized_now Bool)
(declare-const patient_has_finding_of_terminal_illness_now Bool)
(declare-const patient_refuses_to_participate_in_study Bool)
(declare-const patient_refuses_to_sign_informed_consent Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_symptoms_of_peripheral_arterial_disease_now@@identified_according_to_edinburgh_questionnaire_for_intermittent_claudication patient_has_symptoms_of_peripheral_arterial_disease_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_peripheral_arterial_disease_inthehistory) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_diabetic_foot_inthehistory) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_amputation_of_lower_limb_inthehistory) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_symptoms_of_peripheral_arterial_disease_now@@identified_according_to_edinburgh_questionnaire_for_intermittent_claudication) :named REQ0_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_type_2_diabetes_mellitus_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_gestational_diabetes_mellitus_inthehistory) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_latent_autoimmune_diabetes_mellitus_in_adult_inthehistory) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_maturity_onset_diabetes_of_the_young_inthehistory) :named REQ1_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_institutionalized_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_terminal_illness_now) :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_refuses_to_participate_in_study) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_refuses_to_sign_informed_consent) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
