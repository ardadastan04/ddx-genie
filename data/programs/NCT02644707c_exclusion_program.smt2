;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_disease_now Bool)
(declare-const patient_has_diagnosis_of_chronic_disease_now@@excluding_autoimmune_thyroiditis Bool)
(declare-const patient_has_diagnosis_of_autoimmune_disease_now Bool)
(declare-const patient_has_diagnosis_of_autoimmune_disease_now@@excluding_autoimmune_thyroiditis Bool)
(declare-const patient_is_under_medication_now Bool)
(declare-const patient_is_under_medication_now@@excluding_treatment_related_to_autoimmune_thyroiditis Bool)
(declare-const patient_age_at_diagnosis_in_years Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_chronic_disease_now@@excluding_autoimmune_thyroiditis patient_has_diagnosis_of_chronic_disease_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_autoimmune_disease_now@@excluding_autoimmune_thyroiditis patient_has_diagnosis_of_autoimmune_disease_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_is_under_medication_now@@excluding_treatment_related_to_autoimmune_thyroiditis patient_is_under_medication_now) :named REQ0_AUXILIARY2))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_chronic_disease_now@@excluding_autoimmune_thyroiditis) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_autoimmune_disease_now@@excluding_autoimmune_thyroiditis) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_under_medication_now@@excluding_treatment_related_to_autoimmune_thyroiditis) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not (> patient_age_at_diagnosis_in_years 18)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
