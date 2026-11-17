;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_has_clinical_diagnosis_of_chronic_pelvic_pain_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_non_menstrual_pelvic_pain_now Bool)
(declare-const patient_has_finding_of_noncyclic_pelvic_pain_now Bool)
(declare-const pain_duration_value_recorded_in_months Real)
(declare-const patient_has_finding_of_pain_inthehistory Bool)

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_clinical_diagnosis_of_chronic_pelvic_pain_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_age_value_recorded_now_in_years 18.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_non_menstrual_pelvic_pain_now patient_has_finding_of_noncyclic_pelvic_pain_now) :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_finding_of_pain_inthehistory (>= pain_duration_value_recorded_in_months 6.0)) :named REQ4_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
