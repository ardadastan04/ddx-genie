;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_resting_tremor_now Bool)
(declare-const patient_has_finding_of_bradykinesia_now Bool)
(declare-const patient_has_finding_of_stiffness_now Bool)
(declare-const patient_assessment_using_mini_mental_state_examination_value_recorded_now_withunit_score Real)
(declare-const patient_has_family_history_of_neurodegenerative_disease Bool)
(declare-const patient_has_family_history_of_neurodegenerative_disease@@onset_age_of_neurodegenerative_disease_in_family_member_value_in_years Real)
(declare-const patient_has_finding_of_parkinsonian_features_now Bool)
(declare-const patient_has_functional_disability_now Bool)
(declare-const patient_has_functional_disability_now@@cause_is_known Bool)
(declare-const patient_has_functional_disability_now@@cause_is_unrelated_to_neurodegenerative_disease Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_bradykinesia_now patient_has_finding_of_resting_tremor_now patient_has_finding_of_stiffness_now) patient_has_finding_of_parkinsonian_features_now) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_functional_disability_now@@cause_is_known patient_has_functional_disability_now) :named REQ6_AUXILIARY0))
(assert (! (=> patient_has_functional_disability_now@@cause_is_unrelated_to_neurodegenerative_disease patient_has_functional_disability_now) :named REQ6_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_resting_tremor_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_bradykinesia_now) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_stiffness_now) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (> patient_assessment_using_mini_mental_state_examination_value_recorded_now_withunit_score 25) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (not patient_has_family_history_of_neurodegenerative_disease) (>= patient_has_family_history_of_neurodegenerative_disease@@onset_age_of_neurodegenerative_disease_in_family_member_value_in_years 70)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_parkinsonian_features_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (=> patient_has_functional_disability_now (and patient_has_functional_disability_now@@cause_is_known patient_has_functional_disability_now@@cause_is_unrelated_to_neurodegenerative_disease)) (> patient_assessment_using_mini_mental_state_examination_value_recorded_now_withunit_score 25)) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
