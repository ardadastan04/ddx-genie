;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_healthy_adult_female_now Bool)
(declare-const patient_has_finding_of_regular_periods_now Bool)
(declare-const menstrual_cycle_frequency_value_recorded_now_in_days Real)
(declare-const patient_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)
(declare-const patient_body_weight_value_recorded_now_withunit_kilograms Real)
(declare-const last_term_pregnancy_completion_to_study_admission_interval_value_in_months Real)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_lactating_now Bool)
(declare-const patient_has_finding_of_normal_menstrual_cycle_inthehistory@@occurred_since_last_term_pregnancy Bool)
(declare-const patient_is_breastfeeding_now Bool)
(declare-const sitting_systolic_blood_pressure_value_recorded_now_withunit_mm_hg Real)
(declare-const sitting_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg Real)
(declare-const patient_has_finding_of_normal_menstrual_cycle_inthehistory Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_normal_menstrual_cycle_inthehistory@@occurred_since_last_term_pregnancy patient_has_finding_of_normal_menstrual_cycle_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! patient_is_healthy_adult_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_finding_of_regular_periods_now (>= menstrual_cycle_frequency_value_recorded_now_in_days 25) (<= menstrual_cycle_frequency_value_recorded_now_in_days 35)) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (< patient_body_mass_index_value_recorded_now_withunit_kg_per_m2 30) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< patient_body_weight_value_recorded_now_withunit_kilograms 90.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and (>= last_term_pregnancy_completion_to_study_admission_interval_value_in_months 4.0) (not patient_is_pregnant_now)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_lactating_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_normal_menstrual_cycle_inthehistory@@occurred_since_last_term_pregnancy :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_is_breastfeeding_now) :named REQ2_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (< sitting_systolic_blood_pressure_value_recorded_now_withunit_mm_hg 140.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< sitting_diastolic_blood_pressure_value_recorded_now_withunit_mm_hg 90.0) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
