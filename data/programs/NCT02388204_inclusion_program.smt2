;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_has_finding_of_abnormal_gait_now Bool)
(declare-const patient_has_finding_of_abnormal_gait_now@@is_main_complaint_or_main_symptom Bool)
(declare-const patient_has_finding_of_impaired_mobility_now Bool)
(declare-const patient_has_finding_of_impaired_mobility_now@@is_main_complaint_or_main_symptom Bool)
(declare-const patient_hoehn_and_yahr_scale_score_value_recorded_now_withunit_none Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_abnormal_gait_now@@is_main_complaint_or_main_symptom patient_has_finding_of_abnormal_gait_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_impaired_mobility_now@@is_main_complaint_or_main_symptom patient_has_finding_of_impaired_mobility_now) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_finding_of_abnormal_gait_now@@is_main_complaint_or_main_symptom patient_has_finding_of_impaired_mobility_now@@is_main_complaint_or_main_symptom) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_hoehn_and_yahr_scale_score_value_recorded_now_withunit_none 2.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
