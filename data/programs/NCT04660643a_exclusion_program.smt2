;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_diabetes_mellitus_now Bool)
(declare-const patient_weight_change_finding_value_recorded_inthepast3months_withunit_kilograms Real)
(declare-const patient_has_finding_of_obesity_of_endocrine_origin_now Bool)
(declare-const patient_has_finding_of_genetic_obesity_disorder_now Bool)
(declare-const patient_has_finding_of_syndromic_obesity_now Bool)
(declare-const patient_has_diagnosis_of_pancreatitis_inthehistory Bool)
(declare-const patient_has_family_history_of_medullary_thyroid_carcinoma Bool)
(declare-const patient_has_diagnosis_of_medullary_thyroid_carcinoma_inthehistory Bool)
(declare-const patient_has_family_history_of_multiple_endocrine_neoplasia_type_2 Bool)
(declare-const patient_has_diagnosis_of_multiple_endocrine_neoplasia_type_2_inthehistory Bool)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_inthepast2years Bool)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_inthepast2years@@significant_active_or_unstable Bool)
(declare-const patient_has_diagnosis_of_mental_disorder_inthepast2years Bool)
(declare-const patient_has_diagnosis_of_mental_disorder_inthepast2years@@severe Bool)
(declare-const patient_has_lifetime_history_of_suicide_attempt Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_major_depressive_disorder_inthepast2years@@significant_active_or_unstable patient_has_diagnosis_of_major_depressive_disorder_inthepast2years) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_mental_disorder_inthepast2years@@severe patient_has_diagnosis_of_mental_disorder_inthepast2years) :named REQ5_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_diabetes_mellitus_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> (abs patient_weight_change_finding_value_recorded_inthepast3months_withunit_kilograms) 5)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_obesity_of_endocrine_origin_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_genetic_obesity_disorder_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_syndromic_obesity_now) :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_pancreatitis_inthehistory) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_family_history_of_medullary_thyroid_carcinoma) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_medullary_thyroid_carcinoma_inthehistory) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_family_history_of_multiple_endocrine_neoplasia_type_2) :named REQ4_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_multiple_endocrine_neoplasia_type_2_inthehistory) :named REQ4_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_major_depressive_disorder_inthepast2years@@significant_active_or_unstable) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_mental_disorder_inthepast2years@@severe) :named REQ5_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_lifetime_history_of_suicide_attempt) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
