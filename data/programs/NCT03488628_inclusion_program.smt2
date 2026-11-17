;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_finding_of_accessory_respiratory_muscles_used_now Bool)
(declare-const patient_has_finding_of_accessory_respiratory_muscles_used_now@@identified_on_physical_exam Bool)
(declare-const patient_has_finding_of_increased_respiratory_rate_now Bool)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@moderate_exacerbation Bool)
(declare-const patient_hydrogen_ion_concentration_value_recorded_now_withunit_ph Real)
(declare-const patient_carbon_dioxide_value_recorded_now_withunit_mm_hg Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_accessory_respiratory_muscles_used_now@@identified_on_physical_exam patient_has_finding_of_accessory_respiratory_muscles_used_now) :named REQ2_AUXILIARY0))
(assert (! (= patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@moderate_exacerbation (and (>= patient_hydrogen_ion_concentration_value_recorded_now_withunit_ph 7.25) (<= patient_hydrogen_ion_concentration_value_recorded_now_withunit_ph 7.35) (>= patient_carbon_dioxide_value_recorded_now_withunit_mm_hg 45.0))) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@moderate_exacerbation patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now) :named REQ3_AUXILIARY1))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_finding_of_increased_respiratory_rate_now patient_has_finding_of_accessory_respiratory_muscles_used_now@@identified_on_physical_exam) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@moderate_exacerbation :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
