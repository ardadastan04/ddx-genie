;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_receiving_dopaminergic_treatment_now Bool)
(declare-const duration_of_stable_dopaminergic_treatment_in_months Real)
(declare-const patient_has_medical_insurance_now Bool)

;; Other kept assertions
(assert (! patient_is_receiving_dopaminergic_treatment_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= duration_of_stable_dopaminergic_treatment_in_months 2.0) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_medical_insurance_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
