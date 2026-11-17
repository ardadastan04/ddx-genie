;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_ductal_carcinoma_in_situ_of_breast_now Bool)
(declare-const patient_has_finding_of_ductal_carcinoma_in_situ_of_breast_now@@grade_iii Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_ductal_carcinoma_in_situ_of_breast_now@@grade_iii patient_has_finding_of_ductal_carcinoma_in_situ_of_breast_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_finding_of_ductal_carcinoma_in_situ_of_breast_now :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_ductal_carcinoma_in_situ_of_breast_now@@grade_iii :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
