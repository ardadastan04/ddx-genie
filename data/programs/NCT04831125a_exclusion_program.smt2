;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_unable_to_provide_consent_for_themselves_due_to_medical_comorbidity_now Bool)
(declare-const patient_is_unable_to_provide_consent_for_themselves_due_to_psychiatric_comorbidity_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_difficulty_with_follow_up_now Bool)

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_provide_consent_for_themselves_due_to_medical_comorbidity_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_provide_consent_for_themselves_due_to_psychiatric_comorbidity_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_difficulty_with_follow_up_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
