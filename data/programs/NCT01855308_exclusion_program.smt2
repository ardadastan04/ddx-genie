;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_operation_on_abdominal_region_inthehistory Bool)
(declare-const patient_has_undergone_operation_on_abdominal_region_inthehistory@@open Bool)
(declare-const patient_has_undergone_operation_on_abdominal_region_inthehistory@@significant Bool)
(declare-const patient_has_undergone_operation_on_abdominal_region_inthehistory@@open@@significant Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_operation_on_abdominal_region_inthehistory@@open patient_has_undergone_operation_on_abdominal_region_inthehistory) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_operation_on_abdominal_region_inthehistory@@significant patient_has_undergone_operation_on_abdominal_region_inthehistory) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_operation_on_abdominal_region_inthehistory@@open@@significant (and patient_has_undergone_operation_on_abdominal_region_inthehistory@@open patient_has_undergone_operation_on_abdominal_region_inthehistory@@significant)) :named REQ0_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_operation_on_abdominal_region_inthehistory@@open@@significant patient_has_undergone_operation_on_abdominal_region_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not patient_has_undergone_operation_on_abdominal_region_inthehistory@@open@@significant) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
