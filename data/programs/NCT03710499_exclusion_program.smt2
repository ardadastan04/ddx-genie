;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_can_undergo_6_minute_walk_test_now Bool)
(declare-const patient_can_undergo_6_minute_walk_test_now@@performed_according_to_american_thoracic_society_criteria Bool)
(declare-const patient_has_finding_of_impaired_cognition_now Bool)
(declare-const patient_has_finding_of_impaired_cognition_now@@measured_by_mini_mental_state_examination Bool)
(declare-const patient_abandons_treatment_during_application_of_protocol Bool)
(declare-const patient_is_undergoing_therapeutic_procedure_now Bool)
(declare-const patient_is_undergoing_therapeutic_procedure_now@@during_application_of_protocol Bool)
(declare-const patient_has_finding_of_poor_hypertension_control_now Bool)
(declare-const patient_systolic_blood_pressure_value_recorded_now_withunit_mm_hg Real)
(declare-const patient_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg Real)
(declare-const patient_is_exposed_to_hypotensive_agent_now Bool)
(declare-const patient_is_exposed_to_psychotropic_agent_now Bool)
(declare-const patient_has_significant_limitation_due_to_osteoarthropathy_now Bool)
(declare-const patient_has_undergone_surgical_procedure_inthepast1years Bool)
(declare-const patient_has_undergone_surgical_procedure_inthepast1years@@resulted_in_exercise_restriction Bool)
(declare-const patient_has_finding_of_hypothyroidism_now Bool)
(declare-const patient_has_finding_of_hypothyroidism_now@@untreated Bool)
(declare-const patient_has_finding_of_hypocortisolism_secondary_to_another_disorder_now Bool)
(declare-const patient_has_finding_of_hypocortisolism_secondary_to_another_disorder_now@@untreated Bool)
(declare-const patient_has_international_physical_activity_questionnaire_classification_of_very_active Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_can_undergo_6_minute_walk_test_now@@performed_according_to_american_thoracic_society_criteria patient_can_undergo_6_minute_walk_test_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_impaired_cognition_now@@measured_by_mini_mental_state_examination patient_has_finding_of_impaired_cognition_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_undergoing_therapeutic_procedure_now@@during_application_of_protocol patient_is_undergoing_therapeutic_procedure_now) :named REQ2_AUXILIARY0))
(assert (! (= patient_has_finding_of_poor_hypertension_control_now (and patient_is_exposed_to_hypotensive_agent_now (or (> patient_systolic_blood_pressure_value_recorded_now_withunit_mm_hg 180) (> patient_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg 100)))) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_undergone_surgical_procedure_inthepast1years@@resulted_in_exercise_restriction patient_has_undergone_surgical_procedure_inthepast1years) :named REQ6_AUXILIARY0))
(assert (! (=> patient_has_finding_of_hypothyroidism_now@@untreated patient_has_finding_of_hypothyroidism_now) :named REQ7_AUXILIARY0))
(assert (! (=> patient_has_finding_of_hypocortisolism_secondary_to_another_disorder_now@@untreated patient_has_finding_of_hypocortisolism_secondary_to_another_disorder_now) :named REQ7_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_can_undergo_6_minute_walk_test_now@@performed_according_to_american_thoracic_society_criteria) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_impaired_cognition_now@@measured_by_mini_mental_state_examination) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_abandons_treatment_during_application_of_protocol) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_poor_hypertension_control_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_psychotropic_agent_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_significant_limitation_due_to_osteoarthropathy_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_surgical_procedure_inthepast1years@@resulted_in_exercise_restriction) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or patient_has_finding_of_hypothyroidism_now@@untreated patient_has_finding_of_hypocortisolism_secondary_to_another_disorder_now@@untreated)) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_international_physical_activity_questionnaire_classification_of_very_active) :named REQ8_COMPONENT0_OTHER_REQUIREMENTS))
