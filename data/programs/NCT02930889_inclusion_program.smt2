;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_lower_urinary_tract_symptoms_due_to_benign_prostatic_hypertrophy_now Bool)
(declare-const patient_has_diagnosis_of_lower_urinary_tract_symptoms_due_to_benign_prostatic_hypertrophy_now@@refractory_to_medical_therapy_for_at_least_6_months Bool)
(declare-const patient_total_international_prostate_symptom_score_value_recorded_now_withunit_score Real)
(declare-const patient_maximal_urinary_flow_rate_value_recorded_now_withunit_milliliters_per_second Real)
(declare-const patient_volume_of_prostate_value_recorded_now_withunit_grams Real)
(declare-const patient_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter Real)
(declare-const patient_free_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter Real)
(declare-const patient_total_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter Real)
(declare-const patient_has_undergone_biopsy_of_prostate_inthepast12months@@minimum_of_12_core_biopsy Bool)
(declare-const patient_has_undergone_biopsy_of_prostate_inthepast12months_outcome_is_negative Bool)
(declare-const patient_has_undergone_biopsy_of_prostate_inthepast12months_outcome_is_negative@@minimum_of_12_core_biopsy Bool)
(declare-const patient_has_undergone_digital_examination_of_rectum_now_outcome_is_abnormal Bool)
(declare-const patient_has_undergone_biopsy_of_prostate_inthepast12months Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_lower_urinary_tract_symptoms_due_to_benign_prostatic_hypertrophy_now@@refractory_to_medical_therapy_for_at_least_6_months patient_has_diagnosis_of_lower_urinary_tract_symptoms_due_to_benign_prostatic_hypertrophy_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_undergone_biopsy_of_prostate_inthepast12months_outcome_is_negative@@minimum_of_12_core_biopsy (and patient_has_undergone_biopsy_of_prostate_inthepast12months_outcome_is_negative patient_has_undergone_biopsy_of_prostate_inthepast12months@@minimum_of_12_core_biopsy)) :named REQ4_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_biopsy_of_prostate_inthepast12months@@minimum_of_12_core_biopsy patient_has_undergone_biopsy_of_prostate_inthepast12months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_undergone_biopsy_of_prostate_inthepast12months_outcome_is_negative@@minimum_of_12_core_biopsy patient_has_undergone_biopsy_of_prostate_inthepast12months_outcome_is_negative) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! patient_sex_is_male_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 45) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_lower_urinary_tract_symptoms_due_to_benign_prostatic_hypertrophy_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_lower_urinary_tract_symptoms_due_to_benign_prostatic_hypertrophy_now@@refractory_to_medical_therapy_for_at_least_6_months :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_total_international_prostate_symptom_score_value_recorded_now_withunit_score 12) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< patient_maximal_urinary_flow_rate_value_recorded_now_withunit_milliliters_per_second 15) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (> patient_volume_of_prostate_value_recorded_now_withunit_grams 40.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (<= patient_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter 2.5) (and (> patient_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter 2.5) (<= patient_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter 10.0) (>= (/ patient_free_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter patient_total_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter) 0.25)) (and (> patient_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter 2.5) (<= patient_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter 10.0) (< (/ patient_free_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter patient_total_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter) 0.25) patient_has_undergone_biopsy_of_prostate_inthepast12months_outcome_is_negative@@minimum_of_12_core_biopsy) (and (> patient_prostate_specific_antigen_value_recorded_now_withunit_nanograms_per_milliliter 10.0) patient_has_undergone_biopsy_of_prostate_inthepast12months_outcome_is_negative@@minimum_of_12_core_biopsy) (and patient_has_undergone_digital_examination_of_rectum_now_outcome_is_abnormal patient_has_undergone_biopsy_of_prostate_inthepast12months_outcome_is_negative@@minimum_of_12_core_biopsy)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
