;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_abnormal_liver_function_now Bool)
(declare-const patient_has_diagnosis_of_type_b_viral_hepatitis_now Bool)
(declare-const patient_has_diagnosis_of_type_b_viral_hepatitis_now@@present_as_coinfection Bool)
(declare-const patient_has_diagnosis_of_human_immunodeficiency_virus_infection_now Bool)
(declare-const patient_has_diagnosis_of_human_immunodeficiency_virus_infection_now@@present_as_coinfection Bool)
(declare-const patient_has_diagnosis_of_other_unrelated_liver_disease_now Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplasm_of_liver_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_type_b_viral_hepatitis_now@@present_as_coinfection patient_has_diagnosis_of_type_b_viral_hepatitis_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_human_immunodeficiency_virus_infection_now@@present_as_coinfection patient_has_diagnosis_of_human_immunodeficiency_virus_infection_now) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_abnormal_liver_function_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_type_b_viral_hepatitis_now@@present_as_coinfection) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_human_immunodeficiency_virus_infection_now@@present_as_coinfection) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_other_unrelated_liver_disease_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_malignant_neoplasm_of_liver_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
