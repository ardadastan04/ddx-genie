;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_lower_urinary_tract_symptoms_now Bool)
(declare-const patient_has_diagnosis_of_benign_prostatic_hyperplasia_now Bool)
(declare-const international_prostate_symptom_score_value_recorded_now_withunit_points Real)
(declare-const patient_has_symptoms_of_lower_urinary_tract_symptoms_now@@mild_severity Bool)
(declare-const patient_has_symptoms_of_lower_urinary_tract_symptoms_now@@severe_severity Bool)
(declare-const patient_volume_of_prostate_value_recorded_now_withunit_ml Real)
(declare-const patient_urinary_flow_rate_value_recorded_now_withunit_ml_per_second Real)
(declare-const patient_has_undergone_medical_therapy_inthehistory Bool)
(declare-const patient_has_undergone_medical_therapy_inthehistory@@duration_at_least_6_months Bool)
(declare-const patient_has_undergone_medical_therapy_inthehistory@@outcome_ineffective Bool)
(declare-const patient_has_finding_of_medication_side_effects_present_inthehistory Bool)
(declare-const patient_has_finding_of_medication_side_effects_present_inthehistory@@caused_by_previous_medical_therapy Bool)
(declare-const patient_has_finding_of_medication_side_effects_present_inthehistory@@too_difficult_to_tolerate Bool)
(declare-const patient_has_symptoms_of_lower_urinary_tract_symptoms_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_medical_therapy_inthehistory@@duration_at_least_6_months patient_has_undergone_medical_therapy_inthehistory) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_undergone_medical_therapy_inthehistory@@outcome_ineffective patient_has_undergone_medical_therapy_inthehistory) :named REQ5_AUXILIARY1))
(assert (! (=> patient_has_finding_of_medication_side_effects_present_inthehistory@@caused_by_previous_medical_therapy patient_has_finding_of_medication_side_effects_present_inthehistory) :named REQ5_AUXILIARY2))
(assert (! (=> patient_has_finding_of_medication_side_effects_present_inthehistory@@too_difficult_to_tolerate patient_has_finding_of_medication_side_effects_present_inthehistory) :named REQ5_AUXILIARY3))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_symptoms_of_lower_urinary_tract_symptoms_now@@mild_severity patient_has_symptoms_of_lower_urinary_tract_symptoms_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_symptoms_of_lower_urinary_tract_symptoms_now@@severe_severity patient_has_symptoms_of_lower_urinary_tract_symptoms_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! patient_sex_is_male_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 50) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_diagnosis_of_lower_urinary_tract_symptoms_now patient_has_diagnosis_of_benign_prostatic_hyperplasia_now) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> international_prostate_symptom_score_value_recorded_now_withunit_points 12) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_symptoms_of_lower_urinary_tract_symptoms_now@@mild_severity patient_has_symptoms_of_lower_urinary_tract_symptoms_now@@severe_severity) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (> patient_volume_of_prostate_value_recorded_now_withunit_ml 50.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< patient_urinary_flow_rate_value_recorded_now_withunit_ml_per_second 15.0) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and patient_has_undergone_medical_therapy_inthehistory@@duration_at_least_6_months patient_has_undergone_medical_therapy_inthehistory@@outcome_ineffective) (and patient_has_finding_of_medication_side_effects_present_inthehistory@@caused_by_previous_medical_therapy patient_has_finding_of_medication_side_effects_present_inthehistory@@too_difficult_to_tolerate)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
