;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_suspicion_of_acute_appendicitis_now Bool)
(declare-const patient_has_undergone_laparoscopy_now Bool)
(declare-const patient_has_undergone_laparoscopy_now@@diagnostic Bool)
(declare-const patient_has_planned_laparoscopy_now Bool)
(declare-const patient_has_planned_laparoscopy_now@@diagnostic Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_laparoscopy_now@@diagnostic patient_has_undergone_laparoscopy_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_planned_laparoscopy_now@@diagnostic patient_has_planned_laparoscopy_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! patient_has_suspicion_of_acute_appendicitis_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_undergone_laparoscopy_now@@diagnostic patient_has_planned_laparoscopy_now@@diagnostic) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
