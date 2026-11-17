;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_capacity_to_give_informed_consent_now Bool)
(declare-const patient_has_finding_of_partial_anterior_cerebral_circulation_infarction_now Bool)
(declare-const patient_has_finding_of_transient_cerebral_ischemia_now Bool)
(declare-const patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent Real)

;; Other kept assertions
(assert (! patient_has_capacity_to_give_informed_consent_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_finding_of_partial_anterior_cerebral_circulation_infarction_now patient_has_finding_of_transient_cerebral_ischemia_now) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent 50.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
