;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_inthehistory Bool)
(declare-const patient_is_attended_at_primary_care_office_now Bool)
(declare-const patient_has_finding_of_chronic_obstructive_pulmonary_disease_inthepast1years Bool)
(declare-const patient_has_minimum_follow_up_duration_value_recorded_in_years Real)
(declare-const patient_has_been_assisted_in_scheduled_primary_care_appointment_at_inclusion_date Bool)
(declare-const patient_is_undergoing_clinical_trial_now Bool)
(declare-const patient_is_currently_involved_in_research_study_related_to_chronic_obstructive_pulmonary_disease Bool)

;; Other kept assertions
(assert (! (not (and patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_inthehistory patient_is_attended_at_primary_care_office_now (not patient_has_finding_of_chronic_obstructive_pulmonary_disease_inthepast1years) (not (and (>= patient_has_minimum_follow_up_duration_value_recorded_in_years 1) patient_has_been_assisted_in_scheduled_primary_care_appointment_at_inclusion_date)))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or patient_is_undergoing_clinical_trial_now patient_is_currently_involved_in_research_study_related_to_chronic_obstructive_pulmonary_disease)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
