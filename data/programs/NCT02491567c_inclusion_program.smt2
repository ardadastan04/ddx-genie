;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=4 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_normal_general_body_function_now Bool)
(declare-const patient_is_child_now Bool)
(declare-const patient_is_adolescent_now Bool)
(declare-const patient_is_age_matched_with_other_patients_now Bool)
(declare-const patient_is_gender_matched_with_other_patients_now Bool)
(declare-const patient_has_diagnosis_of_autoimmune_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_atopy_inthehistory Bool)
(declare-const patient_is_exposed_to_histamine_receptor_antagonist_inthehistory@@chronic_treatment Bool)
(declare-const patient_is_exposed_to_anti_inflammatory_drug_inthehistory@@chronic_treatment Bool)
(declare-const patient_is_taking_corticosteroid_and_corticosteroid_derivative_containing_product_inthehistory@@chronic_treatment Bool)
(declare-const patient_is_exposed_to_anticonvulsant_inthehistory@@chronic_treatment Bool)
(declare-const patient_has_diagnosis_of_autoimmune_disease_inthehistory@@chronic Bool)
(declare-const patient_has_diagnosis_of_atopy_inthehistory@@chronic Bool)
(declare-const first_degree_relative_has_history_of_autoimmune_disease Bool)
(declare-const patient_is_exposed_to_anti_inflammatory_drug_inthehistory Bool)
(declare-const patient_is_exposed_to_anticonvulsant_inthehistory Bool)
(declare-const patient_is_exposed_to_histamine_receptor_antagonist_inthehistory Bool)
(declare-const patient_is_taking_corticosteroid_and_corticosteroid_derivative_containing_product_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_autoimmune_disease_inthehistory@@chronic patient_has_diagnosis_of_autoimmune_disease_inthehistory) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_atopy_inthehistory@@chronic patient_has_diagnosis_of_atopy_inthehistory) :named REQ1_AUXILIARY2))
(assert (! (=> (or patient_is_exposed_to_histamine_receptor_antagonist_inthehistory@@chronic_treatment patient_is_exposed_to_anti_inflammatory_drug_inthehistory@@chronic_treatment patient_is_taking_corticosteroid_and_corticosteroid_derivative_containing_product_inthehistory@@chronic_treatment patient_is_exposed_to_anticonvulsant_inthehistory@@chronic_treatment) patient_has_diagnosis_of_atopy_inthehistory@@chronic) :named REQ1_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_exposed_to_anti_inflammatory_drug_inthehistory@@chronic_treatment patient_is_exposed_to_anti_inflammatory_drug_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_is_exposed_to_anticonvulsant_inthehistory@@chronic_treatment patient_is_exposed_to_anticonvulsant_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_is_exposed_to_histamine_receptor_antagonist_inthehistory@@chronic_treatment patient_is_exposed_to_histamine_receptor_antagonist_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_is_taking_corticosteroid_and_corticosteroid_derivative_containing_product_inthehistory@@chronic_treatment patient_is_taking_corticosteroid_and_corticosteroid_derivative_containing_product_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))

;; Other kept assertions
(assert (! patient_has_finding_of_normal_general_body_function_now :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_is_child_now patient_is_adolescent_now) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_age_matched_with_other_patients_now :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_is_gender_matched_with_other_patients_now :named REQ0_COMPONENT3_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (not patient_has_diagnosis_of_autoimmune_disease_inthehistory@@chronic) (not patient_has_diagnosis_of_atopy_inthehistory@@chronic)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not first_degree_relative_has_history_of_autoimmune_disease) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
