;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_dilatation_of_common_bile_duct_now Bool)
(declare-const patient_has_finding_of_common_bile_duct_calculus_now Bool)
(declare-const patient_has_finding_of_common_bile_duct_calculus_now@@detected_by_trans_abdominal_ultrasound Bool)
(declare-const patient_has_finding_of_common_bile_duct_calculus_now@@detected_by_computed_tomography Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_common_bile_duct_calculus_now@@detected_by_trans_abdominal_ultrasound patient_has_finding_of_common_bile_duct_calculus_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_common_bile_duct_calculus_now@@detected_by_computed_tomography patient_has_finding_of_common_bile_duct_calculus_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (or patient_has_finding_of_dilatation_of_common_bile_duct_now patient_has_finding_of_common_bile_duct_calculus_now@@detected_by_trans_abdominal_ultrasound patient_has_finding_of_common_bile_duct_calculus_now@@detected_by_computed_tomography) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
