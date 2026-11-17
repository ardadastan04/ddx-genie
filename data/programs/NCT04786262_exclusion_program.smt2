;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_transplantation_of_pancreatic_islet_cells_inthehistory Bool)
(declare-const patient_has_undergone_solid_organ_transplant_to_recipient_inthehistory Bool)
(declare-const patient_has_undergone_cell_therapy_inthehistory Bool)

;; Other kept assertions
(assert (! (not patient_has_undergone_transplantation_of_pancreatic_islet_cells_inthehistory) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_solid_organ_transplant_to_recipient_inthehistory) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_cell_therapy_inthehistory) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
