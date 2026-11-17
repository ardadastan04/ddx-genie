;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_malignant_neoplastic_disease_now Bool)
(declare-const patient_has_finding_of_acute_infectious_disease_now Bool)
(declare-const patient_has_finding_of_does_protrude_tongue_now Bool)
(declare-const patient_has_finding_of_does_protrude_tongue_now@@stably Bool)
(declare-const patient_has_risk_of_dislocation_of_temporomandibular_joint_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_does_protrude_tongue_now@@stably patient_has_finding_of_does_protrude_tongue_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_malignant_neoplastic_disease_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_acute_infectious_disease_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_does_protrude_tongue_now@@stably) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_risk_of_dislocation_of_temporomandibular_joint_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
