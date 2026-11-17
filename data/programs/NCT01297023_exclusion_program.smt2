;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_lactating_now Bool)
(declare-const patient_is_exposed_to_nutritional_supplement_now Bool)
(declare-const patient_is_exposed_to_nutritional_supplement_now@@other_than_study_interventions_calcium_phosphate_or_vitamin_d Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_nutritional_supplement_now@@other_than_study_interventions_calcium_phosphate_or_vitamin_d patient_is_exposed_to_nutritional_supplement_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_is_pregnant_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_lactating_now) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_nutritional_supplement_now@@other_than_study_interventions_calcium_phosphate_or_vitamin_d) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
