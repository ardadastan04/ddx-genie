;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_asthma_now Bool)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent_predicted Real)
(declare-const patient_respiratory_flow_volume_loop_measurement_value_recorded_now_withunit_count Real)
(declare-const patient_respiratory_flow_volume_loop_measurement_value_recorded_now_withunit_count@@reproducible Bool)
(declare-const patient_has_moderate_bronchial_hyperresponsiveness_now Bool)
(declare-const patient_has_severe_bronchial_hyperresponsiveness_now Bool)
(declare-const pd20_fev1_value_recorded_now_withunit_mg_methacholine Real)
(declare-const patient_has_moderate_or_severe_bronchial_hyperresponsiveness_now Bool)
(declare-const patient_has_bronchial_hyperresponsiveness_now@@defined_by_pd20_fev1_leq_0_3mg_methacholine Bool)
(declare-const ipratropium_bromide_washout_period_value_in_weeks Real)
(declare-const patient_is_exposed_to_ipratropium_bromide_inthepast1weeks Bool)
(declare-const patient_is_exposed_to_beta_adrenergic_receptor_agonist_now Bool)
(declare-const patient_is_exposed_to_beta_adrenergic_receptor_agonist_now@@washout_period_long_acting_agent_greater_than_or_equal_1_week Bool)
(declare-const washout_period_long_acting_beta_agonist_value_in_weeks Real)
(declare-const patient_has_bronchial_hyperresponsiveness_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_moderate_or_severe_bronchial_hyperresponsiveness_now (or patient_has_moderate_bronchial_hyperresponsiveness_now patient_has_severe_bronchial_hyperresponsiveness_now)) :named REQ5_AUXILIARY0))
(assert (! (= patient_has_bronchial_hyperresponsiveness_now@@defined_by_pd20_fev1_leq_0_3mg_methacholine (<= pd20_fev1_value_recorded_now_withunit_mg_methacholine 0.3)) :named REQ5_AUXILIARY1))
(assert (! (= patient_has_moderate_or_severe_bronchial_hyperresponsiveness_now patient_has_bronchial_hyperresponsiveness_now@@defined_by_pd20_fev1_leq_0_3mg_methacholine) :named REQ5_AUXILIARY2))
(assert (! (=> (>= ipratropium_bromide_washout_period_value_in_weeks 1) (not patient_is_exposed_to_ipratropium_bromide_inthepast1weeks)) :named REQ8_AUXILIARY0))
(assert (! (= patient_is_exposed_to_beta_adrenergic_receptor_agonist_now@@washout_period_long_acting_agent_greater_than_or_equal_1_week (>= washout_period_long_acting_beta_agonist_value_in_weeks 1.0)) :named REQ9_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_beta_adrenergic_receptor_agonist_now@@washout_period_long_acting_agent_greater_than_or_equal_1_week patient_is_exposed_to_beta_adrenergic_receptor_agonist_now) :named REQ9_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_bronchial_hyperresponsiveness_now@@defined_by_pd20_fev1_leq_0_3mg_methacholine patient_has_bronchial_hyperresponsiveness_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 3) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 6) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_asthma_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent_predicted 70.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_respiratory_flow_volume_loop_measurement_value_recorded_now_withunit_count 2) patient_respiratory_flow_volume_loop_measurement_value_recorded_now_withunit_count@@reproducible) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_moderate_or_severe_bronchial_hyperresponsiveness_now :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
