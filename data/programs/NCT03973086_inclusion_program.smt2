;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter Real)
(declare-const patient_country_of_residence_is_india_now Bool)
(declare-const patient_country_of_residence_is_united_states_of_america_now Bool)
(declare-const patient_waist_circumference_value_recorded_now_withunit_centimeters Real)
(declare-const patient_triglyceride_level_finding_value_recorded_now_withunit_milligrams_per_deciliter Real)
(declare-const patient_systolic_blood_pressure_value_recorded_now_withunit_millimeters_of_mercury Real)
(declare-const patient_diastolic_blood_pressure_value_recorded_now_withunit_millimeters_of_mercury Real)
(declare-const patient_fasting_blood_glucose_measurement_value_recorded_now_withunit_milligrams_per_deciliter Real)
(declare-const patient_high_density_lipoprotein_cholesterol_measurement_value_recorded_now_withunit_milligrams_per_deciliter Real)

;; Other kept assertions
(assert (! (or patient_sex_is_male_now (and patient_sex_is_female_now (>= patient_age_value_recorded_now_in_years 18.0) (<= patient_age_value_recorded_now_in_years 60.0))) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 25.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 35.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or (and patient_country_of_residence_is_india_now (or (and patient_sex_is_male_now (> patient_waist_circumference_value_recorded_now_withunit_centimeters 94.0)) (and patient_sex_is_female_now (> patient_waist_circumference_value_recorded_now_withunit_centimeters 80.0)))) (and patient_country_of_residence_is_united_states_of_america_now (or (and patient_sex_is_male_now (> patient_waist_circumference_value_recorded_now_withunit_centimeters 102.0)) (and patient_sex_is_female_now (> patient_waist_circumference_value_recorded_now_withunit_centimeters 89.0))))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_triglyceride_level_finding_value_recorded_now_withunit_milligrams_per_deciliter 150.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (>= patient_systolic_blood_pressure_value_recorded_now_withunit_millimeters_of_mercury 130.0) (>= patient_diastolic_blood_pressure_value_recorded_now_withunit_millimeters_of_mercury 85.0)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_fasting_blood_glucose_measurement_value_recorded_now_withunit_milligrams_per_deciliter 100.0) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and patient_sex_is_male_now (< patient_high_density_lipoprotein_cholesterol_measurement_value_recorded_now_withunit_milligrams_per_deciliter 40.0)) (and patient_sex_is_female_now (< patient_high_density_lipoprotein_cholesterol_measurement_value_recorded_now_withunit_milligrams_per_deciliter 50.0))) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
