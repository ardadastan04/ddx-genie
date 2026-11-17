;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_has_finding_of_benign_prostatic_hyperplasia_now Bool)
(declare-const patient_has_finding_of_benign_prostatic_hyperplasia_now@@symptomatic Bool)
(declare-const patient_total_international_prostate_symptom_score_value_recorded_now_withunit_score Real)
(declare-const patient_maximal_urinary_flow_rate_value_recorded_now_withunit_milliliters_per_second Real)
(declare-const patient_voided_urinary_volume_value_recorded_now_withunit_cubic_centimeters Real)
(declare-const patient_volume_of_prostate_value_recorded_now_withunit_milliliters Real)
(declare-const patient_volume_of_prostate_value_recorded_now_withunit_milliliters@@assessed_by_transrectal_ultrasound Bool)
(declare-const patient_is_able_to_complete_study_protocol Bool)
(declare-const patient_has_undergone_urinalysis_now_outcome_is_normal Bool)
(declare-const patient_has_undergone_urine_culture_now_outcome_is_normal Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_benign_prostatic_hyperplasia_now@@symptomatic patient_has_finding_of_benign_prostatic_hyperplasia_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! patient_sex_is_male_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_benign_prostatic_hyperplasia_now@@symptomatic :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_total_international_prostate_symptom_score_value_recorded_now_withunit_score 10) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (< patient_maximal_urinary_flow_rate_value_recorded_now_withunit_milliliters_per_second 12.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_voided_urinary_volume_value_recorded_now_withunit_cubic_centimeters 120.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_volume_of_prostate_value_recorded_now_withunit_milliliters 25) patient_volume_of_prostate_value_recorded_now_withunit_milliliters@@assessed_by_transrectal_ultrasound) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (<= patient_volume_of_prostate_value_recorded_now_withunit_milliliters 80) patient_volume_of_prostate_value_recorded_now_withunit_milliliters@@assessed_by_transrectal_ultrasound) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_complete_study_protocol :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_urinalysis_now_outcome_is_normal :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_urine_culture_now_outcome_is_normal :named REQ5_COMPONENT1_OTHER_REQUIREMENTS))
