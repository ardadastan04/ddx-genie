;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosis_meets_united_kingdom_brain_bank_criteria Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosis_made_within_study_centres Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosis_meets_united_kingdom_brain_bank_criteria patient_has_diagnosis_of_parkinson_s_disease_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosis_made_within_study_centres patient_has_diagnosis_of_parkinson_s_disease_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosis_meets_united_kingdom_brain_bank_criteria :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosis_made_within_study_centres :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
