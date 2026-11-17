;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_hemodynamic_instability_now Bool)
(declare-const patient_has_finding_of_blood_coagulation_disorder_now Bool)
(declare-const patient_has_finding_of_blood_coagulation_disorder_now@@severe Bool)
(declare-const patient_refuses_to_participate Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_blood_coagulation_disorder_now@@severe patient_has_finding_of_blood_coagulation_disorder_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_hemodynamic_instability_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_blood_coagulation_disorder_now@@severe) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_refuses_to_participate) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
