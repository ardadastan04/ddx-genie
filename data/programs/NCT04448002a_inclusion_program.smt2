;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const caregiver_age_value_recorded_now_in_years Real)
(declare-const patient_lives_in_residence_of_caregiver Bool)
(declare-const patient_is_able_to_speak_english Bool)
(declare-const patient_is_able_to_read_english Bool)
(declare-const caregiver_is_able_to_speak_english Bool)
(declare-const caregiver_is_able_to_read_english Bool)
(declare-const patient_has_diagnosis_of_asthma_inthehistory Bool)
(declare-const patient_has_finding_of_asthma_inthehistory Bool)
(declare-const patient_has_finding_of_difficulty_breathing_inthepast12months Bool)
(declare-const duration_of_active_inhaled_corticosteroid_prescription_in_weeks Real)
(declare-const patient_has_finding_of_inhaled_steroids_use_now Bool)
(declare-const asthma_symptom_days_in_past_14_days_value_recorded_in_days Real)
(declare-const asthma_symptom_nighttime_awakening_days_in_past_14_days_value_recorded_in_nights Real)
(declare-const activity_limitation_days_due_to_asthma_or_wheezing_or_tightness_in_chest_or_cough_in_past_14_days_value_recorded_in_days Real)
(declare-const school_days_missed_due_to_asthma_or_wheezing_or_tightness_in_chest_or_cough_in_past_14_days_value_recorded_in_days Real)
(declare-const asthma_rescue_medicine_days_used_in_past_14_days_value_recorded_in_days Real)

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 12) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 15) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= caregiver_age_value_recorded_now_in_years 18) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= caregiver_age_value_recorded_now_in_years 70) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_lives_in_residence_of_caregiver :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_speak_english :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_read_english :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! caregiver_is_able_to_speak_english :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! caregiver_is_able_to_read_english :named REQ3_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (or patient_has_diagnosis_of_asthma_inthehistory patient_has_finding_of_asthma_inthehistory patient_has_finding_of_difficulty_breathing_inthepast12months) :named REQ4_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= duration_of_active_inhaled_corticosteroid_prescription_in_weeks 4) patient_has_finding_of_inhaled_steroids_use_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (> asthma_symptom_days_in_past_14_days_value_recorded_in_days 4) (>= asthma_symptom_nighttime_awakening_days_in_past_14_days_value_recorded_in_nights 1) (or (> activity_limitation_days_due_to_asthma_or_wheezing_or_tightness_in_chest_or_cough_in_past_14_days_value_recorded_in_days 4) (> school_days_missed_due_to_asthma_or_wheezing_or_tightness_in_chest_or_cough_in_past_14_days_value_recorded_in_days 4)) (> asthma_rescue_medicine_days_used_in_past_14_days_value_recorded_in_days 4)) :named REQ6_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
