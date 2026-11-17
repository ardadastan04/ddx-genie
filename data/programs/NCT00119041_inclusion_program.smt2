;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_taking_insulin_containing_product_now Bool)
(declare-const patient_is_taking_oral_hypoglycemic_agent_now Bool)
(declare-const patient_hemoglobin_a1c_measurement_value_recorded_now_withunit_percent Real)
(declare-const patient_fasting_blood_glucose_measurement_value_recorded_now_withunit_mg_dl Real)
(declare-const patient_has_diagnosis_of_type_1_diabetes_mellitus_now Bool)
(declare-const patient_has_diagnosis_of_type_2_diabetes_mellitus_now Bool)
(declare-const patient_has_primary_care_provider_for_cleveland_community_based_outpatient_center Bool)

;; Other kept assertions
(assert (! (or patient_is_taking_insulin_containing_product_now patient_is_taking_oral_hypoglycemic_agent_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_hemoglobin_a1c_measurement_value_recorded_now_withunit_percent 7.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_fasting_blood_glucose_measurement_value_recorded_now_withunit_mg_dl 130.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_diagnosis_of_type_1_diabetes_mellitus_now patient_has_diagnosis_of_type_2_diabetes_mellitus_now) :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_primary_care_provider_for_cleveland_community_based_outpatient_center :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
