;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_pyuria_now Bool)
(declare-const patient_white_blood_cell_count_value_recorded_now_withunit_per_microliter Real)
(declare-const patient_white_blood_cell_count_value_recorded_now_withunit_per_microliter@@measured_in_unspun_urine Bool)
(declare-const patient_white_blood_cell_count_value_recorded_now_withunit_per_high_power_field Real)
(declare-const patient_white_blood_cell_count_value_recorded_now_withunit_per_high_power_field@@measured_in_spun_urine Bool)
(declare-const oral_temperature_value_recorded_now_in_celsius Real)
(declare-const patient_has_costovertebral_angle_tenderness_now Bool)
(declare-const patient_has_fever_now Bool)
(declare-const patient_has_finding_of_pyelonephritis_now Bool)
(declare-const patient_has_flank_pain_now Bool)
(declare-const patient_has_fever_by_oral_temperature_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_pyuria_now (or (and patient_white_blood_cell_count_value_recorded_now_withunit_per_microliter@@measured_in_unspun_urine (> patient_white_blood_cell_count_value_recorded_now_withunit_per_microliter 10)) (and patient_white_blood_cell_count_value_recorded_now_withunit_per_high_power_field@@measured_in_spun_urine (>= patient_white_blood_cell_count_value_recorded_now_withunit_per_high_power_field 10)))) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_fever_by_oral_temperature_now (and patient_has_fever_now (>= oral_temperature_value_recorded_now_in_celsius 37.8))) :named REQ2_AUXILIARY0))
(assert (! (= patient_has_finding_of_pyelonephritis_now (and patient_has_fever_by_oral_temperature_now (or patient_has_flank_pain_now patient_has_costovertebral_angle_tenderness_now))) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (or patient_sex_is_male_now (and patient_sex_is_female_now (>= patient_age_value_recorded_now_in_years 18) (<= patient_age_value_recorded_now_in_years 90))) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_pyuria_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_pyelonephritis_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
