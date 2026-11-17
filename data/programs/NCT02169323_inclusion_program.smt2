;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=3
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_cough_now Bool)
(declare-const patient_has_finding_of_dyspnea_now Bool)
(declare-const patient_has_finding_of_tight_chest_now Bool)
(declare-const patient_has_finding_of_wheezing_now Bool)
(declare-const patient_has_physician_diagnosed_asthma_now Bool)
(declare-const patient_has_typical_asthma_symptom_now Bool)
(declare-const patient_has_diagnosis_of_asthma_now Bool)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent Real)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent@@after_inhalation_of_400_micrograms_salbutamol Bool)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_milliliters Real)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_milliliters@@after_inhalation_of_400_micrograms_salbutamol Bool)
(declare-const patient_methacholine_pc20_value_recorded_now_withunit_milligrams_per_milliliter Real)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent@@after_exposure_to_methacholine Bool)
(declare-const patient_is_exposed_to_methacholine_now Bool)
(declare-const patient_asthma_confirmed_by_protocol_now Bool)
(declare-const patient_sputum_eosinophils_rate_value_recorded_now_withunit_percent Real)
(declare-const absolute_blood_eosinophils_count_value_recorded_in_cubic_millimeter Real)
(declare-const patient_has_undergone_inhaled_steroid_therapy_inthepast3months Bool)
(declare-const patient_has_undergone_inhaled_steroid_therapy_inthepast3months@@administered_at_a_stable_dose Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_typical_asthma_symptom_now (or patient_has_finding_of_wheezing_now patient_has_finding_of_dyspnea_now patient_has_finding_of_tight_chest_now patient_has_finding_of_cough_now)) :named REQ1_AUXILIARY0))
(assert (! (= patient_asthma_confirmed_by_protocol_now (or (and patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent@@after_inhalation_of_400_micrograms_salbutamol (>= patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent 12.0) patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_milliliters@@after_inhalation_of_400_micrograms_salbutamol (>= patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_milliliters 200.0)) (and patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent@@after_exposure_to_methacholine patient_is_exposed_to_methacholine_now (< patient_methacholine_pc20_value_recorded_now_withunit_milligrams_per_milliliter 16.0)))) :named REQ2_AUXILIARY0))
(assert (! (=> patient_asthma_confirmed_by_protocol_now patient_has_diagnosis_of_asthma_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_undergone_inhaled_steroid_therapy_inthepast3months@@administered_at_a_stable_dose patient_has_undergone_inhaled_steroid_therapy_inthepast3months) :named REQ5_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_physician_diagnosed_asthma_now patient_has_typical_asthma_symptom_now) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_asthma_confirmed_by_protocol_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< patient_sputum_eosinophils_rate_value_recorded_now_withunit_percent 3.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< absolute_blood_eosinophils_count_value_recorded_in_cubic_millimeter 400) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_inhaled_steroid_therapy_inthepast3months@@administered_at_a_stable_dose :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
