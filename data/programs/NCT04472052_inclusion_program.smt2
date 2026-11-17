;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_acute_appendicitis_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_undergone_appendectomy_inthehistory Bool)
(declare-const patient_has_undergone_appendectomy_inthehistory@@occurred_in_16_march_to_30_may_2018_or_2019_or_2020 Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_appendectomy_inthehistory@@occurred_in_16_march_to_30_may_2018_or_2019_or_2020 patient_has_undergone_appendectomy_inthehistory) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_acute_appendicitis_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_age_value_recorded_now_in_years 16) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_appendectomy_inthehistory@@occurred_in_16_march_to_30_may_2018_or_2019_or_2020 :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
