;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_invasive_carcinoma_of_breast_now Bool)
(declare-const patient_has_diagnosis_of_invasive_carcinoma_of_breast_now@@newly_diagnosed Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_invasive_carcinoma_of_breast_now@@newly_diagnosed patient_has_diagnosis_of_invasive_carcinoma_of_breast_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_sex_is_female_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_invasive_carcinoma_of_breast_now@@newly_diagnosed :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
