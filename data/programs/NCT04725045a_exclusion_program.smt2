;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_significant_psychiatric_problem_now Bool)
(declare-const patient_has_significant_psychiatric_problem_now@@not_depression_related_to_parkinsons_disease Bool)
(declare-const patient_has_finding_of_depressive_disorder_now Bool)
(declare-const patient_has_finding_of_depressive_disorder_now@@clinically_significant Bool)
(declare-const patient_has_finding_of_depressive_disorder_now@@related_to_parkinsons_disease Bool)
(declare-const patient_has_finding_of_depressive_disorder_now@@unrelated_to_parkinsons_disease Bool)
(declare-const patient_has_finding_of_finding_relating_to_drug_misuse_behavior_now Bool)
(declare-const patient_has_finding_of_harmful_pattern_of_use_of_alcohol_now Bool)
(declare-const patient_has_finding_of_recurrent_seizures_inthehistory Bool)
(declare-const patient_has_finding_of_epileptic_seizure_inthehistory Bool)
(declare-const patient_has_significant_medical_condition_now_likely_to_interfere_with_study_procedures Bool)
(declare-const patient_has_significant_medical_condition_now_likely_to_confound_evaluation_of_study_endpoints Bool)
(declare-const patient_has_finding_of_terminal_illness_now Bool)
(declare-const patient_survival_time_estimate_in_months Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_significant_psychiatric_problem_now@@not_depression_related_to_parkinsons_disease patient_has_significant_psychiatric_problem_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_depressive_disorder_now@@clinically_significant patient_has_finding_of_depressive_disorder_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_depressive_disorder_now@@related_to_parkinsons_disease patient_has_finding_of_depressive_disorder_now) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_finding_of_depressive_disorder_now@@unrelated_to_parkinsons_disease patient_has_finding_of_depressive_disorder_now) :named REQ0_AUXILIARY3))

;; Other kept assertions
(assert (! (not patient_has_significant_psychiatric_problem_now@@not_depression_related_to_parkinsons_disease) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_depressive_disorder_now@@clinically_significant patient_has_finding_of_depressive_disorder_now@@unrelated_to_parkinsons_disease)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_finding_relating_to_drug_misuse_behavior_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_harmful_pattern_of_use_of_alcohol_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_recurrent_seizures_inthehistory) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_epileptic_seizure_inthehistory) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_significant_medical_condition_now_likely_to_interfere_with_study_procedures) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_significant_medical_condition_now_likely_to_confound_evaluation_of_study_endpoints) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_terminal_illness_now (< patient_survival_time_estimate_in_months 12))) :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
