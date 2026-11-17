;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_general_health_good_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_serum_triglyceride_levels_finding_value_recorded_now_withunit_milligrams_per_deciliter Real)
(declare-const patient_serum_ldl_cholesterol_measurement_value_recorded_now_withunit_milligrams_per_deciliter Real)
(declare-const patient_is_using_other_product_for_control_of_serum_lipids_now Bool)
(declare-const patient_is_taking_antilipemic_agent_now Bool)
(declare-const patient_is_using_medical_food_for_control_of_serum_lipids_now Bool)
(declare-const patient_is_using_nutraceutical_for_control_of_serum_lipids_now Bool)
(declare-const patient_is_using_dietary_supplement_for_control_of_serum_lipids_now Bool)
(declare-const patient_has_finding_of_dietary_finding_now Bool)
(declare-const patient_has_finding_of_dietary_finding_now@@consistent Bool)
(declare-const patient_can_read_and_understand_study_documents_now Bool)
(declare-const patient_can_read_and_understand_study_documents_now@@spanish_language_translation_available_if_needed Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_is_taking_antilipemic_agent_now patient_is_using_medical_food_for_control_of_serum_lipids_now patient_is_using_nutraceutical_for_control_of_serum_lipids_now patient_is_using_dietary_supplement_for_control_of_serum_lipids_now) patient_is_using_other_product_for_control_of_serum_lipids_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_dietary_finding_now@@consistent patient_has_finding_of_dietary_finding_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_can_read_and_understand_study_documents_now@@spanish_language_translation_available_if_needed patient_can_read_and_understand_study_documents_now) :named REQ6_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_finding_of_general_health_good_now :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_age_value_recorded_now_in_years 25.0) (<= patient_age_value_recorded_now_in_years 85.0)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_serum_triglyceride_levels_finding_value_recorded_now_withunit_milligrams_per_deciliter 150.0) (<= patient_serum_triglyceride_levels_finding_value_recorded_now_withunit_milligrams_per_deciliter 495.0)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_serum_ldl_cholesterol_measurement_value_recorded_now_withunit_milligrams_per_deciliter 70.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_using_other_product_for_control_of_serum_lipids_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_dietary_finding_now@@consistent :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_can_read_and_understand_study_documents_now :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
