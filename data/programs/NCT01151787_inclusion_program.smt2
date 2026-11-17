;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const headache_episode_duration_value_recorded_per_day_in_minutes Real)
(declare-const patient_has_headache_episode_value_recorded_per_28_days Real)
(declare-const patient_meets_ichd_2_revised_criteria_for_chronic_migraine_now Bool)
(declare-const patient_has_headache_episode_with_triptan_alleviation_days_per_month_value_recorded Real)
(declare-const patient_has_headache_episode_with_ergot_alleviation_days_per_month_value_recorded Real)
(declare-const patient_has_headache_episode_with_migrainous_feature_days_per_month_value_recorded Real)
(declare-const patient_can_accurately_complete_study_diaries Bool)
(declare-const patient_can_complete_study_instruments Bool)
(declare-const patient_can_complete_study_visits Bool)
(declare-const patient_can_undergo_blood_test_now Bool)
(declare-const patient_has_finding_of_headache_now@@treated_with_preventative_medications_at_stable_doses Bool)
(declare-const patient_is_able_to_perform_all_study_related_measures Bool)
(declare-const patient_has_finding_of_contraception_now@@used_for_the_duration_of_the_study Bool)
(declare-const patient_is_using_oral_contraceptive_medication_for_the_duration_of_the_study Bool)
(declare-const patient_is_using_intrauterine_device_for_the_duration_of_the_study Bool)
(declare-const patient_is_using_injectable_contraception_for_the_duration_of_the_study Bool)
(declare-const patient_is_using_intravaginal_contraception_for_the_duration_of_the_study Bool)
(declare-const patient_is_using_barrier_method_with_spermicide_for_the_duration_of_the_study Bool)
(declare-const patient_has_finding_of_contraception_now Bool)
(declare-const patient_has_finding_of_headache_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_able_to_perform_all_study_related_measures (and patient_can_accurately_complete_study_diaries patient_can_complete_study_instruments patient_has_finding_of_headache_now@@treated_with_preventative_medications_at_stable_doses patient_can_complete_study_visits patient_can_undergo_blood_test_now)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_finding_of_contraception_now@@used_for_the_duration_of_the_study (or patient_is_using_oral_contraceptive_medication_for_the_duration_of_the_study patient_is_using_intrauterine_device_for_the_duration_of_the_study patient_is_using_injectable_contraception_for_the_duration_of_the_study patient_is_using_intravaginal_contraception_for_the_duration_of_the_study patient_is_using_barrier_method_with_spermicide_for_the_duration_of_the_study)) :named REQ2_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_contraception_now@@used_for_the_duration_of_the_study patient_has_finding_of_contraception_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_headache_now@@treated_with_preventative_medications_at_stable_doses patient_has_finding_of_headache_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (and (>= patient_age_value_recorded_now_in_years 18.0) (<= patient_age_value_recorded_now_in_years 65.0)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (> headache_episode_duration_value_recorded_per_day_in_minutes 30.0) (>= patient_has_headache_episode_value_recorded_per_28_days 15.0)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_meets_ichd_2_revised_criteria_for_chronic_migraine_now :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (>= (+ patient_has_headache_episode_with_triptan_alleviation_days_per_month_value_recorded patient_has_headache_episode_with_ergot_alleviation_days_per_month_value_recorded patient_has_headache_episode_with_migrainous_feature_days_per_month_value_recorded) 8.0) :named REQ0_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_perform_all_study_related_measures :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
