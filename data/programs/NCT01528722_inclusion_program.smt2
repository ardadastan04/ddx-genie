;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_undergoing_cholecystectomy_now Bool)
(declare-const patient_is_undergoing_cholecystectomy_now@@emergency_procedure Bool)
(declare-const patient_has_diagnosis_of_cholecystitis_now Bool)
(declare-const patient_has_diagnosis_of_gallstone_pancreatitis_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_cholecystectomy_now@@emergency_procedure patient_is_undergoing_cholecystectomy_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (or (and patient_is_undergoing_cholecystectomy_now@@emergency_procedure patient_has_diagnosis_of_cholecystitis_now) (and patient_is_undergoing_cholecystectomy_now@@emergency_procedure patient_has_diagnosis_of_gallstone_pancreatitis_now)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
