;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_suspicion_of_acute_appendicitis_now Bool)
(declare-const patient_has_undergone_ct_of_abdomen_inthehistory Bool)
(declare-const patient_has_undergone_ct_of_abdomen_inthehistory@@referral_from_emergency_department Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_ct_of_abdomen_inthehistory@@referral_from_emergency_department patient_has_undergone_ct_of_abdomen_inthehistory) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_suspicion_of_acute_appendicitis_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_ct_of_abdomen_inthehistory@@referral_from_emergency_department :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
