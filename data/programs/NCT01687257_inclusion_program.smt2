;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=4 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_hepatitis_c_now Bool)
(declare-const patient_hepatitis_c_virus_rna_value_recorded_now_withunit_international_units_per_milliliter Real)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now Bool)
(declare-const child_pugh_score_value_recorded_now_withunit_points Real)
(declare-const patient_has_finding_of_esophageal_varices_inthehistory@@identified_on_endoscopy Bool)
(declare-const patient_has_finding_of_esophageal_varices_inthehistory@@temporalcontext_within6months_prior_to_or_at_screening Bool)
(declare-const patient_has_finding_of_gastric_varices_inthehistory@@identified_on_endoscopy Bool)
(declare-const patient_has_finding_of_gastric_varices_inthehistory@@temporalcontext_within6months_prior_to_or_at_screening Bool)
(declare-const patient_wedge_pressure_determination_of_hepatic_vein_value_recorded_now_withunit_millimeters_of_mercury Real)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter Real)
(declare-const patient_is_exposed_to_nucleotide_inthehistory Bool)
(declare-const patient_is_exposed_to_nucleoside_inthehistory Bool)
(declare-const patient_is_naive_to_all_nucleotide_treatments_for_chronic_hepatitis_c_virus_infection Bool)
(declare-const patient_is_naive_to_all_nucleoside_treatments_for_chronic_hepatitis_c_virus_infection Bool)
(declare-const patient_has_finding_of_esophageal_varices_inthehistory Bool)
(declare-const patient_has_finding_of_gastric_varices_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_naive_to_all_nucleotide_treatments_for_chronic_hepatitis_c_virus_infection (not patient_is_exposed_to_nucleotide_inthehistory)) :named REQ5_AUXILIARY0))
(assert (! (= patient_is_naive_to_all_nucleoside_treatments_for_chronic_hepatitis_c_virus_infection (not patient_is_exposed_to_nucleoside_inthehistory)) :named REQ5_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_esophageal_varices_inthehistory@@identified_on_endoscopy patient_has_finding_of_esophageal_varices_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_esophageal_varices_inthehistory@@temporalcontext_within6months_prior_to_or_at_screening patient_has_finding_of_esophageal_varices_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_gastric_varices_inthehistory@@identified_on_endoscopy patient_has_finding_of_gastric_varices_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_finding_of_gastric_varices_inthehistory@@temporalcontext_within6months_prior_to_or_at_screening patient_has_finding_of_gastric_varices_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_chronic_hepatitis_c_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_hepatitis_c_virus_rna_value_recorded_now_withunit_international_units_per_milliliter 1000) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_cirrhosis_of_liver_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (< child_pugh_score_value_recorded_now_withunit_points 10) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or (and patient_has_finding_of_esophageal_varices_inthehistory@@identified_on_endoscopy patient_has_finding_of_esophageal_varices_inthehistory@@temporalcontext_within6months_prior_to_or_at_screening) (and patient_has_finding_of_gastric_varices_inthehistory@@identified_on_endoscopy patient_has_finding_of_gastric_varices_inthehistory@@temporalcontext_within6months_prior_to_or_at_screening)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_wedge_pressure_determination_of_hepatic_vein_value_recorded_now_withunit_millimeters_of_mercury 6.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 18.0) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_is_naive_to_all_nucleotide_treatments_for_chronic_hepatitis_c_virus_infection patient_is_naive_to_all_nucleoside_treatments_for_chronic_hepatitis_c_virus_infection) :named REQ5_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
