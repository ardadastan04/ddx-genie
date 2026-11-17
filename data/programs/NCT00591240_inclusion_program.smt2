;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_suspicion_of_urinary_tract_infectious_disease_now@@complicated Bool)
(declare-const patient_has_finding_of_urinary_tract_infectious_disease_now@@at_risk Bool)
(declare-const patient_has_suspicion_of_urinary_tract_infectious_disease_now Bool)
(declare-const patient_has_finding_of_urinary_tract_infectious_disease_now Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_urinary_tract_infectious_disease_now@@at_risk patient_has_finding_of_urinary_tract_infectious_disease_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_suspicion_of_urinary_tract_infectious_disease_now@@complicated patient_has_suspicion_of_urinary_tract_infectious_disease_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (or patient_has_suspicion_of_urinary_tract_infectious_disease_now@@complicated patient_has_finding_of_urinary_tract_infectious_disease_now@@at_risk) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
