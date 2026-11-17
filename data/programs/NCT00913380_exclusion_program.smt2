;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)
(declare-const intravenous_contrast_enhancement_is_contraindicated_for_patient Bool)

;; Other kept assertions
(assert (! (not (< patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 18.5)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not intravenous_contrast_enhancement_is_contraindicated_for_patient) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
