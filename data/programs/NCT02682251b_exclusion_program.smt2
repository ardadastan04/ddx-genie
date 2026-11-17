;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_undergoing_cardiac_resynchronization_therapy_now Bool)
(declare-const patient_is_undergoing_cardiac_resynchronization_therapy_now@@delivered_with_biotronik_cardiac_implantable_electronic_device Bool)
(declare-const patient_is_undergoing_cardiac_resynchronization_therapy_now@@remotely_monitored Bool)
(declare-const patient_is_undergoing_cardiac_resynchronization_therapy_now@@duration_days Real)
(declare-const patient_is_current_patient_of_parkview_physicians_group_cardiology Bool)
(declare-const patient_has_finding_of_heart_failure_with_reduced_ejection_fraction_inthehistory Bool)
(declare-const patient_is_pacemaker_dependent_now Bool)
(declare-const patient_has_access_to_computer Bool)
(declare-const patient_has_access_to_internet Bool)
(declare-const patient_has_inability_to_provide_informed_consent Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_meets_inclusion_criteria Bool)
(declare-const patient_requires_caregiver_partner_or_support_person_to_access_mychart_or_provide_consent Bool)
(declare-const caregiver_partner_or_support_person_has_inability_to_provide_informed_consent Bool)
(declare-const caregiver_partner_or_support_person_age_value_recorded_in_years Real)
(declare-const caregiver_partner_or_support_person_meets_inclusion_criteria Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_cardiac_resynchronization_therapy_now@@delivered_with_biotronik_cardiac_implantable_electronic_device patient_is_undergoing_cardiac_resynchronization_therapy_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_undergoing_cardiac_resynchronization_therapy_now@@remotely_monitored patient_is_undergoing_cardiac_resynchronization_therapy_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (not (and patient_is_undergoing_cardiac_resynchronization_therapy_now@@delivered_with_biotronik_cardiac_implantable_electronic_device patient_is_undergoing_cardiac_resynchronization_therapy_now@@remotely_monitored)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_is_undergoing_cardiac_resynchronization_therapy_now@@duration_days 60)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (not patient_is_current_patient_of_parkview_physicians_group_cardiology)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_has_finding_of_heart_failure_with_reduced_ejection_fraction_inthehistory)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pacemaker_dependent_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_access_to_computer) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_access_to_internet) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_inability_to_provide_informed_consent) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_meets_inclusion_criteria)) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_requires_caregiver_partner_or_support_person_to_access_mychart_or_provide_consent caregiver_partner_or_support_person_has_inability_to_provide_informed_consent)) :named REQ8_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_requires_caregiver_partner_or_support_person_to_access_mychart_or_provide_consent (< caregiver_partner_or_support_person_age_value_recorded_in_years 18))) :named REQ8_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_requires_caregiver_partner_or_support_person_to_access_mychart_or_provide_consent (not caregiver_partner_or_support_person_meets_inclusion_criteria))) :named REQ8_COMPONENT2_OTHER_REQUIREMENTS))
