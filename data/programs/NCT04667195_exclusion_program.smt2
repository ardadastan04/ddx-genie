;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const attending_physician_considers_participation_will_delay_life_saving_treatment Bool)
(declare-const patient_needs_to_undergo_patient_transfer_to_intensive_care_unit_now Bool)
(declare-const patient_needs_to_undergo_patient_transfer_to_intensive_care_unit_now@@direct_transfer Bool)
(declare-const patient_has_undergone_hospital_admission_inthepast14days Bool)
(declare-const patient_has_diagnosis_of_covid_19_inthehistory Bool)
(declare-const patient_has_diagnosis_of_covid_19_inthehistory@@temporalcontext_within14daysbefore_hospital_admission Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_finding_of_immunodeficiency_disorder_now Bool)
(declare-const patient_has_finding_of_immunodeficiency_disorder_now@@severe Bool)
(declare-const patient_has_finding_of_primary_immunodeficiency_now Bool)
(declare-const patient_has_finding_of_primary_immunodeficiency_now@@severe Bool)
(declare-const patient_has_finding_of_secondary_immunodeficiency_now Bool)
(declare-const patient_has_finding_of_secondary_immunodeficiency_now@@severe Bool)
(declare-const patient_has_finding_of_human_immunodeficiency_virus_infection_now Bool)
(declare-const cd4_cell_count_value_recorded_now_withunit_cells_per_microliter Real)
(declare-const patient_is_undergoing_immunosuppressive_therapy_now Bool)
(declare-const patient_is_undergoing_immunosuppressive_therapy_now@@classified_as_atc_code_l04a Bool)
(declare-const patient_is_undergoing_corticosteroid_and_or_corticosteroid_derivative_therapy_now Bool)
(declare-const corticosteroid_dose_value_recorded_now_withunit_milligrams_per_day_prednisone_equivalent Real)
(declare-const corticosteroid_treatment_duration_value_in_days_within_past_30_days Real)
(declare-const patient_has_undergone_chemotherapy_inthepast30days Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_needs_to_undergo_patient_transfer_to_intensive_care_unit_now@@direct_transfer patient_needs_to_undergo_patient_transfer_to_intensive_care_unit_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_covid_19_inthehistory@@temporalcontext_within14daysbefore_hospital_admission patient_has_diagnosis_of_covid_19_inthehistory) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_immunodeficiency_disorder_now@@severe patient_has_finding_of_immunodeficiency_disorder_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_finding_of_primary_immunodeficiency_now@@severe patient_has_finding_of_primary_immunodeficiency_now) :named REQ4_AUXILIARY1))
(assert (! (=> patient_has_finding_of_secondary_immunodeficiency_now@@severe patient_has_finding_of_secondary_immunodeficiency_now) :named REQ4_AUXILIARY2))
(assert (! (=> patient_is_undergoing_immunosuppressive_therapy_now@@classified_as_atc_code_l04a patient_is_undergoing_immunosuppressive_therapy_now) :named REQ4_AUXILIARY3))
(assert (! (=> (or (and patient_has_finding_of_human_immunodeficiency_virus_infection_now (< cd4_cell_count_value_recorded_now_withunit_cells_per_microliter 200)) patient_is_undergoing_immunosuppressive_therapy_now@@classified_as_atc_code_l04a (and patient_is_undergoing_corticosteroid_and_or_corticosteroid_derivative_therapy_now (> corticosteroid_dose_value_recorded_now_withunit_milligrams_per_day_prednisone_equivalent 20) (> corticosteroid_treatment_duration_value_in_days_within_past_30_days 14)) patient_has_undergone_chemotherapy_inthepast30days) patient_has_finding_of_secondary_immunodeficiency_now) :named REQ4_AUXILIARY4))
(assert (! (=> (or patient_has_finding_of_primary_immunodeficiency_now patient_has_finding_of_secondary_immunodeficiency_now) patient_has_finding_of_immunodeficiency_disorder_now@@severe) :named REQ4_AUXILIARY5))

;; Other kept assertions
(assert (! (not attending_physician_considers_participation_will_delay_life_saving_treatment) :named REQ0_COMPONENT0_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
(assert (! (not patient_needs_to_undergo_patient_transfer_to_intensive_care_unit_now@@direct_transfer) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_hospital_admission_inthepast14days) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_covid_19_inthehistory@@temporalcontext_within14daysbefore_hospital_admission) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_immunodeficiency_disorder_now@@severe) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_primary_immunodeficiency_now) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_secondary_immunodeficiency_now) :named REQ4_COMPONENT2_OTHER_REQUIREMENTS))
