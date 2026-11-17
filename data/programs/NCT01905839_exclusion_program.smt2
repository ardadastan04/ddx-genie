;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_alcoholic_beverage_value_recorded_now_withunit_drinks_per_week Real)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_has_diagnosis_of_neoplasm_of_brain_inthehistory Bool)
(declare-const patient_has_diagnosis_of_cerebrovascular_accident_inthehistory Bool)
(declare-const patient_has_diagnosis_of_injury_of_head_inthehistory Bool)
(declare-const patient_has_diagnosis_of_epilepsy_inthehistory Bool)
(declare-const patient_has_diagnosis_of_seizure_inthehistory Bool)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_now Bool)
(declare-const patient_has_diagnosis_of_axis_i_diagnosis_now Bool)
(declare-const patient_has_diagnosis_of_mental_disorder_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_nervous_system_inthehistory Bool)
(declare-const patient_has_diagnosis_of_disorder_of_nervous_system_inthehistory@@other_than_movement_disorder Bool)
(declare-const patient_has_diagnosis_of_injury_of_head_inthehistory@@with_loss_of_consciousness_more_than_a_few_seconds Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_axis_i_diagnosis_now patient_has_diagnosis_of_mental_disorder_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_disorder_of_nervous_system_inthehistory@@other_than_movement_disorder patient_has_diagnosis_of_disorder_of_nervous_system_inthehistory) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_injury_of_head_inthehistory@@with_loss_of_consciousness_more_than_a_few_seconds patient_has_diagnosis_of_injury_of_head_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not (and patient_sex_is_female_now (> patient_alcoholic_beverage_value_recorded_now_withunit_drinks_per_week 7))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_sex_is_male_now (> patient_alcoholic_beverage_value_recorded_now_withunit_drinks_per_week 14))) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_neoplasm_of_brain_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_cerebrovascular_accident_inthehistory) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_injury_of_head_inthehistory) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_epilepsy_inthehistory) :named REQ1_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_seizure_inthehistory) :named REQ1_COMPONENT4_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_major_depressive_disorder_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_axis_i_diagnosis_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disorder_of_nervous_system_inthehistory@@other_than_movement_disorder) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_injury_of_head_inthehistory@@with_loss_of_consciousness_more_than_a_few_seconds) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
