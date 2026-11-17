;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_inpatient_now Bool)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_now Bool)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_now@@diagnosed_per_revised_atlanta_classification Bool)
(declare-const patient_has_finding_of_abdominal_pain_consistent_with_acute_pancreatitis_now Bool)
(declare-const serum_lipase_activity_value_recorded_now_withunit_u_per_l Real)
(declare-const serum_amylase_activity_value_recorded_now_withunit_u_per_l Real)
(declare-const patient_has_characteristic_findings_of_acute_pancreatitis_on_computed_tomography_now Bool)
(declare-const patient_has_characteristic_findings_of_acute_pancreatitis_on_magnetic_resonance_imaging_now Bool)
(declare-const patient_has_characteristic_findings_of_acute_pancreatitis_on_transabdominal_ultrasonography_now Bool)
(declare-const serum_lipase_activity_upper_limit_of_normal_now_withunit_u_per_l Real)
(declare-const serum_amylase_activity_upper_limit_of_normal_now_withunit_u_per_l Real)
(declare-const serum_lipase_activity_at_least_three_times_uln_now Bool)
(declare-const serum_amylase_activity_at_least_three_times_uln_now Bool)
(declare-const patient_audit_c_alcohol_use_disorders_identification_test_consumption_score_value_recorded_now_withunit_score Real)
(define-fun acute_pancreatitis_evidence_count () Int (+ (ite patient_has_finding_of_abdominal_pain_consistent_with_acute_pancreatitis_now 1 0) (ite serum_lipase_activity_at_least_three_times_uln_now 1 0) (ite serum_amylase_activity_at_least_three_times_uln_now 1 0) (ite patient_has_characteristic_findings_of_acute_pancreatitis_on_computed_tomography_now 1 0) (ite patient_has_characteristic_findings_of_acute_pancreatitis_on_magnetic_resonance_imaging_now 1 0) (ite patient_has_characteristic_findings_of_acute_pancreatitis_on_transabdominal_ultrasonography_now 1 0)))

;; Existing auxiliary assertions
(assert (! (= serum_lipase_activity_at_least_three_times_uln_now (>= serum_lipase_activity_value_recorded_now_withunit_u_per_l (* 3.0 serum_lipase_activity_upper_limit_of_normal_now_withunit_u_per_l))) :named REQ1_AUXILIARY0))
(assert (! (= serum_amylase_activity_at_least_three_times_uln_now (>= serum_amylase_activity_value_recorded_now_withunit_u_per_l (* 3.0 serum_amylase_activity_upper_limit_of_normal_now_withunit_u_per_l))) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_acute_pancreatitis_now@@diagnosed_per_revised_atlanta_classification patient_has_diagnosis_of_acute_pancreatitis_now) :named REQ1_AUXILIARY2))
(assert (! (=> (>= acute_pancreatitis_evidence_count 2) patient_has_diagnosis_of_acute_pancreatitis_now@@diagnosed_per_revised_atlanta_classification) :named REQ1_AUXILIARY3))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 75.0) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and patient_is_inpatient_now patient_has_diagnosis_of_acute_pancreatitis_now@@diagnosed_per_revised_atlanta_classification) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_audit_c_alcohol_use_disorders_identification_test_consumption_score_value_recorded_now_withunit_score 3.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
