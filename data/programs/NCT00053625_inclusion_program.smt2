;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_number_of_cardinal_motor_signs_present_now Real)
(declare-const patient_has_clinical_signs_of_akinesia_now Bool)
(declare-const patient_has_clinical_signs_of_bradykinesia_now Bool)
(declare-const patient_has_clinical_signs_of_muscle_rigidity_now Bool)
(declare-const patient_has_clinical_signs_of_tremor_now Bool)
(declare-const patient_has_clinical_signs_of_abnormal_gait_now Bool)
(declare-const patient_has_clinical_signs_of_poor_balance_now Bool)
(declare-const patient_has_clear_response_to_levodopa_therapy_now Bool)
(declare-const hoehn_and_yahr_stage_value_recorded_during_off_medication_period_withunit_integer Int)
(declare-const patient_has_finding_of_motor_fluctuations_now_intractable Bool)
(declare-const patient_has_finding_of_motor_fluctuations_now_disabling Bool)
(declare-const patient_has_finding_of_dyskinesia_now Bool)
(declare-const patient_has_finding_of_freezing_of_gait_now Bool)
(declare-const patient_has_unsatisfactory_clinical_response_to_medical_management_ever Bool)
(declare-const patient_has_unsatisfactory_clinical_response_to_surgical_treatment_ever Bool)
(declare-const patient_is_stable_on_parkinsons_disease_medications_for_30_days Bool)
(declare-const patient_levodopa_equivalence_variation_percent_in_past_30_days Real)
(declare-const patient_has_finding_of_cognitive_comorbidity_now@@might_interfere_with_ability_to_understand_and_sign_informed_consent_form Bool)
(declare-const patient_has_finding_of_psychiatric_comorbidity_now@@might_interfere_with_ability_to_understand_and_sign_informed_consent_form Bool)
(declare-const patient_has_finding_of_co_morbid_conditions_now@@might_interfere_with_ability_to_understand_and_sign_informed_consent_form Bool)
(declare-const patient_has_finding_of_cognitive_comorbidity_now Bool)
(declare-const patient_has_finding_of_psychiatric_comorbidity_now Bool)
(declare-const patient_has_finding_of_co_morbid_conditions_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_number_of_cardinal_motor_signs_present_now (+ (ite patient_has_clinical_signs_of_akinesia_now 1.0 0.0) (ite patient_has_clinical_signs_of_bradykinesia_now 1.0 0.0) (ite patient_has_clinical_signs_of_muscle_rigidity_now 1.0 0.0) (ite patient_has_clinical_signs_of_tremor_now 1.0 0.0) (ite patient_has_clinical_signs_of_abnormal_gait_now 1.0 0.0) (ite patient_has_clinical_signs_of_poor_balance_now 1.0 0.0))) :named REQ0_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_co_morbid_conditions_now@@might_interfere_with_ability_to_understand_and_sign_informed_consent_form patient_has_finding_of_co_morbid_conditions_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_cognitive_comorbidity_now@@might_interfere_with_ability_to_understand_and_sign_informed_consent_form patient_has_finding_of_cognitive_comorbidity_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_psychiatric_comorbidity_now@@might_interfere_with_ability_to_understand_and_sign_informed_consent_form patient_has_finding_of_psychiatric_comorbidity_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! (>= patient_number_of_cardinal_motor_signs_present_now 2.0) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_clear_response_to_levodopa_therapy_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= hoehn_and_yahr_stage_value_recorded_during_off_medication_period_withunit_integer 3) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_motor_fluctuations_now_intractable patient_has_finding_of_motor_fluctuations_now_disabling patient_has_finding_of_dyskinesia_now patient_has_finding_of_freezing_of_gait_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_unsatisfactory_clinical_response_to_medical_management_ever patient_has_unsatisfactory_clinical_response_to_surgical_treatment_ever) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_stable_on_parkinsons_disease_medications_for_30_days :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_levodopa_equivalence_variation_percent_in_past_30_days (- 20)) (<= patient_levodopa_equivalence_variation_percent_in_past_30_days 20)) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and (not patient_has_finding_of_cognitive_comorbidity_now@@might_interfere_with_ability_to_understand_and_sign_informed_consent_form) (not patient_has_finding_of_psychiatric_comorbidity_now@@might_interfere_with_ability_to_understand_and_sign_informed_consent_form) (not patient_has_finding_of_co_morbid_conditions_now@@might_interfere_with_ability_to_understand_and_sign_informed_consent_form)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
