;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_hepatitis_c_now Bool)
(declare-const patient_has_hepatitis_c_virus_genotype_1_infection_determined_at_screening Bool)
(declare-const patient_has_hepatitis_c_virus_genotype_2_infection_determined_at_screening Bool)
(declare-const patient_hepatitis_c_virus_rna_value_recorded_now_withunit_international_units_per_milliliter Real)
(declare-const patient_is_exposed_to_direct_acting_antiviral_inthehistory Bool)
(declare-const patient_is_exposed_to_direct_acting_antiviral_inthehistory@@for_hepatitis_c_virus Bool)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now Bool)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now@@compensated Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_direct_acting_antiviral_inthehistory@@for_hepatitis_c_virus patient_is_exposed_to_direct_acting_antiviral_inthehistory) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_cirrhosis_of_liver_now@@compensated patient_has_finding_of_cirrhosis_of_liver_now) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_chronic_hepatitis_c_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_hepatitis_c_virus_genotype_1_infection_determined_at_screening patient_has_hepatitis_c_virus_genotype_2_infection_determined_at_screening) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_hepatitis_c_virus_rna_value_recorded_now_withunit_international_units_per_milliliter 10000.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_direct_acting_antiviral_inthehistory@@for_hepatitis_c_virus) :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_cirrhosis_of_liver_now@@compensated :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
