;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_able_to_provide_informed_consent_now Bool)
(declare-const patient_has_diagnosis_of_parkinsonism_now Bool)
(declare-const patient_is_family_member_of_participant_with_lrrk2_parkinsonism Bool)
(declare-const patient_is_member_of_high_risk_population_with_early_onset_parkinsons_disease Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_been_previously_enrolled_in_this_study Bool)
(declare-const patient_is_in_custody_now Bool)

;; Other kept assertions
(assert (! (not patient_is_able_to_provide_informed_consent_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and (not patient_has_diagnosis_of_parkinsonism_now) (not patient_is_family_member_of_participant_with_lrrk2_parkinsonism) (not patient_is_member_of_high_risk_population_with_early_onset_parkinsons_disease))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_been_previously_enrolled_in_this_study) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_in_custody_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
