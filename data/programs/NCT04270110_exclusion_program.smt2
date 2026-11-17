;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_diabetes_mellitus_now Bool)
(declare-const patient_has_diagnosis_of_hypercortisolism_now Bool)
(declare-const patient_has_finding_of_hyperparathyroidism_now Bool)
(declare-const patient_has_finding_of_chronic_kidney_disease_now Bool)
(declare-const patient_is_undergoing_corticosteroid_and_or_corticosteroid_derivative_therapy_now Bool)
(declare-const patient_has_finding_of_inflammatory_disorder_now Bool)
(declare-const patient_has_finding_of_rheumatoid_arthritis_now Bool)
(declare-const patient_has_finding_of_systemic_lupus_erythematosus_now Bool)
(declare-const patient_has_finding_of_crohn_s_disease_now Bool)
(declare-const patient_has_finding_of_ulcerative_colitis_now Bool)
(declare-const patient_has_diagnosis_of_multiple_myeloma_now Bool)
(declare-const patient_has_diagnosis_of_myeloproliferative_disorder_now Bool)
(declare-const patient_has_hematological_condition_now Bool)
(declare-const patient_has_finding_of_vitamin_d_deficiency_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_postmenopausal_now Bool)
(declare-const patient_sex_is_female_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_rheumatoid_arthritis_now patient_has_finding_of_systemic_lupus_erythematosus_now patient_has_finding_of_crohn_s_disease_now patient_has_finding_of_ulcerative_colitis_now) patient_has_finding_of_inflammatory_disorder_now) :named REQ5_AUXILIARY0))
(assert (! (=> (or patient_has_diagnosis_of_multiple_myeloma_now patient_has_diagnosis_of_myeloproliferative_disorder_now) patient_has_hematological_condition_now) :named REQ6_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_diabetes_mellitus_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_hypercortisolism_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hyperparathyroidism_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_chronic_kidney_disease_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_corticosteroid_and_or_corticosteroid_derivative_therapy_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_inflammatory_disorder_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_hematological_condition_now) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_vitamin_d_deficiency_now) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_sex_is_male_now (> patient_age_value_recorded_now_in_years 55))) :named REQ8_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_sex_is_female_now patient_is_postmenopausal_now)) :named REQ9_COMPONENT0_OTHER_REQUIREMENTS))
