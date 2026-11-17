;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const duration_of_remotely_monitored_biotronik_cardiac_resynchronization_therapy_in_days Real)
(declare-const patient_has_undergone_cardiac_resynchronization_therapy_inthehistory Bool)
(declare-const patient_has_undergone_cardiac_resynchronization_therapy_inthehistory@@remotely_monitored Bool)
(declare-const patient_has_undergone_cardiac_resynchronization_therapy_inthehistory@@performed_with_biotronik_cardiac_implantable_electronic_device Bool)
(declare-const patient_has_undergone_cardiac_resynchronization_therapy_inthehistory@@performed_for_more_than_60_days Bool)
(declare-const patient_has_ability_to_provide_informed_consent_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_current_patient_of_ppg_cardiology Bool)
(declare-const patient_has_diagnosis_of_heart_failure_with_reduced_ejection_fraction_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_cardiac_resynchronization_therapy_inthehistory@@remotely_monitored patient_has_undergone_cardiac_resynchronization_therapy_inthehistory) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_cardiac_resynchronization_therapy_inthehistory@@performed_with_biotronik_cardiac_implantable_electronic_device patient_has_undergone_cardiac_resynchronization_therapy_inthehistory) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_cardiac_resynchronization_therapy_inthehistory@@performed_for_more_than_60_days patient_has_undergone_cardiac_resynchronization_therapy_inthehistory) :named REQ0_AUXILIARY2))
(assert (! (= patient_has_undergone_cardiac_resynchronization_therapy_inthehistory@@performed_for_more_than_60_days (> duration_of_remotely_monitored_biotronik_cardiac_resynchronization_therapy_in_days 60)) :named REQ0_AUXILIARY3))

;; Other kept assertions
(assert (! (and patient_has_undergone_cardiac_resynchronization_therapy_inthehistory@@remotely_monitored patient_has_undergone_cardiac_resynchronization_therapy_inthehistory@@performed_with_biotronik_cardiac_implantable_electronic_device patient_has_undergone_cardiac_resynchronization_therapy_inthehistory@@performed_for_more_than_60_days) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_ability_to_provide_informed_consent_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_current_patient_of_ppg_cardiology :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_heart_failure_with_reduced_ejection_fraction_inthehistory :named REQ5_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
