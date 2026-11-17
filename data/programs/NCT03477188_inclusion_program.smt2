;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_patient_of_inonu_university_faculty_of_medicine_neurology_department Bool)
(declare-const patient_has_diagnosis_of_ischemic_stroke_inthehistory@@diagnosed_by_inonu_university_faculty_of_medicine_neurology_department Bool)
(declare-const patient_has_diagnosis_of_hemorrhagic_cerebral_infarction_inthehistory@@diagnosed_by_inonu_university_faculty_of_medicine_neurology_department Bool)
(declare-const patient_is_cooperative_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_able_to_adapt_to_exercise_program Bool)
(declare-const patient_has_diagnosis_of_ischemic_stroke_inthehistory Bool)
(declare-const patient_has_diagnosis_of_hemorrhagic_cerebral_infarction_inthehistory Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_hemorrhagic_cerebral_infarction_inthehistory@@diagnosed_by_inonu_university_faculty_of_medicine_neurology_department patient_has_diagnosis_of_hemorrhagic_cerebral_infarction_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_diagnosis_of_ischemic_stroke_inthehistory@@diagnosed_by_inonu_university_faculty_of_medicine_neurology_department patient_has_diagnosis_of_ischemic_stroke_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! patient_is_patient_of_inonu_university_faculty_of_medicine_neurology_department :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_diagnosis_of_ischemic_stroke_inthehistory@@diagnosed_by_inonu_university_faculty_of_medicine_neurology_department patient_has_diagnosis_of_hemorrhagic_cerebral_infarction_inthehistory@@diagnosed_by_inonu_university_faculty_of_medicine_neurology_department) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_cooperative_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (>= patient_age_value_recorded_now_in_years 45.0) (<= patient_age_value_recorded_now_in_years 80.0)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_adapt_to_exercise_program :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
