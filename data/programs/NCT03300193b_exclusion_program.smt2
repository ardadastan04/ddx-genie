;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_completed_magnetic_resonance_guided_focused_ultrasound_surgery_procedure Bool)
(declare-const patient_has_finding_of_motor_function_now Bool)
(declare-const patient_has_finding_of_motor_function_now@@diagnosed_during_trial_after_enrollment Bool)
(declare-const patient_has_finding_of_quality_of_life_now Bool)
(declare-const patient_has_finding_of_quality_of_life_now@@affected_by_diagnosis_during_trial_after_enrollment Bool)
(declare-const patient_has_symptoms_of_tremor_now Bool)
(declare-const patient_has_symptoms_of_tremor_now@@affected_by_diagnosis_during_trial_after_enrollment Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_motor_function_now@@diagnosed_during_trial_after_enrollment patient_has_finding_of_motor_function_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_quality_of_life_now@@affected_by_diagnosis_during_trial_after_enrollment patient_has_finding_of_quality_of_life_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_symptoms_of_tremor_now@@affected_by_diagnosis_during_trial_after_enrollment patient_has_symptoms_of_tremor_now) :named REQ1_AUXILIARY2))

;; Other kept assertions
(assert (! (not (not patient_has_completed_magnetic_resonance_guided_focused_ultrasound_surgery_procedure)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_motor_function_now@@diagnosed_during_trial_after_enrollment) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_quality_of_life_now@@affected_by_diagnosis_during_trial_after_enrollment) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_symptoms_of_tremor_now@@affected_by_diagnosis_during_trial_after_enrollment) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
