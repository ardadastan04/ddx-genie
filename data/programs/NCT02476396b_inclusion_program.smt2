;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_spouse_who_is_patient_subject Bool)
(declare-const patient_has_sibling_who_is_patient_subject Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_is_english_speaking Bool)

;; Other kept assertions
(assert (! (or patient_has_spouse_who_is_patient_subject patient_has_sibling_who_is_patient_subject) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_age_value_recorded_now_in_years 18.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_sex_is_male_now patient_sex_is_female_now) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_english_speaking :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
