;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_exposed_to_somatropin_inthehistory Bool)
(declare-const patient_has_y_component_in_karyotype_now Bool)
(declare-const patient_has_gonads_in_situ_now Bool)
(declare-const patient_has_diagnosis_of_diabetes_mellitus_now Bool)

;; Other kept assertions
(assert (! (not patient_is_exposed_to_somatropin_inthehistory) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_y_component_in_karyotype_now patient_has_gonads_in_situ_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_diabetes_mellitus_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
