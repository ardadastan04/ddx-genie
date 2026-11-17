;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_difficulty_following_instructions_now Bool)
(declare-const patient_has_finding_of_impaired_cognition_now Bool)
(declare-const patient_has_finding_of_impaired_cognition_now@@prohibits_proper_use_of_kinesia_homeview_system Bool)
(declare-const patient_lacks_cognitive_ability_to_respond_to_researchers_now Bool)
(declare-const patient_lacks_cognitive_ability_to_notify_researchers_of_uncomfortable_study_parameters_now Bool)
(declare-const patient_has_finding_of_impairment_now Bool)
(declare-const patient_has_finding_of_impairment_now@@counterproductive_to_participation_in_this_study Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_impaired_cognition_now@@prohibits_proper_use_of_kinesia_homeview_system patient_has_finding_of_impaired_cognition_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_impairment_now@@counterproductive_to_participation_in_this_study patient_has_finding_of_impairment_now) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_difficulty_following_instructions_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_impaired_cognition_now@@prohibits_proper_use_of_kinesia_homeview_system) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_lacks_cognitive_ability_to_respond_to_researchers_now patient_lacks_cognitive_ability_to_notify_researchers_of_uncomfortable_study_parameters_now)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_impairment_now@@counterproductive_to_participation_in_this_study) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
