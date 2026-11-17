;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const mini_mental_state_examination_score_value_recorded_now_withunit_points Real)
(declare-const patient_has_diagnosis_of_dementia_now Bool)
(declare-const patient_has_diagnosis_of_dementia_now@@significant Bool)
(declare-const patient_has_undergone_assessment_using_mini_mental_state_examination_now Bool)
(declare-const patient_has_diagnosis_of_psychotic_disorder_now Bool)
(declare-const patient_has_finding_of_severe_anxiety_now Bool)
(declare-const patient_has_finding_of_disorder_of_cardiovascular_system_now Bool)
(declare-const patient_has_finding_of_disorder_of_cardiovascular_system_now@@unstable Bool)
(declare-const patient_has_finding_of_poor_hypertension_control_now Bool)
(declare-const patient_has_diagnosis_of_cardiac_arrhythmia_inthehistory Bool)
(declare-const patient_has_finding_of_peptic_ulcer_now Bool)
(declare-const patient_has_finding_of_peptic_ulcer_now@@active Bool)
(declare-const hematocrit_value_recorded_now_withunit_percent Real)
(declare-const patient_has_finding_of_anemia_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_diagnosis_of_dementia_now@@significant (and patient_has_diagnosis_of_dementia_now patient_has_undergone_assessment_using_mini_mental_state_examination_now (<= mini_mental_state_examination_score_value_recorded_now_withunit_points 24))) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_dementia_now@@significant patient_has_diagnosis_of_dementia_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_disorder_of_cardiovascular_system_now@@unstable patient_has_finding_of_disorder_of_cardiovascular_system_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_peptic_ulcer_now@@active patient_has_finding_of_peptic_ulcer_now) :named REQ6_AUXILIARY0))
(assert (! (= patient_has_finding_of_anemia_now (< hematocrit_value_recorded_now_withunit_percent 32)) :named REQ7_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_dementia_now@@significant) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_psychotic_disorder_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_severe_anxiety_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_cardiovascular_system_now@@unstable) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_poor_hypertension_control_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_cardiac_arrhythmia_inthehistory) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_peptic_ulcer_now@@active) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_anemia_now) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
