;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const mitral_valve_regurgitation_severity_grade_value_recorded_now_withunit_ase_grade Real)
(declare-const patient_has_finding_of_moderate_to_severe_mitral_valve_regurgitation_now Bool)
(declare-const patient_has_finding_of_severe_mitral_valve_regurgitation_now Bool)
(declare-const patient_has_finding_of_severe_mitral_valve_regurgitation_now@@caused_by_mitral_valve_prolapse Bool)
(declare-const patient_has_finding_of_severe_mitral_valve_regurgitation_now@@caused_by_mitral_valve_flail Bool)
(declare-const patient_has_high_surgical_risk_for_mitral_valve_repair_now Bool)
(declare-const patient_has_intermediate_surgical_risk_for_mitral_valve_repair_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_moderate_to_severe_mitral_valve_regurgitation_now (>= mitral_valve_regurgitation_severity_grade_value_recorded_now_withunit_ase_grade 3.0)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_finding_of_severe_mitral_valve_regurgitation_now (>= mitral_valve_regurgitation_severity_grade_value_recorded_now_withunit_ase_grade 4.0)) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_severe_mitral_valve_regurgitation_now@@caused_by_mitral_valve_prolapse patient_has_finding_of_severe_mitral_valve_regurgitation_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_finding_of_severe_mitral_valve_regurgitation_now@@caused_by_mitral_valve_flail patient_has_finding_of_severe_mitral_valve_regurgitation_now) :named REQ1_AUXILIARY3))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_moderate_to_severe_mitral_valve_regurgitation_now patient_has_finding_of_severe_mitral_valve_regurgitation_now@@caused_by_mitral_valve_prolapse patient_has_finding_of_severe_mitral_valve_regurgitation_now@@caused_by_mitral_valve_flail) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_intermediate_surgical_risk_for_mitral_valve_repair_now patient_has_high_surgical_risk_for_mitral_valve_repair_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
