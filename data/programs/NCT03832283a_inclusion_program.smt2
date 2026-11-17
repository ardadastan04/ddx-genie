;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_receives_care_from_participating_primary_care_provider Bool)
(declare-const patient_needs_to_undergo_depression_screening_now Bool)
(declare-const patient_needs_to_undergo_depression_screening_now@@for_screening_arms Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_needs_to_undergo_depression_screening_now@@for_screening_arms patient_needs_to_undergo_depression_screening_now) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_receives_care_from_participating_primary_care_provider :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_needs_to_undergo_depression_screening_now@@for_screening_arms :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
