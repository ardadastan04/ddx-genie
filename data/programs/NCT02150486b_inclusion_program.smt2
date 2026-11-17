;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=6 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_undergoing_operation_on_abdominal_region_now Bool)
(declare-const patient_is_undergoing_operation_on_colorectum_now Bool)
(declare-const patient_is_undergoing_operation_on_stomach_now Bool)
(declare-const patient_is_undergoing_operation_on_pancreas_now Bool)
(declare-const patient_is_undergoing_operation_on_liver_now Bool)
(declare-const patient_mortality_rate_value_recorded_now_withunit_percent Real)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_minor_cardiovascular_risk_factor_count_now Int)
(declare-const patient_has_diagnosis_of_hypertensive_disorder_now Bool)
(declare-const patient_has_diagnosis_of_hypercholesterolemia_now Bool)
(declare-const patient_metabolic_equivalent_of_task_value_recorded_now_withunit_met Real)
(declare-const patient_has_diagnosis_of_transient_cerebral_ischemia_now Bool)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_minor_cardiovascular_risk_factor_now@@age_greater_than_70_years Bool)
(declare-const patient_minor_cardiovascular_risk_factor_now@@hypertension Bool)
(declare-const patient_minor_cardiovascular_risk_factor_now@@high_cholesterol Bool)
(declare-const patient_minor_cardiovascular_risk_factor_now@@low_functional_capacity Bool)
(declare-const patient_minor_cardiovascular_risk_factor_now@@transient_ischemic_attack Bool)
(declare-const patient_minor_cardiovascular_risk_factor_now@@chronic_obstructive_pulmonary_disease Bool)
(declare-const patient_minor_cardiovascular_risk_factor_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_is_undergoing_operation_on_colorectum_now patient_is_undergoing_operation_on_stomach_now patient_is_undergoing_operation_on_pancreas_now patient_is_undergoing_operation_on_liver_now) patient_is_undergoing_operation_on_abdominal_region_now) :named REQ0_AUXILIARY0))
(assert (! (=> (> patient_age_value_recorded_now_in_years 70) patient_minor_cardiovascular_risk_factor_now@@age_greater_than_70_years) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_hypertensive_disorder_now patient_minor_cardiovascular_risk_factor_now@@hypertension) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_hypercholesterolemia_now patient_minor_cardiovascular_risk_factor_now@@high_cholesterol) :named REQ1_AUXILIARY2))
(assert (! (= patient_minor_cardiovascular_risk_factor_now@@low_functional_capacity (<= patient_metabolic_equivalent_of_task_value_recorded_now_withunit_met 4)) :named REQ1_AUXILIARY3))
(assert (! (=> patient_has_diagnosis_of_transient_cerebral_ischemia_now patient_minor_cardiovascular_risk_factor_now@@transient_ischemic_attack) :named REQ1_AUXILIARY4))
(assert (! (=> patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now patient_minor_cardiovascular_risk_factor_now@@chronic_obstructive_pulmonary_disease) :named REQ1_AUXILIARY5))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_minor_cardiovascular_risk_factor_now@@age_greater_than_70_years patient_minor_cardiovascular_risk_factor_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_minor_cardiovascular_risk_factor_now@@chronic_obstructive_pulmonary_disease patient_minor_cardiovascular_risk_factor_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_minor_cardiovascular_risk_factor_now@@high_cholesterol patient_minor_cardiovascular_risk_factor_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_minor_cardiovascular_risk_factor_now@@hypertension patient_minor_cardiovascular_risk_factor_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_minor_cardiovascular_risk_factor_now@@low_functional_capacity patient_minor_cardiovascular_risk_factor_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))
(assert (! (=> patient_minor_cardiovascular_risk_factor_now@@transient_ischemic_attack patient_minor_cardiovascular_risk_factor_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_5))

;; Other kept assertions
(assert (! patient_is_undergoing_operation_on_abdominal_region_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_mortality_rate_value_recorded_now_withunit_percent 3.0) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_age_value_recorded_now_in_years 45) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_minor_cardiovascular_risk_factor_count_now 2) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
