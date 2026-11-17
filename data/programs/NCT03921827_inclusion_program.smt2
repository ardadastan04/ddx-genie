;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_cerebrovascular_accident_inthepast3months Bool)
(declare-const patient_has_finding_of_transient_cerebral_ischemia_inthepast3months Bool)
(declare-const patient_has_finding_of_severe_stenosis_of_intracranial_internal_carotid_artery_now Bool)
(declare-const patient_has_finding_of_severe_stenosis_of_middle_cerebral_artery_now Bool)
(declare-const patient_has_finding_of_impaired_cerebrovascular_reserve_within_past_3_months Bool)
(declare-const patient_has_finding_of_impaired_cerebrovascular_reserve_before_3_weeks_after_acute_stroke Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Other kept assertions
(assert (! (or patient_has_finding_of_cerebrovascular_accident_inthepast3months patient_has_finding_of_transient_cerebral_ischemia_inthepast3months) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_finding_of_severe_stenosis_of_intracranial_internal_carotid_artery_now patient_has_finding_of_severe_stenosis_of_middle_cerebral_artery_now) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_impaired_cerebrovascular_reserve_within_past_3_months :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_has_finding_of_impaired_cerebrovascular_reserve_before_3_weeks_after_acute_stroke) :named REQ0_COMPONENT3_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_age_value_recorded_now_in_years 21) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
