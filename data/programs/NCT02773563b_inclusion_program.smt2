;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_consecutive_patient_referred_for_endoscopic_ultrasonography Bool)
(declare-const patient_needs_to_undergo_endoscopic_ultrasonography_now Bool)
(declare-const patient_is_consecutive_patient Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_consecutive_patient_referred_for_endoscopic_ultrasonography (and patient_is_consecutive_patient patient_needs_to_undergo_endoscopic_ultrasonography_now)) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_is_consecutive_patient :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_needs_to_undergo_endoscopic_ultrasonography_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
