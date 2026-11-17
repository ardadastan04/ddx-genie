;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_cardiac_resynchronization_therapy_now Bool)
(declare-const patient_has_undergone_cardiac_resynchronization_therapy_now@@performed_with_cardiac_implantable_electronic_device_crt_cied Bool)
(declare-const patient_has_undergone_cardiac_resynchronization_therapy_now@@remotely_monitored Bool)
(declare-const patient_is_current_patient_of_ppg_cardiology Bool)
(declare-const patient_has_diagnosis_of_heart_failure_with_reduced_ejection_fraction_inthehistory Bool)
(declare-const patient_is_pacemaker_dependent_now Bool)
(declare-const patient_has_finding_of_has_computer_access_now Bool)
(declare-const patient_has_finding_of_has_internet_service_now Bool)
(declare-const patient_has_inability_to_provide_informed_consent_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_meets_inclusion_criteria Bool)
(declare-const patient_is_caregiver_now Bool)
(declare-const patient_is_partner_now Bool)
(declare-const patient_is_support_person_now Bool)
(declare-const patient_meets_inclusion_criteria_for_caregivers_now Bool)
(declare-const patient_meets_inclusion_criteria_for_partners_now Bool)
(declare-const patient_meets_inclusion_criteria_for_support_persons_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_cardiac_resynchronization_therapy_now@@performed_with_cardiac_implantable_electronic_device_crt_cied patient_has_undergone_cardiac_resynchronization_therapy_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_cardiac_resynchronization_therapy_now@@remotely_monitored patient_has_undergone_cardiac_resynchronization_therapy_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (not (and patient_has_undergone_cardiac_resynchronization_therapy_now@@performed_with_cardiac_implantable_electronic_device_crt_cied patient_has_undergone_cardiac_resynchronization_therapy_now@@remotely_monitored)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_is_current_patient_of_ppg_cardiology)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_heart_failure_with_reduced_ejection_fraction_inthehistory) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pacemaker_dependent_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and (not patient_has_finding_of_has_computer_access_now) (not patient_has_finding_of_has_internet_service_now))) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_inability_to_provide_informed_consent_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_meets_inclusion_criteria) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_caregiver_now (or patient_has_inability_to_provide_informed_consent_now (< patient_age_value_recorded_now_in_years 18) (not patient_meets_inclusion_criteria_for_caregivers_now)))) :named REQ8_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_partner_now (or patient_has_inability_to_provide_informed_consent_now (< patient_age_value_recorded_now_in_years 18) (not patient_meets_inclusion_criteria_for_partners_now)))) :named REQ8_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_support_person_now (or patient_has_inability_to_provide_informed_consent_now (< patient_age_value_recorded_now_in_years 18) (not patient_meets_inclusion_criteria_for_support_persons_now)))) :named REQ8_COMPONENT2_OTHER_REQUIREMENTS))
