;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_able_to_communicate_readily_in_english_now Bool)
(declare-const patient_has_access_to_telephone_now Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory Bool)
(declare-const patient_has_finding_of_carcinoma_of_uterine_cervix_invasive_now Bool)
(declare-const patient_has_finding_of_carcinoma_of_uterine_cervix_invasive_now@@evidence_is_positive Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now@@is_another_condition_distinct_from_primary Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now@@is_life_threatening Bool)
(declare-const patient_has_finding_of_dementia_now Bool)
(declare-const patient_has_prior_participation_in_this_research_study Bool)
(declare-const patient_has_finding_of_human_immunodeficiency_virus_infection_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_carcinoma_of_uterine_cervix_invasive_now@@evidence_is_positive patient_has_finding_of_carcinoma_of_uterine_cervix_invasive_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disease_condition_finding_now@@is_another_condition_distinct_from_primary patient_has_finding_of_disease_condition_finding_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disease_condition_finding_now@@is_life_threatening patient_has_finding_of_disease_condition_finding_now) :named REQ4_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_is_able_to_communicate_readily_in_english_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_access_to_telephone_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_carcinoma_of_uterine_cervix_invasive_now@@evidence_is_positive) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_disease_condition_finding_now@@is_another_condition_distinct_from_primary patient_has_finding_of_disease_condition_finding_now@@is_life_threatening)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_dementia_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_prior_participation_in_this_research_study) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_human_immunodeficiency_virus_infection_now) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
