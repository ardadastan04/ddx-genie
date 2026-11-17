;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_pregnancy_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_undergone_informed_consent_now Bool)
(declare-const patient_has_finding_of_temporal_bone_window_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_pregnancy_now patient_is_pregnant_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_informed_consent_now) :named REQ2_COMPONENT0_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
(assert (! (not patient_has_finding_of_temporal_bone_window_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
