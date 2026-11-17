;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_exposed_to_growth_hormone_receptor_antagonist_now Bool)
(declare-const patient_has_finding_of_acromegaly_inthehistory Bool)
(declare-const patient_has_finding_of_acromegaly_inthehistory@@never_received_any_treatment Bool)
(declare-const patient_is_in_treatment_control_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_acromegaly_inthehistory@@never_received_any_treatment patient_has_finding_of_acromegaly_inthehistory) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_is_exposed_to_growth_hormone_receptor_antagonist_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_acromegaly_inthehistory@@never_received_any_treatment) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_in_treatment_control_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
