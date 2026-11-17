;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_symptoms_of_lower_urinary_tract_symptoms_now Bool)
(declare-const patient_total_international_prostate_symptom_score_value_recorded_now_withunit_score Real)
(declare-const patient_maximal_urinary_flow_rate_value_recorded_now_withunit_ml_per_sec Real)
(declare-const patient_residual_urine_volume_value_recorded_now_withunit_ml Real)
(declare-const patient_residual_urine_volume_value_recorded_now_withunit_ml@@measured_at_screening Bool)
(declare-const patient_prostate_specific_antigen_measurement_value_recorded_now_withunit_ng_per_ml Real)
(declare-const prostate_cancer_has_been_ruled_out_now Bool)
(declare-const patient_is_able_to_give_informed_consent Bool)
(declare-const patient_is_able_to_comply_with_all_study_protocol_procedures Bool)

;; Other kept assertions
(assert (! patient_sex_is_male_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 45) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_symptoms_of_lower_urinary_tract_symptoms_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= patient_total_international_prostate_symptom_score_value_recorded_now_withunit_score 8) (< patient_total_international_prostate_symptom_score_value_recorded_now_withunit_score 25)) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_maximal_urinary_flow_rate_value_recorded_now_withunit_ml_per_sec 4.0) (<= patient_maximal_urinary_flow_rate_value_recorded_now_withunit_ml_per_sec 15.0)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_residual_urine_volume_value_recorded_now_withunit_ml@@measured_at_screening (<= patient_residual_urine_volume_value_recorded_now_withunit_ml 200.0)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (< patient_prostate_specific_antigen_measurement_value_recorded_now_withunit_ng_per_ml 4.0) (and (>= patient_prostate_specific_antigen_measurement_value_recorded_now_withunit_ng_per_ml 4.0) (< patient_prostate_specific_antigen_measurement_value_recorded_now_withunit_ng_per_ml 10.0) prostate_cancer_has_been_ruled_out_now)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_give_informed_consent :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_comply_with_all_study_protocol_procedures :named REQ6_COMPONENT2_OTHER_REQUIREMENTS))
