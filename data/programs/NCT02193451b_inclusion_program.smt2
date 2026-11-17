;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_been_randomised_to_upstream_trial_phase_i Bool)
(declare-const patient_was_willing_to_be_contacted_for_long_term_follow_up_on_original_consent_form_phase_i Bool)

;; Other kept assertions
(assert (! patient_has_been_randomised_to_upstream_trial_phase_i :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_was_willing_to_be_contacted_for_long_term_follow_up_on_original_consent_form_phase_i :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
