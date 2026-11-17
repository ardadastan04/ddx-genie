;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_has_diagnostic_code_491_20_in_andalusian_clinical_records_diraya_icd9 Bool)
(declare-const patient_has_diagnostic_code_492_8_in_andalusian_clinical_records_diraya_icd9 Bool)
(declare-const patient_has_diagnostic_code_493_2_in_andalusian_clinical_records_diraya_icd9 Bool)
(declare-const patient_has_diagnostic_code_494_0_in_andalusian_clinical_records_diraya_icd9 Bool)
(declare-const patient_has_diagnostic_code_496_in_andalusian_clinical_records_diraya_icd9 Bool)
(declare-const patient_has_any_inclusion_diagnostic_code_in_andalusian_clinical_records_diraya_icd9 Bool)
(declare-const patient_has_finding_of_smoker_now Bool)
(declare-const patient_has_finding_of_ex_smoker_inthehistory Bool)
(declare-const patient_pack_years_value_recorded_in_lifetime_withunit_pack_years Real)
(declare-const patient_follow_up_status_value_recorded_inthehistory_withunit_years Real)
(declare-const patient_has_been_assisted_in_scheduled_primary_care_appointment_at_inclusion_date Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_any_inclusion_diagnostic_code_in_andalusian_clinical_records_diraya_icd9 (or patient_has_diagnostic_code_496_in_andalusian_clinical_records_diraya_icd9 patient_has_diagnostic_code_492_8_in_andalusian_clinical_records_diraya_icd9 patient_has_diagnostic_code_494_0_in_andalusian_clinical_records_diraya_icd9 patient_has_diagnostic_code_491_20_in_andalusian_clinical_records_diraya_icd9 patient_has_diagnostic_code_493_2_in_andalusian_clinical_records_diraya_icd9)) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (or (and patient_sex_is_male_now (> patient_age_value_recorded_now_in_years 40)) (and patient_sex_is_female_now (> patient_age_value_recorded_now_in_years 40))) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_any_inclusion_diagnostic_code_in_andalusian_clinical_records_diraya_icd9 :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and patient_has_finding_of_smoker_now (>= patient_pack_years_value_recorded_in_lifetime_withunit_pack_years 10.0)) (and patient_has_finding_of_ex_smoker_inthehistory (>= patient_pack_years_value_recorded_in_lifetime_withunit_pack_years 10.0))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_follow_up_status_value_recorded_inthehistory_withunit_years 1.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_been_assisted_in_scheduled_primary_care_appointment_at_inclusion_date :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
