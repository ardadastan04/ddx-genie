;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const life_expectancy_value_due_to_non_cardiac_chronic_disease_in_years Real)
(declare-const patient_has_diagnosis_of_chronic_disease_now Bool)
(declare-const patient_has_diagnosis_of_chronic_disease_now@@non_cardiac Bool)
(declare-const patient_is_undergoing_transplantation_of_heart_now Bool)
(declare-const patient_will_undergo_transplantation_of_heart_inthefuture1years Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_undergoing_replacement_of_device_now Bool)
(declare-const patient_is_undergoing_upgrade_of_device_now Bool)
(declare-const patient_has_epicardial_lead_now Bool)
(declare-const patient_has_mechanical_tricuspid_valve_now Bool)
(declare-const patient_has_finding_of_ventricular_tachyarrhythmia_now Bool)
(declare-const patient_has_finding_of_ventricular_tachyarrhythmia_now@@associated_with_reversible_causes Bool)
(declare-const patient_is_unwilling_to_provide_written_informed_consent Bool)
(declare-const patient_is_unable_to_provide_written_informed_consent Bool)
(declare-const patient_is_enrolled_in_another_clinical_study_during_this_study Bool)
(declare-const patient_intends_to_participate_in_another_clinical_study_during_this_study Bool)
(declare-const patient_is_inaccessible_for_follow_up_at_study_center Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_chronic_disease_now@@non_cardiac patient_has_diagnosis_of_chronic_disease_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_ventricular_tachyarrhythmia_now@@associated_with_reversible_causes patient_has_finding_of_ventricular_tachyarrhythmia_now) :named REQ6_AUXILIARY0))

;; Other kept assertions
(assert (! (not (and patient_has_diagnosis_of_chronic_disease_now@@non_cardiac (< life_expectancy_value_due_to_non_cardiac_chronic_disease_in_years 1))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_undergoing_transplantation_of_heart_now patient_will_undergo_transplantation_of_heart_inthefuture1years)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_replacement_of_device_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_upgrade_of_device_now) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_epicardial_lead_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_mechanical_tricuspid_valve_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_ventricular_tachyarrhythmia_now@@associated_with_reversible_causes) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unwilling_to_provide_written_informed_consent) :named REQ7_COMPONENT0_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
(assert (! (not patient_is_unable_to_provide_written_informed_consent) :named REQ7_COMPONENT1_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
(assert (! (not patient_is_enrolled_in_another_clinical_study_during_this_study) :named REQ8_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_intends_to_participate_in_another_clinical_study_during_this_study) :named REQ8_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_inaccessible_for_follow_up_at_study_center) :named REQ9_COMPONENT0_OTHER_REQUIREMENTS))
