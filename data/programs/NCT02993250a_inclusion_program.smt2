;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_chronic_hepatitis_c_now Bool)
(declare-const patient_has_diagnosis_of_chronic_hepatitis_c_caused_by_hepatitis_c_virus_genotype_1_now Bool)
(declare-const patient_has_diagnosis_of_chronic_hepatitis_c_caused_by_hepatitis_c_virus_genotype_2_now Bool)
(declare-const patient_hepatitis_c_virus_rna_value_recorded_now_withunit_international_units_per_milliliter Real)
(declare-const patient_hepatitis_c_virus_rna_value_recorded_now_withunit_international_units_per_milliliter@@determined_at_screening Bool)
(declare-const patient_is_exposed_to_direct_acting_antiviral_for_hepatitis_c_virus_inthehistory Bool)
(declare-const patient_is_direct_acting_antiviral_naive Bool)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_direct_acting_antiviral_naive (not patient_is_exposed_to_direct_acting_antiviral_for_hepatitis_c_virus_inthehistory)) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_finding_of_chronic_hepatitis_c_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_diagnosis_of_chronic_hepatitis_c_caused_by_hepatitis_c_virus_genotype_1_now patient_has_diagnosis_of_chronic_hepatitis_c_caused_by_hepatitis_c_virus_genotype_2_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_hepatitis_c_virus_rna_value_recorded_now_withunit_international_units_per_milliliter@@determined_at_screening (>= patient_hepatitis_c_virus_rna_value_recorded_now_withunit_international_units_per_milliliter 10000.0)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_direct_acting_antiviral_naive :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_has_finding_of_cirrhosis_of_liver_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
