;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_carotid_artery_occlusion_now Bool)
(declare-const patient_has_finding_of_carotid_artery_occlusion_now@@contralateral Bool)
(declare-const patient_has_critical_stenosis_of_external_carotid_artery_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_carotid_artery_occlusion_now@@contralateral patient_has_finding_of_carotid_artery_occlusion_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_carotid_artery_occlusion_now@@contralateral) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_critical_stenosis_of_external_carotid_artery_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
