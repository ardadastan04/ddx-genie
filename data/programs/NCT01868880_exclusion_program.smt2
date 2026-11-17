;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_inability_to_provide_informed_consent_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_lactating_now Bool)
(declare-const patient_has_finding_of_lactation_now Bool)
(declare-const patient_has_finding_of_myocardial_infarction_inthepast2months Bool)
(declare-const patient_has_contraindication_to_beta_adrenergic_receptor_antagonist_containing_product_now Bool)
(declare-const patient_has_contraindication_to_ivabradine_now Bool)
(declare-const patient_resting_heart_rate_value_recorded_now_withunit_beats_per_minute Real)
(declare-const patient_has_finding_of_sinus_rhythm_now Bool)
(declare-const patient_is_exposed_to_calcium_channel_blocker_now Bool)
(declare-const patient_is_exposed_to_calcium_channel_blocker_now@@non_dihydropyridinic Bool)
(declare-const patient_is_administered_digitalis_now Bool)
(declare-const patient_is_exposed_to_class_i_antiarrhythmic_agent_now Bool)
(declare-const patient_is_administered_strong_inhibitor_of_cytochrome_p450_3a4_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_lactating_now patient_has_finding_of_lactation_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_calcium_channel_blocker_now@@non_dihydropyridinic patient_is_exposed_to_calcium_channel_blocker_now) :named REQ7_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_inability_to_provide_informed_consent_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_lactating_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_myocardial_infarction_inthepast2months) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_beta_adrenergic_receptor_antagonist_containing_product_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_ivabradine_now) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (< patient_resting_heart_rate_value_recorded_now_withunit_beats_per_minute 70)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_has_finding_of_sinus_rhythm_now)) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_calcium_channel_blocker_now@@non_dihydropyridinic) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_administered_digitalis_now) :named REQ7_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_class_i_antiarrhythmic_agent_now) :named REQ7_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_is_administered_strong_inhibitor_of_cytochrome_p450_3a4_now) :named REQ7_COMPONENT3_OTHER_REQUIREMENTS))
