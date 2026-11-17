;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
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
(declare-const patient_has_finding_of_asthma_inthehistory@@stated_by_doctor Bool)
(declare-const patient_has_finding_of_difficulty_breathing_inthepast12months Bool)
(declare-const patient_is_undergoing_prescription_now Bool)
(declare-const patient_is_undergoing_prescription_now@@for_inhaled_corticosteroid Bool)
(declare-const patient_is_undergoing_prescription_now@@duration_at_least_4_weeks Bool)
(declare-const patient_is_undergoing_prescription_now@@for_inhaled_corticosteroid@@duration_at_least_4_weeks Bool)
(declare-const patient_prescription_duration_now_for_inhaled_corticosteroid_in_weeks Real)
(declare-const patient_asthma_control_test_score_value_recorded_now_withunit_none Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_asthma_inthehistory@@stated_by_doctor patient_has_finding_of_asthma_inthehistory) :named REQ4_AUXILIARY0))
(assert (! (=> patient_is_undergoing_prescription_now@@for_inhaled_corticosteroid patient_is_undergoing_prescription_now) :named REQ5_AUXILIARY0))
(assert (! (=> patient_is_undergoing_prescription_now@@duration_at_least_4_weeks patient_is_undergoing_prescription_now) :named REQ5_AUXILIARY1))
(assert (! (=> patient_is_undergoing_prescription_now@@for_inhaled_corticosteroid@@duration_at_least_4_weeks patient_is_undergoing_prescription_now@@for_inhaled_corticosteroid) :named REQ5_AUXILIARY2))
(assert (! (=> patient_is_undergoing_prescription_now@@for_inhaled_corticosteroid@@duration_at_least_4_weeks patient_is_undergoing_prescription_now@@duration_at_least_4_weeks) :named REQ5_AUXILIARY3))
(assert (! (= patient_is_undergoing_prescription_now@@duration_at_least_4_weeks (>= patient_prescription_duration_now_for_inhaled_corticosteroid_in_weeks 4.0)) :named REQ5_AUXILIARY4))
(assert (! (= patient_is_undergoing_prescription_now@@for_inhaled_corticosteroid@@duration_at_least_4_weeks (and patient_is_undergoing_prescription_now patient_is_undergoing_prescription_now@@for_inhaled_corticosteroid patient_is_undergoing_prescription_now@@duration_at_least_4_weeks)) :named REQ5_AUXILIARY5))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_undergoing_prescription_now@@for_inhaled_corticosteroid@@duration_at_least_4_weeks patient_is_undergoing_prescription_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 12) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 15) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= caregiver_age_value_recorded_now_in_years 18) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= caregiver_age_value_recorded_now_in_years 70) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_lives_in_residence_of_caregiver :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_speak_english :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_able_to_read_english :named REQ3_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! caregiver_is_able_to_speak_english :named REQ3_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! caregiver_is_able_to_read_english :named REQ3_COMPONENT3_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_diagnosis_of_asthma_inthehistory patient_has_finding_of_asthma_inthehistory@@stated_by_doctor patient_has_finding_of_difficulty_breathing_inthepast12months) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_undergoing_prescription_now@@for_inhaled_corticosteroid@@duration_at_least_4_weeks :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_asthma_control_test_score_value_recorded_now_withunit_none 19) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
