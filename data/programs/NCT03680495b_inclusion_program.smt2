;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@physician_diagnosis Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_ex_smoker_now Bool)
(declare-const patient_has_finding_of_ex_smoker_now@@no_smoking_for_at_least_1_month Bool)
(declare-const patient_ex_smoker_months_since_last_smoked_value_recorded_now_withunit_months Real)
(declare-const patient_is_frequency_matched_to_ae_copd_subjects_for_age_now Bool)
(declare-const patient_is_frequency_matched_to_ae_copd_subjects_for_smoking_status_now Bool)
(declare-const patient_is_frequency_matched_to_ae_copd_subjects_for_lung_function_now Bool)
(declare-const patient_is_frequency_matched_to_ae_copd_subjects_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@physician_diagnosis patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_finding_of_ex_smoker_now@@no_smoking_for_at_least_1_month (and patient_has_finding_of_ex_smoker_now (>= patient_ex_smoker_months_since_last_smoked_value_recorded_now_withunit_months 1.0))) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_ex_smoker_now@@no_smoking_for_at_least_1_month patient_has_finding_of_ex_smoker_now) :named REQ2_AUXILIARY1))
(assert (! (= patient_is_frequency_matched_to_ae_copd_subjects_now (and patient_is_frequency_matched_to_ae_copd_subjects_for_age_now patient_is_frequency_matched_to_ae_copd_subjects_for_smoking_status_now patient_is_frequency_matched_to_ae_copd_subjects_for_lung_function_now)) :named REQ2_AUXILIARY2))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@physician_diagnosis :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 40.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_frequency_matched_to_ae_copd_subjects_for_age_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_frequency_matched_to_ae_copd_subjects_for_smoking_status_now :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_frequency_matched_to_ae_copd_subjects_for_lung_function_now :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
