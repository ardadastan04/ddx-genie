;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_man Bool)
(declare-const patient_is_seeking_further_treatment_for_lower_urinary_tract_symptoms_now Bool)
(declare-const patient_has_finding_of_lower_urinary_tract_symptoms_now@@bothersome Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory Bool)
(declare-const patient_has_finding_of_lower_urinary_tract_symptoms_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_surgical_procedure_inthehistory patient_is_seeking_further_treatment_for_lower_urinary_tract_symptoms_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_seeking_further_treatment_for_lower_urinary_tract_symptoms_now patient_has_finding_of_lower_urinary_tract_symptoms_now@@bothersome) :named REQ0_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_lower_urinary_tract_symptoms_now@@bothersome patient_has_finding_of_lower_urinary_tract_symptoms_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! patient_is_man :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_seeking_further_treatment_for_lower_urinary_tract_symptoms_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
