;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=6 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_positive_pregnancy_test_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_diagnosis_of_mental_disorder_now Bool)
(declare-const patient_has_social_situation_that_would_preclude_study_compliance_now Bool)
(declare-const patient_has_finding_of_disease_condition_determination_uncontrolled_now Bool)
(declare-const patient_has_finding_of_disease_condition_determination_uncontrolled_now@@concurrent_with_study_period Bool)
(declare-const patient_has_undergone_administration_of_antineoplastic_agent_inthehistory Bool)
(declare-const patient_has_undergone_administration_of_antineoplastic_agent_inthehistory@@for_current_breast_cancer_diagnosis Bool)
(declare-const patient_has_undergone_biological_agent_therapy_inthehistory@@for_current_breast_cancer_diagnosis Bool)
(declare-const patient_has_undergone_chemotherapy_inthehistory Bool)
(declare-const patient_has_undergone_hormone_therapy_inthehistory Bool)
(declare-const patient_has_undergone_radiotherapy_inthehistory Bool)
(declare-const patient_is_undergoing_administration_of_antineoplastic_agent_now Bool)
(declare-const patient_is_undergoing_administration_of_antineoplastic_agent_now@@other_than_study_protocol_treatments Bool)
(declare-const patient_is_undergoing_biological_agent_therapy_now@@other_than_study_protocol_treatments Bool)
(declare-const patient_is_undergoing_chemotherapy_now@@concurrent_with_study_protocol_treatments Bool)
(declare-const patient_is_undergoing_hormone_therapy_now@@concurrent_with_study_protocol_treatments Bool)
(declare-const patient_is_undergoing_radiotherapy_now@@concurrent_with_study_protocol_treatments Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory@@other_than_non_melanomatous_skin_cancer_only Bool)
(declare-const patient_is_undergoing_radiotherapy_now Bool)
(declare-const patient_is_undergoing_biological_agent_therapy_now Bool)
(declare-const patient_has_undergone_biological_agent_therapy_inthehistory Bool)
(declare-const patient_is_undergoing_hormone_therapy_now Bool)
(declare-const patient_is_undergoing_chemotherapy_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_positive_pregnancy_test_now patient_is_pregnant_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disease_condition_determination_uncontrolled_now@@concurrent_with_study_period patient_has_finding_of_disease_condition_determination_uncontrolled_now) :named REQ2_AUXILIARY0))
(assert (! (=> (or patient_has_undergone_hormone_therapy_inthehistory patient_has_undergone_radiotherapy_inthehistory patient_has_undergone_chemotherapy_inthehistory patient_has_undergone_biological_agent_therapy_inthehistory@@for_current_breast_cancer_diagnosis) patient_has_undergone_administration_of_antineoplastic_agent_inthehistory@@for_current_breast_cancer_diagnosis) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_undergone_administration_of_antineoplastic_agent_inthehistory@@for_current_breast_cancer_diagnosis patient_has_undergone_administration_of_antineoplastic_agent_inthehistory) :named REQ3_AUXILIARY1))
(assert (! (=> (or patient_is_undergoing_hormone_therapy_now@@concurrent_with_study_protocol_treatments patient_is_undergoing_radiotherapy_now@@concurrent_with_study_protocol_treatments patient_is_undergoing_chemotherapy_now@@concurrent_with_study_protocol_treatments patient_is_undergoing_biological_agent_therapy_now@@other_than_study_protocol_treatments) patient_is_undergoing_administration_of_antineoplastic_agent_now@@other_than_study_protocol_treatments) :named REQ3_AUXILIARY2))
(assert (! (=> patient_is_undergoing_administration_of_antineoplastic_agent_now@@other_than_study_protocol_treatments patient_is_undergoing_administration_of_antineoplastic_agent_now) :named REQ3_AUXILIARY3))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory@@other_than_non_melanomatous_skin_cancer_only patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_undergone_biological_agent_therapy_inthehistory@@for_current_breast_cancer_diagnosis patient_has_undergone_biological_agent_therapy_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_is_undergoing_biological_agent_therapy_now@@other_than_study_protocol_treatments patient_is_undergoing_biological_agent_therapy_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_is_undergoing_chemotherapy_now@@concurrent_with_study_protocol_treatments patient_is_undergoing_chemotherapy_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_is_undergoing_hormone_therapy_now@@concurrent_with_study_protocol_treatments patient_is_undergoing_hormone_therapy_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))
(assert (! (=> patient_is_undergoing_radiotherapy_now@@concurrent_with_study_protocol_treatments patient_is_undergoing_radiotherapy_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_5))

;; Other kept assertions
(assert (! (not patient_has_positive_pregnancy_test_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_mental_disorder_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_social_situation_that_would_preclude_study_compliance_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disease_condition_determination_uncontrolled_now@@concurrent_with_study_period) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_administration_of_antineoplastic_agent_inthehistory@@for_current_breast_cancer_diagnosis) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_administration_of_antineoplastic_agent_now@@other_than_study_protocol_treatments) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory (not patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory@@other_than_non_melanomatous_skin_cancer_only))) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
