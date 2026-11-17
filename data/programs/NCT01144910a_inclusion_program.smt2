;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_asthma_now Bool)
(declare-const patient_percent_predicted_fev1_value_recorded_now_withunit_percent Real)
(declare-const patient_can_undergo_respiratory_flow_volume_loop_measurement_now Bool)
(declare-const patient_number_of_reproducible_flow_volume_loops_able_to_perform_now Real)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_milligram_methacholine Real)
(declare-const patient_has_moderate_bronchial_hyperresponsiveness_now Bool)
(declare-const patient_has_severe_bronchial_hyperresponsiveness_now Bool)
(declare-const patient_has_bronchial_hyperresponsiveness_now Bool)
(declare-const patient_bronchial_hyperresponsiveness_measured_by_pd20fev1_leq_0_3mg_methacholine_now Bool)
(declare-const patient_is_exposed_to_beta_adrenergic_receptor_agonist_inthehistory Bool)
(declare-const patient_is_exposed_to_beta_adrenergic_receptor_agonist_inthehistory@@washout_period_of_1_week_long_acting Bool)
(declare-const leukotriene_antagonist_washout_period_value_in_weeks Real)
(declare-const patient_is_exposed_to_leukotriene_receptor_antagonist_inthepast4weeks Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_bronchial_hyperresponsiveness_now (or patient_has_moderate_bronchial_hyperresponsiveness_now patient_has_severe_bronchial_hyperresponsiveness_now)) :named REQ5_AUXILIARY0))
(assert (! (= patient_bronchial_hyperresponsiveness_measured_by_pd20fev1_leq_0_3mg_methacholine_now (<= patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_milligram_methacholine 0.3)) :named REQ5_AUXILIARY1))
(assert (! (=> patient_has_bronchial_hyperresponsiveness_now patient_bronchial_hyperresponsiveness_measured_by_pd20fev1_leq_0_3mg_methacholine_now) :named REQ5_AUXILIARY2))
(assert (! (=> patient_is_exposed_to_beta_adrenergic_receptor_agonist_inthehistory@@washout_period_of_1_week_long_acting patient_is_exposed_to_beta_adrenergic_receptor_agonist_inthehistory) :named REQ9_AUXILIARY0))
(assert (! (=> (>= leukotriene_antagonist_washout_period_value_in_weeks 4) (not patient_is_exposed_to_leukotriene_receptor_antagonist_inthepast4weeks)) :named REQ11_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 3.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 6.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_asthma_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_percent_predicted_fev1_value_recorded_now_withunit_percent 70.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_can_undergo_respiratory_flow_volume_loop_measurement_now (>= patient_number_of_reproducible_flow_volume_loops_able_to_perform_now 2)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_moderate_bronchial_hyperresponsiveness_now patient_has_severe_bronchial_hyperresponsiveness_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
