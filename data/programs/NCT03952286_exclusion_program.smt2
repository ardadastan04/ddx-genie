;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_attends_non_participating_school_now Bool)
(declare-const patient_attendance_count_per_week_at_participating_school Real)
(declare-const patient_is_enrolled_in_another_research_study_now Bool)
(declare-const patient_has_finding_of_inpatient_stay_now Bool)
(declare-const patient_has_finding_of_inpatient_stay_now@@at_time_of_ed_discharge Bool)
(declare-const patient_speaks_english Bool)
(declare-const patient_speaks_spanish Bool)
(declare-const consenting_parent_guardian_speaks_english Bool)
(declare-const consenting_parent_guardian_speaks_spanish Bool)
(declare-const patient_has_undergone_admission_to_intensive_care_unit_inthepast1years Bool)
(declare-const patient_has_undergone_admission_to_intensive_care_unit_inthepast1years@@for_asthma Bool)
(declare-const patient_has_finding_of_inpatient_stay_inthepast1years Bool)
(declare-const patient_has_finding_of_inpatient_stay_inthepast1years@@for_asthma Bool)
(declare-const patient_hospitalization_count_for_asthma_in_past_1_year_value_recorded_in_integer Int)
(declare-const controller_medications_count_used_for_asthma_in_past_30_days Real)
(declare-const patient_is_exposed_to_drug_or_medicament_now Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_now@@represents_step_down_in_asthma_therapy Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_now@@judged_by_emergency_department_physician Bool)
(declare-const parent_of_patient_has_cell_phone Bool)
(declare-const parent_of_patient_can_send_and_receive_text_messages Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_inpatient_stay_now@@at_time_of_ed_discharge patient_has_finding_of_inpatient_stay_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_undergone_admission_to_intensive_care_unit_inthepast1years@@for_asthma patient_has_undergone_admission_to_intensive_care_unit_inthepast1years) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_finding_of_inpatient_stay_inthepast1years@@for_asthma patient_has_finding_of_inpatient_stay_inthepast1years) :named REQ6_AUXILIARY0))
(assert (! (=> (> patient_hospitalization_count_for_asthma_in_past_1_year_value_recorded_in_integer 0) patient_has_finding_of_inpatient_stay_inthepast1years@@for_asthma) :named REQ6_AUXILIARY1))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_now@@represents_step_down_in_asthma_therapy patient_is_exposed_to_drug_or_medicament_now) :named REQ8_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_now@@judged_by_emergency_department_physician patient_is_exposed_to_drug_or_medicament_now) :named REQ8_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_attends_non_participating_school_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_attendance_count_per_week_at_participating_school 5)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_enrolled_in_another_research_study_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_inpatient_stay_now@@at_time_of_ed_discharge) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or (or patient_speaks_english patient_speaks_spanish) (or consenting_parent_guardian_speaks_english consenting_parent_guardian_speaks_spanish))) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_admission_to_intensive_care_unit_inthepast1years@@for_asthma) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_hospitalization_count_for_asthma_in_past_1_year_value_recorded_in_integer 2)) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> controller_medications_count_used_for_asthma_in_past_30_days 2)) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_exposed_to_drug_or_medicament_now@@represents_step_down_in_asthma_therapy patient_is_exposed_to_drug_or_medicament_now@@judged_by_emergency_department_physician)) :named REQ8_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not parent_of_patient_has_cell_phone) :named REQ9_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not parent_of_patient_can_send_and_receive_text_messages) :named REQ10_COMPONENT0_OTHER_REQUIREMENTS))
