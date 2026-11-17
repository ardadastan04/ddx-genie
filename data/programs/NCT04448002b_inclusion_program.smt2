;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_caregiver_now Bool)
(declare-const caregiver_age_value_recorded_now_in_years Real)
(declare-const patient_lives_in_residence_of_caregiver_now Bool)
(declare-const patient_is_able_to_speak_english Bool)
(declare-const patient_is_able_to_read_english Bool)
(declare-const caregiver_is_able_to_speak_english Bool)
(declare-const caregiver_is_able_to_read_english Bool)
(declare-const patient_has_been_diagnosed_with_asthma_ever Bool)
(declare-const doctor_has_stated_patient_has_asthma_ever Bool)
(declare-const patient_has_had_breathing_problems_in_past_12_months Bool)
(declare-const patient_duration_of_active_inhaled_corticosteroid_prescription_in_weeks Real)
(declare-const patient_has_active_inhaled_corticosteroid_prescription_now Bool)
(declare-const exacerbation_count_in_past_1_year@@requiring_oral_systemic_corticosteroids Real)
(declare-const emergency_department_visit_count_due_to_asthma_in_past_1_year Real)
(declare-const hospitalization_count_due_to_asthma_in_past_1_year Real)
(declare-const urgent_medical_care_visit_count_due_to_asthma_in_past_1_year Real)
(declare-const eligibility_exacerbation_or_ed_or_hosp_or_urgent Bool)

;; Existing auxiliary assertions
(assert (! (= eligibility_exacerbation_or_ed_or_hosp_or_urgent (or (>= exacerbation_count_in_past_1_year@@requiring_oral_systemic_corticosteroids 2) (>= emergency_department_visit_count_due_to_asthma_in_past_1_year 2) (>= hospitalization_count_due_to_asthma_in_past_1_year 1) (>= urgent_medical_care_visit_count_due_to_asthma_in_past_1_year 2))) :named REQ6_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 12) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 15) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and patient_has_caregiver_now (>= caregiver_age_value_recorded_now_in_years 18)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_caregiver_now (<= caregiver_age_value_recorded_now_in_years 70)) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_lives_in_residence_of_caregiver_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_speak_english :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_read_english :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! caregiver_is_able_to_speak_english :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! caregiver_is_able_to_read_english :named REQ3_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (or patient_has_been_diagnosed_with_asthma_ever doctor_has_stated_patient_has_asthma_ever patient_has_had_breathing_problems_in_past_12_months) :named REQ4_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= patient_duration_of_active_inhaled_corticosteroid_prescription_in_weeks 4) patient_has_active_inhaled_corticosteroid_prescription_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! eligibility_exacerbation_or_ed_or_hosp_or_urgent :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
