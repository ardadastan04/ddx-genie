;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_sickling_disorder_due_to_hemoglobin_s_now Bool)
(declare-const patient_is_in_uncomplicated_sickle_cell_crisis_now Bool)
(declare-const patient_is_in_uncomplicated_sickle_cell_crisis_now@@at_time_of_admission_from_emergency_department_at_university_of_nebraska_medical_center Bool)
(declare-const patient_is_undergoing_admission_procedure_now Bool)
(declare-const patient_is_undergoing_admission_procedure_now@@from_emergency_department_at_university_of_nebraska_medical_center Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_in_uncomplicated_sickle_cell_crisis_now@@at_time_of_admission_from_emergency_department_at_university_of_nebraska_medical_center patient_is_in_uncomplicated_sickle_cell_crisis_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_undergoing_admission_procedure_now@@from_emergency_department_at_university_of_nebraska_medical_center patient_is_undergoing_admission_procedure_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 19) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_sickling_disorder_due_to_hemoglobin_s_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_in_uncomplicated_sickle_cell_crisis_now@@at_time_of_admission_from_emergency_department_at_university_of_nebraska_medical_center :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
