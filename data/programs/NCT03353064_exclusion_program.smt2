;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_non_english_speaking Bool)
(declare-const patient_is_non_spanish_speaking Bool)
(declare-const patient_is_able_to_give_consent_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_prisoner_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_on_noninvasive_positive_pressure_ventilation_at_home Bool)
(declare-const patient_is_on_noninvasive_positive_pressure_ventilation_at_home@@compliant_on_therapy Bool)
(declare-const patient_is_on_continuous_positive_airway_pressure_at_home Bool)
(declare-const patient_is_on_continuous_positive_airway_pressure_at_home@@compliant_on_therapy Bool)
(declare-const patient_has_significant_non_pulmonary_condition_now Bool)
(declare-const patient_has_finding_of_congestive_heart_failure_now Bool)
(declare-const left_ventricular_ejection_fraction_value_recorded_now_withunit_percent Real)
(declare-const patient_has_finding_of_pulmonary_hypertension_now Bool)
(declare-const pulmonary_artery_systolic_pressure_value_recorded_now_withunit_mm_hg Real)
(declare-const patient_has_finding_of_severe_valvular_heart_disease_now Bool)
(declare-const patient_has_finding_of_end_stage_renal_disease_now Bool)
(declare-const patient_has_finding_of_end_stage_liver_disease_now Bool)
(declare-const patient_has_health_insurance_now Bool)
(declare-const patient_resides_in_pennsylvania_now Bool)
(declare-const patient_has_finding_of_substance_dependence_now Bool)
(declare-const patient_has_finding_of_substance_dependence_inthehistory Bool)
(declare-const patient_has_finding_of_opioid_dependence_now Bool)
(declare-const patient_has_finding_of_opioid_dependence_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_on_noninvasive_positive_pressure_ventilation_at_home@@compliant_on_therapy patient_is_on_noninvasive_positive_pressure_ventilation_at_home) :named REQ5_AUXILIARY0))
(assert (! (=> patient_is_on_continuous_positive_airway_pressure_at_home@@compliant_on_therapy patient_is_on_continuous_positive_airway_pressure_at_home) :named REQ5_AUXILIARY1))
(assert (! (=> (or (and patient_has_finding_of_congestive_heart_failure_now (< left_ventricular_ejection_fraction_value_recorded_now_withunit_percent 40)) (and patient_has_finding_of_pulmonary_hypertension_now (> pulmonary_artery_systolic_pressure_value_recorded_now_withunit_mm_hg 60)) patient_has_finding_of_severe_valvular_heart_disease_now patient_has_finding_of_end_stage_renal_disease_now patient_has_finding_of_end_stage_liver_disease_now) patient_has_significant_non_pulmonary_condition_now) :named REQ6_AUXILIARY0))

;; Other kept assertions
(assert (! (not (or patient_is_non_english_speaking patient_is_non_spanish_speaking)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_able_to_give_consent_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_prisoner_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or patient_is_on_noninvasive_positive_pressure_ventilation_at_home@@compliant_on_therapy patient_is_on_continuous_positive_airway_pressure_at_home@@compliant_on_therapy)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_significant_non_pulmonary_condition_now) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_health_insurance_now) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_resides_in_pennsylvania_now) :named REQ8_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or patient_has_finding_of_substance_dependence_now patient_has_finding_of_substance_dependence_inthehistory patient_has_finding_of_opioid_dependence_now patient_has_finding_of_opioid_dependence_inthehistory)) :named REQ9_COMPONENT0_OTHER_REQUIREMENTS))
