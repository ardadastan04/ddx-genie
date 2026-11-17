;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_disease_now Bool)
(declare-const patient_has_diagnosis_of_chronic_disease_now@@not_primary_disease_under_study Bool)
(declare-const patient_has_diagnosis_of_autoimmune_disease_now Bool)
(declare-const patient_has_diagnosis_of_autoimmune_disease_now@@not_primary_disease_under_study Bool)
(declare-const patient_is_exposed_to_medication_now Bool)
(declare-const patient_is_exposed_to_medication_now@@excluding_l_thyroxine_prescribed_for_abnormal_thyroid_function_per_inclusion_criteria Bool)
(declare-const patient_is_exposed_to_thyroxine_now Bool)
(declare-const patient_is_exposed_to_thyroxine_now@@prescribed_for_abnormal_thyroid_function_per_inclusion_criteria Bool)
(declare-const patient_age_value_recorded_inthehistory_in_years Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_chronic_disease_now@@not_primary_disease_under_study patient_has_diagnosis_of_chronic_disease_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_autoimmune_disease_now@@not_primary_disease_under_study patient_has_diagnosis_of_autoimmune_disease_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_is_exposed_to_medication_now@@excluding_l_thyroxine_prescribed_for_abnormal_thyroid_function_per_inclusion_criteria patient_is_exposed_to_medication_now) :named REQ0_AUXILIARY2))
(assert (! (=> patient_is_exposed_to_thyroxine_now@@prescribed_for_abnormal_thyroid_function_per_inclusion_criteria patient_is_exposed_to_thyroxine_now) :named REQ0_AUXILIARY3))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_chronic_disease_now@@not_primary_disease_under_study) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_autoimmune_disease_now@@not_primary_disease_under_study) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_medication_now@@excluding_l_thyroxine_prescribed_for_abnormal_thyroid_function_per_inclusion_criteria) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not (> patient_age_value_recorded_inthehistory_in_years 18)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
