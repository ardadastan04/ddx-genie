;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_incomplete_medical_history_now Bool)
(declare-const patient_has_incomplete_medical_history_now@@precludes_confirmation_of_inclusion_criteria Bool)
(declare-const patient_has_finding_of_lost_to_follow_up_inthehistory Bool)
(declare-const patient_has_finding_of_lost_to_follow_up_inthehistory@@prior_to_data_collection_for_study_endpoints Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_incomplete_medical_history_now@@precludes_confirmation_of_inclusion_criteria patient_has_incomplete_medical_history_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_lost_to_follow_up_inthehistory@@prior_to_data_collection_for_study_endpoints patient_has_finding_of_lost_to_follow_up_inthehistory) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_incomplete_medical_history_now@@precludes_confirmation_of_inclusion_criteria) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_lost_to_follow_up_inthehistory@@prior_to_data_collection_for_study_endpoints) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
