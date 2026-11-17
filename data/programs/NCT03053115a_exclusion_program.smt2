;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_undergoing_thyroid_stimulating_hormone_suppression_therapy_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_finding_of_cardiac_arrhythmia_now Bool)
(declare-const patient_has_diagnosis_of_disease_of_liver_now Bool)
(declare-const patient_has_diagnosis_of_disease_of_liver_now@@severe Bool)
(declare-const patient_has_diagnosis_of_kidney_disease_now Bool)
(declare-const patient_has_diagnosis_of_kidney_disease_now@@severe Bool)
(declare-const patient_has_diagnosis_of_disorder_of_bone_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_bone_now@@severe Bool)
(declare-const patient_is_undergoing_corticosteroid_and_or_corticosteroid_derivative_therapy_now Bool)
(declare-const patient_is_undergoing_corticosteroid_and_or_corticosteroid_derivative_therapy_now@@ongoing Bool)
(declare-const patient_is_taking_bone_resorption_inhibitor_containing_product_now Bool)
(declare-const patient_is_exposed_to_amiodarone_now Bool)
(declare-const patient_is_exposed_to_cholestyramine_now Bool)
(declare-const patient_is_exposed_to_iron_now Bool)
(declare-const patient_has_taken_bone_resorption_inhibitor_containing_product_inthepast12months Bool)
(declare-const patient_is_exposed_to_amiodarone_inthepast12months Bool)
(declare-const patient_is_exposed_to_cholestyramine_inthepast12months Bool)
(declare-const patient_is_exposed_to_iron_inthepast12months Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_disease_of_liver_now@@severe patient_has_diagnosis_of_disease_of_liver_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_kidney_disease_now@@severe patient_has_diagnosis_of_kidney_disease_now) :named REQ3_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_disorder_of_bone_now@@severe patient_has_diagnosis_of_disorder_of_bone_now) :named REQ3_AUXILIARY2))
(assert (! (=> patient_is_undergoing_corticosteroid_and_or_corticosteroid_derivative_therapy_now@@ongoing patient_is_undergoing_corticosteroid_and_or_corticosteroid_derivative_therapy_now) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_is_undergoing_thyroid_stimulating_hormone_suppression_therapy_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_cardiac_arrhythmia_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disease_of_liver_now@@severe) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_kidney_disease_now@@severe) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disorder_of_bone_now@@severe) :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_corticosteroid_and_or_corticosteroid_derivative_therapy_now@@ongoing) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_bone_resorption_inhibitor_containing_product_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_amiodarone_now) :named REQ5_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_cholestyramine_now) :named REQ5_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_iron_now) :named REQ5_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_taken_bone_resorption_inhibitor_containing_product_inthepast12months) :named REQ5_COMPONENT4_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_amiodarone_inthepast12months) :named REQ5_COMPONENT5_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_cholestyramine_inthepast12months) :named REQ5_COMPONENT6_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_iron_inthepast12months) :named REQ5_COMPONENT7_OTHER_REQUIREMENTS))
