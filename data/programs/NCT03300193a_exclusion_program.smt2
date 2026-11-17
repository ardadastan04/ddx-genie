;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_high_intensity_focused_ultrasound_ablation_inthehistory Bool)
(declare-const patient_has_undergone_high_intensity_focused_ultrasound_ablation_inthehistory@@procedure_completed Bool)
(declare-const patient_has_diagnosis_affecting_motor_function_or_quality_of_life_or_tremor_symptoms_during_trial Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_high_intensity_focused_ultrasound_ablation_inthehistory@@procedure_completed patient_has_undergone_high_intensity_focused_ultrasound_ablation_inthehistory) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_undergone_high_intensity_focused_ultrasound_ablation_inthehistory@@procedure_completed) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_affecting_motor_function_or_quality_of_life_or_tremor_symptoms_during_trial) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
