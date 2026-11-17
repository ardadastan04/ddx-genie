;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_disease_now Bool)
(declare-const patient_has_diagnosis_of_disease_now@@other_than_acute_pancreatitis Bool)
(declare-const patient_is_alcohol_abuser Bool)
(declare-const patient_is_drug_abuser Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_disease_now@@other_than_acute_pancreatitis patient_has_diagnosis_of_disease_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_disease_now@@other_than_acute_pancreatitis) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_alcohol_abuser) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_drug_abuser) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
