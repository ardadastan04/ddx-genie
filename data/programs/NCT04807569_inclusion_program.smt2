;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_lower_urinary_tract_symptoms_now Bool)
(declare-const patient_has_finding_of_increased_frequency_of_urination_now Bool)
(declare-const patient_has_finding_of_nocturia_now Bool)
(declare-const patient_has_finding_of_urinary_urgency_now Bool)
(declare-const patient_has_finding_of_sensation_as_if_urinary_bladder_still_full_now Bool)
(declare-const patient_has_finding_of_poor_stream_of_urine_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_increased_frequency_of_urination_now patient_has_finding_of_nocturia_now patient_has_finding_of_urinary_urgency_now patient_has_finding_of_sensation_as_if_urinary_bladder_still_full_now patient_has_finding_of_poor_stream_of_urine_now) patient_has_finding_of_lower_urinary_tract_symptoms_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_lower_urinary_tract_symptoms_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
