;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const hoehn_and_yahr_stage_value_recorded_now_withunit_integer Int)
(declare-const patient_has_finding_of_bradykinesia_now Bool)
(declare-const patient_has_finding_of_muscular_rigidity_now Bool)
(declare-const patient_has_finding_of_rest_tremor_now Bool)
(declare-const patient_number_of_cardinal_motor_features_exhibited_now Real)
(declare-const patient_has_fluctuation_response_to_levodopa_now Bool)
(declare-const patient_is_exposed_to_levodopa_now Bool)
(declare-const patient_has_finding_of_dyskinesia_now Bool)
(declare-const patient_has_no_other_historical_signs_to_suggest_alternate_diagnosis Bool)
(declare-const patient_has_no_other_laboratory_signs_to_suggest_alternate_diagnosis Bool)
(declare-const patient_has_no_other_physical_signs_to_suggest_alternate_diagnosis Bool)
(declare-const patient_has_finding_of_dementia_now@@is_significant Bool)
(declare-const patient_assessment_using_mini_mental_state_examination_value_recorded_now_withunit_score Real)
(declare-const patient_has_undergone_assessment_using_mini_mental_state_examination_now Bool)
(declare-const patient_is_exposed_to_levodopa_now@@oral Bool)
(declare-const patient_has_finding_of_dementia_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_number_of_cardinal_motor_features_exhibited_now (+ (ite patient_has_finding_of_bradykinesia_now 1.0 0.0) (ite patient_has_finding_of_muscular_rigidity_now 1.0 0.0) (ite patient_has_finding_of_rest_tremor_now 1.0 0.0))) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_levodopa_now@@oral patient_is_exposed_to_levodopa_now) :named REQ7_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_dementia_now@@is_significant patient_has_finding_of_dementia_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 30) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 80) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= hoehn_and_yahr_stage_value_recorded_now_withunit_integer 2) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (<= hoehn_and_yahr_stage_value_recorded_now_withunit_integer 4) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (>= patient_number_of_cardinal_motor_features_exhibited_now 2.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_fluctuation_response_to_levodopa_now :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_dyskinesia_now :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_no_other_historical_signs_to_suggest_alternate_diagnosis :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_no_other_laboratory_signs_to_suggest_alternate_diagnosis :named REQ5_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_no_other_physical_signs_to_suggest_alternate_diagnosis :named REQ5_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_dementia_now@@is_significant) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_undergone_assessment_using_mini_mental_state_examination_now (> patient_assessment_using_mini_mental_state_examination_value_recorded_now_withunit_score 24)) :named REQ6_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_exposed_to_levodopa_now@@oral :named REQ7_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
