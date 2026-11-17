;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_functional_disorder_not_identified_now Bool)
(declare-const patient_mini_mental_state_examination_score_value_recorded_now_withunit_score Real)
(declare-const patient_is_undergoing_clinical_trial_now Bool)
(declare-const patient_is_undergoing_clinical_trial_now@@therapeutic Bool)
(declare-const patient_is_undergoing_clinical_trial_now@@in_exclusion_period_of_previous_trial Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_clinical_trial_now@@therapeutic patient_is_undergoing_clinical_trial_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_undergoing_clinical_trial_now@@in_exclusion_period_of_previous_trial patient_is_undergoing_clinical_trial_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_functional_disorder_not_identified_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (<= patient_mini_mental_state_examination_score_value_recorded_now_withunit_score 25)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_clinical_trial_now@@therapeutic) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_clinical_trial_now@@in_exclusion_period_of_previous_trial) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
