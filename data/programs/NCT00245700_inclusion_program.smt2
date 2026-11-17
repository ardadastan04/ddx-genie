;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_fulfills_united_kingdom_brain_bank_criteria_now Bool)
(declare-const levodopa_prescription_frequency_per_day_value_recorded_now_withunit_count Real)
(declare-const patient_is_taking_levodopa_containing_product_now Bool)
(declare-const patient_has_levodopa_prescribed_regularly_3_or_more_times_per_day_now Bool)
(declare-const patient_is_taking_entacapone_containing_product_now Bool)
(declare-const patient_is_taking_entacapone_containing_product_now@@required_because_of_wearing_off Bool)
(declare-const patient_is_able_to_manipulate_electronic_monitoring_bottles Bool)
(declare-const patient_is_able_to_complete_questionnaires Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_levodopa_prescribed_regularly_3_or_more_times_per_day_now (and patient_is_taking_levodopa_containing_product_now (>= levodopa_prescription_frequency_per_day_value_recorded_now_withunit_count 3))) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_taking_entacapone_containing_product_now@@required_because_of_wearing_off patient_is_taking_entacapone_containing_product_now) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= patient_age_value_recorded_now_in_years 18.0) (<= patient_age_value_recorded_now_in_years 85.0)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_fulfills_united_kingdom_brain_bank_criteria_now :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_has_levodopa_prescribed_regularly_3_or_more_times_per_day_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_taking_entacapone_containing_product_now@@required_because_of_wearing_off :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_manipulate_electronic_monitoring_bottles :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_complete_questionnaires :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
