;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)
(declare-const patient_is_exposed_to_hepatitis_c_virus_antibody_now Bool)
(declare-const patient_is_exposed_to_hepatitis_c_virus_rna_now Bool)
(declare-const patient_has_other_evidence_of_chronic_hepatitis_c_now Bool)
(declare-const patient_hepatitis_c_virus_rna_assay_value_recorded_now_withunit_international_units_per_milliliter Real)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const urine_pregnancy_test_result_value_recorded_now_withunit_binary Real)
(declare-const alanine_aminotransferase_value_recorded_now_withunit_u_per_l Real)
(declare-const upper_limit_of_normal_for_alanine_aminotransferase_value_withunit_u_per_l Real)

;; Existing auxiliary assertions
(assert (! (= patient_is_pregnant_now (= urine_pregnancy_test_result_value_recorded_now_withunit_binary 1)) :named REQ5_AUXILIARY0))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< patient_age_value_recorded_now_in_years 65) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 18.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 26.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or patient_is_exposed_to_hepatitis_c_virus_antibody_now patient_is_exposed_to_hepatitis_c_virus_rna_now patient_has_other_evidence_of_chronic_hepatitis_c_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_hepatitis_c_virus_rna_assay_value_recorded_now_withunit_international_units_per_milliliter 2000.0) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (not patient_sex_is_female_now) (= urine_pregnancy_test_result_value_recorded_now_withunit_binary 0)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= alanine_aminotransferase_value_recorded_now_withunit_u_per_l (* 6 upper_limit_of_normal_for_alanine_aminotransferase_value_withunit_u_per_l)) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
