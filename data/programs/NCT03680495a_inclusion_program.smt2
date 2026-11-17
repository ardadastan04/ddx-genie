;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_diagnosis_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_now@@diagnosed_by_emergency_department_physician Bool)
(declare-const patient_has_diagnosis_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_now@@diagnosed_by_intensive_care_unit_physician Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_requires_ventilator_support_in_emergency_department Bool)
(declare-const patient_requires_ventilator_support_in_intensive_care_unit_during_first_24_hours Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_now@@diagnosed_by_emergency_department_physician patient_has_diagnosis_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_now@@diagnosed_by_intensive_care_unit_physician patient_has_diagnosis_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (or patient_has_diagnosis_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_now@@diagnosed_by_emergency_department_physician patient_has_diagnosis_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_now@@diagnosed_by_intensive_care_unit_physician) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 40.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_requires_ventilator_support_in_emergency_department patient_requires_ventilator_support_in_intensive_care_unit_during_first_24_hours) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
