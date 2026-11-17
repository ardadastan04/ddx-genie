;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_being_remotely_monitored_with_crt_cied_now Bool)
(declare-const patient_is_in_focus_group_1 Bool)
(declare-const patient_is_in_focus_group_2 Bool)
(declare-const patient_has_undergone_implantation_of_cardiac_resynchronization_therapy_implantable_pacemaker_inthepast12months Bool)
(declare-const patient_is_in_focus_group_3 Bool)
(declare-const patient_is_in_focus_group_4 Bool)
(declare-const patient_has_undergone_implantation_of_cardiac_resynchronization_therapy_implantable_pacemaker_inthehistory Bool)
(declare-const duration_since_crt_cied_implant_in_months Real)
(declare-const patient_has_crt_cied_implant_for_12_months_or_more Bool)
(declare-const patient_is_current_patient_of_ppg_cardiology Bool)
(declare-const patient_has_diagnosis_of_heart_failure_with_reduced_ejection_fraction_inthehistory Bool)
(declare-const patient_has_ability_to_provide_informed_consent_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (= patient_has_crt_cied_implant_for_12_months_or_more (and patient_has_undergone_implantation_of_cardiac_resynchronization_therapy_implantable_pacemaker_inthehistory (>= duration_since_crt_cied_implant_in_months 12.0))) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! patient_is_being_remotely_monitored_with_crt_cied_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_is_in_focus_group_1 (and patient_is_in_focus_group_2 patient_has_undergone_implantation_of_cardiac_resynchronization_therapy_implantable_pacemaker_inthepast12months)) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_is_in_focus_group_3 (and patient_is_in_focus_group_4 patient_has_crt_cied_implant_for_12_months_or_more)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_current_patient_of_ppg_cardiology :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_heart_failure_with_reduced_ejection_fraction_inthehistory :named REQ4_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_ability_to_provide_informed_consent_now :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
