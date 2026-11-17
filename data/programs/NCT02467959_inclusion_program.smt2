;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_abdominal_pain_now Bool)
(declare-const patient_has_finding_of_abdominal_pain_now@@location_right_lower_abdomen Bool)
(declare-const patient_presented_with_complaint_of_abdominal_pain Bool)
(declare-const patient_presented_with_complaint_of_abdominal_pain@@location_right_lower_abdomen Bool)
(declare-const patient_has_suspicion_of_acute_appendicitis_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_abdominal_pain_now@@location_right_lower_abdomen patient_has_finding_of_abdominal_pain_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_presented_with_complaint_of_abdominal_pain@@location_right_lower_abdomen patient_presented_with_complaint_of_abdominal_pain) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! patient_presented_with_complaint_of_abdominal_pain@@location_right_lower_abdomen :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_suspicion_of_acute_appendicitis_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
