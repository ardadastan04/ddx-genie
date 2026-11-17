;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_parkinsonism_now Bool)
(declare-const patient_is_family_member_of_participant_with_lrrk2_parkinsonism Bool)
(declare-const patient_is_member_of_high_risk_population_with_early_onset_parkinson_disease Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Other kept assertions
(assert (! (or patient_has_finding_of_parkinsonism_now patient_is_family_member_of_participant_with_lrrk2_parkinsonism patient_is_member_of_high_risk_population_with_early_onset_parkinson_disease) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
