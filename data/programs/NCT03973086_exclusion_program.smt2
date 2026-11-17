;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_smoker_now Bool)
(declare-const patient_is_able_to_walk_independently_now Bool)
(declare-const patient_has_finding_of_patient_s_condition_unstable_now Bool)
(declare-const patient_has_finding_of_illness_now Bool)
(declare-const patient_has_finding_of_illness_now@@acutely_symptomatic Bool)
(declare-const patient_has_finding_of_illness_now@@life_limiting Bool)
(declare-const patient_has_finding_of_disorder_of_nervous_system_now Bool)
(declare-const patient_has_finding_of_disorder_of_nervous_system_now@@causes_functional_impairments Bool)
(declare-const patient_has_finding_of_disorder_of_nervous_system_now@@causes_cognitive_impairments Bool)
(declare-const patient_is_unwilling_to_be_randomized_to_one_of_three_intervention_groups Bool)
(declare-const patient_is_unable_to_be_randomized_to_one_of_three_intervention_groups Bool)
(declare-const patient_has_undergone_replacement_of_bilateral_hip_joints_inthehistory Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast3months Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast3months@@non_registered_product Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast3months@@temporalcontext_within3months_prior_to_screening_visit Bool)
(declare-const patient_is_unable_to_complete_study_specific_diaries Bool)
(declare-const patient_is_unwilling_to_complete_study_specific_diaries Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_illness_now@@acutely_symptomatic patient_has_finding_of_illness_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_illness_now@@life_limiting patient_has_finding_of_illness_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_finding_of_disorder_of_nervous_system_now@@causes_functional_impairments patient_has_finding_of_disorder_of_nervous_system_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disorder_of_nervous_system_now@@causes_cognitive_impairments patient_has_finding_of_disorder_of_nervous_system_now) :named REQ3_AUXILIARY1))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_inthepast3months@@non_registered_product patient_is_exposed_to_drug_or_medicament_inthepast3months) :named REQ6_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_inthepast3months@@temporalcontext_within3months_prior_to_screening_visit patient_is_exposed_to_drug_or_medicament_inthepast3months) :named REQ6_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_smoker_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_able_to_walk_independently_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_patient_s_condition_unstable_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_illness_now@@acutely_symptomatic) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_illness_now@@life_limiting) :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_nervous_system_now@@causes_functional_impairments) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_nervous_system_now@@causes_cognitive_impairments) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (or patient_is_unwilling_to_be_randomized_to_one_of_three_intervention_groups patient_is_unable_to_be_randomized_to_one_of_three_intervention_groups)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_replacement_of_bilateral_hip_joints_inthehistory) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_exposed_to_drug_or_medicament_inthepast3months@@non_registered_product patient_is_exposed_to_drug_or_medicament_inthepast3months@@temporalcontext_within3months_prior_to_screening_visit)) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_complete_study_specific_diaries) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unwilling_to_complete_study_specific_diaries) :named REQ7_COMPONENT1_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
