;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_acromegaly_now Bool)
(declare-const patient_somatomedin_c_value_recorded_now_withunit_unit Real)
(declare-const upper_limit_of_normal_for_somatomedin_c_value_at_screening_withunit_unit Real)
(declare-const patient_has_undergone_radiotherapy_inthehistory Bool)
(declare-const patient_has_prior_treatment_with_other_drugs_for_acromegaly_inthehistory Bool)
(declare-const months_elapsed_since_patient_surgical_procedure_to_screening_in_months Real)
(declare-const patient_has_undergone_surgical_procedure_inthehistory Bool)

;; Other kept assertions
(assert (! patient_has_diagnosis_of_acromegaly_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_somatomedin_c_value_recorded_now_withunit_unit (* 1.3 upper_limit_of_normal_for_somatomedin_c_value_at_screening_withunit_unit)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (not patient_has_undergone_radiotherapy_inthehistory) (not patient_has_prior_treatment_with_other_drugs_for_acromegaly_inthehistory)) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_undergone_surgical_procedure_inthehistory (>= months_elapsed_since_patient_surgical_procedure_to_screening_in_months 2.0)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
