;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_able_to_communicate_readily_in_english Bool)
(declare-const patient_has_access_to_telephone_now Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory@@excludes_current_abnormal_pap_smear_reason_for_initial_colposcopy Bool)
(declare-const patient_needs_to_undergo_colposcopy_now Bool)
(declare-const patient_needs_to_undergo_colposcopy_now@@is_initial_evaluation Bool)
(declare-const patient_has_finding_of_carcinoma_of_uterine_cervix_invasive_now Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now@@is_life_threatening Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now@@is_another_condition_not_primary Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now@@is_another_condition_not_primary@@is_life_threatening Bool)
(declare-const patient_has_finding_of_dementia_now Bool)
(declare-const patient_has_prior_participation_in_this_research_study Bool)
(declare-const patient_has_finding_of_human_immunodeficiency_virus_infection_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory@@excludes_current_abnormal_pap_smear_reason_for_initial_colposcopy patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory) :named REQ2_AUXILIARY0))
(assert (! (=> patient_needs_to_undergo_colposcopy_now@@is_initial_evaluation patient_needs_to_undergo_colposcopy_now) :named REQ2_AUXILIARY1))
(assert (! (= patient_has_finding_of_disease_condition_finding_now@@is_another_condition_not_primary@@is_life_threatening (and patient_has_finding_of_disease_condition_finding_now@@is_another_condition_not_primary patient_has_finding_of_disease_condition_finding_now@@is_life_threatening)) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disease_condition_finding_now@@is_another_condition_not_primary patient_has_finding_of_disease_condition_finding_now) :named REQ4_AUXILIARY1))
(assert (! (=> patient_has_finding_of_disease_condition_finding_now@@is_life_threatening patient_has_finding_of_disease_condition_finding_now) :named REQ4_AUXILIARY2))
(assert (! (=> patient_has_finding_of_disease_condition_finding_now@@is_another_condition_not_primary@@is_life_threatening patient_has_finding_of_disease_condition_finding_now@@is_another_condition_not_primary) :named REQ4_AUXILIARY3))
(assert (! (=> patient_has_finding_of_disease_condition_finding_now@@is_another_condition_not_primary@@is_life_threatening patient_has_finding_of_disease_condition_finding_now@@is_life_threatening) :named REQ4_AUXILIARY4))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_disease_condition_finding_now@@is_another_condition_not_primary@@is_life_threatening patient_has_finding_of_disease_condition_finding_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not patient_is_able_to_communicate_readily_in_english) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_has_access_to_telephone_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory@@excludes_current_abnormal_pap_smear_reason_for_initial_colposcopy) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_carcinoma_of_uterine_cervix_invasive_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disease_condition_finding_now@@is_another_condition_not_primary@@is_life_threatening) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_dementia_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_prior_participation_in_this_research_study) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_human_immunodeficiency_virus_infection_now) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
