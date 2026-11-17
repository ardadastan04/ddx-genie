;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_treated_at_royal_infirmary_edinburgh_now Bool)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_now Bool)
(declare-const patient_has_radiological_diagnosis_of_acute_pancreatitis_now Bool)
(declare-const patient_has_suspicion_of_acute_pancreatitis_now Bool)
(declare-const patient_has_appropriate_clinical_history_for_acute_pancreatitis_now Bool)
(declare-const patient_has_finding_of_abdominal_pain_now Bool)
(declare-const patient_has_finding_of_nausea_now Bool)
(declare-const patient_has_finding_of_vomiting_now Bool)
(declare-const patient_serum_amylase_raised_value_recorded_now_withunit_units_per_liter Real)
(declare-const reference_range_upper_limit_for_serum_amylase_now_withunit_units_per_liter Real)
(declare-const patient_has_elevated_serum_amylase_now Bool)
(declare-const patient_has_undergone_computerized_axial_tomography_now_outcome_is_positive Bool)
(declare-const patient_has_undergone_ultrasonography_now_outcome_is_positive Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_abdominal_pain_now patient_has_finding_of_nausea_now patient_has_finding_of_vomiting_now) patient_has_appropriate_clinical_history_for_acute_pancreatitis_now) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_elevated_serum_amylase_now (> patient_serum_amylase_raised_value_recorded_now_withunit_units_per_liter (* 3.0 reference_range_upper_limit_for_serum_amylase_now_withunit_units_per_liter))) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! patient_is_treated_at_royal_infirmary_edinburgh_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_diagnosis_of_acute_pancreatitis_now patient_has_radiological_diagnosis_of_acute_pancreatitis_now) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (=> patient_has_suspicion_of_acute_pancreatitis_now patient_has_appropriate_clinical_history_for_acute_pancreatitis_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (=> patient_has_suspicion_of_acute_pancreatitis_now patient_has_elevated_serum_amylase_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or (not patient_has_radiological_diagnosis_of_acute_pancreatitis_now) (or patient_has_undergone_computerized_axial_tomography_now_outcome_is_positive patient_has_undergone_ultrasonography_now_outcome_is_positive)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
