;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_surgical_procedure_inthehistory Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory@@indication_nodular_goiter Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory@@performed_in_wanfang_hospital Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory@@indication_nodular_goiter@@performed_in_wanfang_hospital Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_surgical_procedure_inthehistory@@indication_nodular_goiter patient_has_undergone_surgical_procedure_inthehistory) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_surgical_procedure_inthehistory@@performed_in_wanfang_hospital patient_has_undergone_surgical_procedure_inthehistory) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_surgical_procedure_inthehistory@@indication_nodular_goiter@@performed_in_wanfang_hospital patient_has_undergone_surgical_procedure_inthehistory) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_undergone_surgical_procedure_inthehistory@@indication_nodular_goiter@@performed_in_wanfang_hospital patient_has_undergone_surgical_procedure_inthehistory@@indication_nodular_goiter) :named REQ0_AUXILIARY3))
(assert (! (=> patient_has_undergone_surgical_procedure_inthehistory@@indication_nodular_goiter@@performed_in_wanfang_hospital patient_has_undergone_surgical_procedure_inthehistory@@performed_in_wanfang_hospital) :named REQ0_AUXILIARY4))

;; Other kept assertions
(assert (! patient_has_undergone_surgical_procedure_inthehistory@@indication_nodular_goiter@@performed_in_wanfang_hospital :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
