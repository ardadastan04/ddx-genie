;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_moderate_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_finding_of_severe_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_finding_of_oxygen_saturation_value_recorded_now_withunit_percent Real)
(declare-const patient_has_finding_of_patient_s_condition_stable_now Bool)
(declare-const patient_fruit_value_recorded_now_withunit_portions_per_day Real)
(declare-const patient_vegetable_value_recorded_now_withunit_portions_per_day Real)
(declare-const patient_has_finding_of_dyspnea_on_exertion_now Bool)
(declare-const patient_has_finding_of_dyspnea_on_exertion_now@@exercise_limitation_due_to_dyspnea_and_not_other_causes Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_dyspnea_on_exertion_now@@exercise_limitation_due_to_dyspnea_and_not_other_causes patient_has_finding_of_dyspnea_on_exertion_now) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! (or patient_has_finding_of_moderate_chronic_obstructive_pulmonary_disease_now patient_has_finding_of_severe_chronic_obstructive_pulmonary_disease_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_finding_of_oxygen_saturation_value_recorded_now_withunit_percent 92.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_patient_s_condition_stable_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_fruit_value_recorded_now_withunit_portions_per_day 2.0) :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (<= patient_vegetable_value_recorded_now_withunit_portions_per_day 2.0) :named REQ3_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_dyspnea_on_exertion_now@@exercise_limitation_due_to_dyspnea_and_not_other_causes :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
