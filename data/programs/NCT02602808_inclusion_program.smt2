;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_inthehistory Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Other kept assertions
(assert (! patient_has_diagnosis_of_acute_pancreatitis_inthehistory :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_sex_is_male_now patient_sex_is_female_now) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
