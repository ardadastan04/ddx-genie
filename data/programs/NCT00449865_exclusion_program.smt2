;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_exposed_to_creatine_inthehistory Bool)
(declare-const patient_is_exposed_to_creatine_inthepast14days Bool)
(declare-const patient_is_exposed_to_creatine_inthepast14days@@temporalcontext_prior_to_baseline Bool)
(declare-const patient_has_hypersensitivity_to_creatine_inthehistory Bool)
(declare-const patient_has_intolerance_to_creatine_inthehistory Bool)
(declare-const patient_has_finding_of_patient_s_condition_unstable_now Bool)
(declare-const patient_has_finding_of_clinically_significant_condition_that_impairs_ability_to_comply_with_long_term_study_follow_up_now Bool)
(declare-const patient_has_finding_of_parkinsonism_now Bool)
(declare-const patient_has_finding_of_parkinsonism_now@@caused_by_other_known_causes Bool)
(declare-const patient_has_finding_of_parkinsonism_now@@caused_by_other_suspected_causes Bool)
(declare-const patient_has_finding_of_atypical_parkinsonism_now Bool)
(declare-const patient_has_finding_of_atypical_parkinsonism_now@@suggested_by_significant_features Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_creatine_inthepast14days@@temporalcontext_prior_to_baseline patient_is_exposed_to_creatine_inthepast14days) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_parkinsonism_now@@caused_by_other_known_causes patient_has_finding_of_parkinsonism_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_parkinsonism_now@@caused_by_other_suspected_causes patient_has_finding_of_parkinsonism_now) :named REQ3_AUXILIARY1))
(assert (! (=> patient_has_finding_of_atypical_parkinsonism_now@@suggested_by_significant_features patient_has_finding_of_atypical_parkinsonism_now) :named REQ3_AUXILIARY2))

;; Other kept assertions
(assert (! (not (or patient_is_exposed_to_creatine_inthepast14days@@temporalcontext_prior_to_baseline patient_is_exposed_to_creatine_inthehistory)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_hypersensitivity_to_creatine_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_intolerance_to_creatine_inthehistory) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (or patient_has_finding_of_patient_s_condition_unstable_now patient_has_finding_of_clinically_significant_condition_that_impairs_ability_to_comply_with_long_term_study_follow_up_now)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_parkinsonism_now@@caused_by_other_known_causes) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_parkinsonism_now@@caused_by_other_suspected_causes) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_atypical_parkinsonism_now@@suggested_by_significant_features) :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
