;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_now Bool)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_now@@mild Bool)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_now@@severe Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_acute_pancreatitis_now@@mild patient_has_diagnosis_of_acute_pancreatitis_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_acute_pancreatitis_now@@severe patient_has_diagnosis_of_acute_pancreatitis_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (or patient_has_diagnosis_of_acute_pancreatitis_now@@mild patient_has_diagnosis_of_acute_pancreatitis_now@@severe) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
