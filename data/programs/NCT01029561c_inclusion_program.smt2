;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter Real)
(declare-const patient_has_finding_of_obesity_associated_disorder_now Bool)
(declare-const patient_is_included_in_obesity_surgery_program_now Bool)
(declare-const patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@severe Bool)
(declare-const patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@diagnosed_at_baseline_polysomnography Bool)
(declare-const patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now Bool)
(declare-const patient_apnea_hypopnea_index_value_recorded_now_withunit_events_per_hour@@measured_at_baseline_polysomnography Bool)
(declare-const patient_apnea_hypopnea_index_value_recorded_now_withunit_events_per_hour Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@severe patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@diagnosed_at_baseline_polysomnography patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now) :named REQ3_AUXILIARY1))
(assert (! (=> patient_apnea_hypopnea_index_value_recorded_now_withunit_events_per_hour@@measured_at_baseline_polysomnography (>= patient_apnea_hypopnea_index_value_recorded_now_withunit_events_per_hour 0)) :named REQ3_AUXILIARY2))
(assert (! (= (and patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@severe patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@diagnosed_at_baseline_polysomnography) (and patient_apnea_hypopnea_index_value_recorded_now_withunit_events_per_hour@@measured_at_baseline_polysomnography (>= patient_apnea_hypopnea_index_value_recorded_now_withunit_events_per_hour 30))) :named REQ3_AUXILIARY3))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 65.0) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or (> patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 40.0) (and (> patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 35.0) patient_has_finding_of_obesity_associated_disorder_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_included_in_obesity_surgery_program_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@severe patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@diagnosed_at_baseline_polysomnography) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
