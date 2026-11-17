;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_maximal_urinary_flow_rate_value_recorded_now_withunit_ml_per_s Real)
(declare-const patient_total_international_prostate_symptom_score_value_recorded_now_withunit_score Real)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_volume_of_prostate_value_recorded_now_withunit_ml Real)
(declare-const patient_volume_of_prostate_value_recorded_now_withunit_ml@@determined_by_transrectal_ultrasound Bool)
(declare-const patient_residual_urine_volume_value_recorded_now_withunit_ml Real)
(declare-const patient_has_finding_of_ineffective_therapeutic_regimen_management_now Bool)

;; Other kept assertions
(assert (! (< patient_maximal_urinary_flow_rate_value_recorded_now_withunit_ml_per_s 12) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_total_international_prostate_symptom_score_value_recorded_now_withunit_score 19) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 50.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 70.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and (> patient_volume_of_prostate_value_recorded_now_withunit_ml 100.0) patient_volume_of_prostate_value_recorded_now_withunit_ml@@determined_by_transrectal_ultrasound) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_residual_urine_volume_value_recorded_now_withunit_ml 50.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_ineffective_therapeutic_regimen_management_now :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
