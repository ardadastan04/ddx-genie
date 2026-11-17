;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_hypersensitivity_condition_now Bool)
(declare-const patient_has_finding_of_hypersensitivity_condition_now@@to_tamsulosin Bool)
(declare-const patient_has_finding_of_hypersensitivity_condition_now@@to_any_other_component_of_the_product Bool)
(declare-const patient_has_finding_of_orthostatic_hypotension_inthehistory Bool)
(declare-const patient_has_finding_of_hepatic_failure_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_hypersensitivity_condition_now@@to_tamsulosin patient_has_finding_of_hypersensitivity_condition_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_hypersensitivity_condition_now@@to_any_other_component_of_the_product patient_has_finding_of_hypersensitivity_condition_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_hypersensitivity_condition_now@@to_tamsulosin) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hypersensitivity_condition_now@@to_any_other_component_of_the_product) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_orthostatic_hypotension_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hepatic_failure_inthehistory) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
