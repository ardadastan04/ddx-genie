;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_hepatitis_c_caused_by_hepatitis_c_virus_genotype_1_now Bool)
(declare-const patient_has_diagnosis_of_chronic_hepatitis_c_now Bool)
(declare-const patient_has_diagnosis_of_hepatitis_c_caused_by_hepatitis_c_virus_genotype_1_now Bool)
(declare-const patient_has_been_treated_for_viral_hepatitis_c_inthehistory Bool)
(declare-const patient_has_clinically_significant_laboratory_abnormality_now Bool)
(declare-const patient_hepatitis_c_virus_rna_value_recorded_now_withunit_international_units_per_milliliter Real)

;; Existing auxiliary assertions
(assert (! (= patient_has_diagnosis_of_chronic_hepatitis_c_caused_by_hepatitis_c_virus_genotype_1_now (and patient_has_diagnosis_of_chronic_hepatitis_c_now patient_has_diagnosis_of_hepatitis_c_caused_by_hepatitis_c_virus_genotype_1_now)) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_chronic_hepatitis_c_caused_by_hepatitis_c_virus_genotype_1_now patient_has_diagnosis_of_chronic_hepatitis_c_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_chronic_hepatitis_c_caused_by_hepatitis_c_virus_genotype_1_now patient_has_diagnosis_of_hepatitis_c_caused_by_hepatitis_c_virus_genotype_1_now) :named REQ0_AUXILIARY2))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_chronic_hepatitis_c_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_hepatitis_c_caused_by_hepatitis_c_virus_genotype_1_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_has_been_treated_for_viral_hepatitis_c_inthehistory) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_has_clinically_significant_laboratory_abnormality_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_hepatitis_c_virus_rna_value_recorded_now_withunit_international_units_per_milliliter 10000.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
