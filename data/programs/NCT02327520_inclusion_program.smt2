;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_clostridioides_difficile_infection_now Bool)
(declare-const patient_has_diagnosis_of_clostridioides_difficile_infection_now@@diagnosed_according_to_icd10_code_a07 Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_clostridioides_difficile_infection_now@@diagnosed_according_to_icd10_code_a07 patient_has_diagnosis_of_clostridioides_difficile_infection_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (and patient_has_diagnosis_of_clostridioides_difficile_infection_now patient_has_diagnosis_of_clostridioides_difficile_infection_now@@diagnosed_according_to_icd10_code_a07) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
