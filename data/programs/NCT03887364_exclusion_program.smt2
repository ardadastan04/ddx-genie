;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_injury_of_face_now Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory@@of_face Bool)
(declare-const patient_has_finding_of_sinusitis_now Bool)
(declare-const patient_has_finding_of_respiratory_failure_now Bool)
(declare-const patient_has_finding_of_dyspnea_now Bool)
(declare-const patient_has_finding_of_dyspnea_now@@of_cardiac_origin Bool)
(declare-const patient_has_diagnosis_of_allergic_rhinitis_now Bool)
(declare-const patient_has_diagnosis_of_acute_bronchitis_now Bool)
(declare-const patient_has_diagnosis_of_cystic_fibrosis_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_surgical_procedure_inthehistory@@of_face patient_has_undergone_surgical_procedure_inthehistory) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_dyspnea_now@@of_cardiac_origin patient_has_finding_of_dyspnea_now) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_injury_of_face_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_surgical_procedure_inthehistory@@of_face) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_sinusitis_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_respiratory_failure_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_dyspnea_now@@of_cardiac_origin) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_allergic_rhinitis_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_acute_bronchitis_now) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_cystic_fibrosis_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
