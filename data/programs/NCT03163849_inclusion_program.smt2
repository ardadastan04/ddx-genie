;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_provided_consent Bool)
(declare-const patient_has_provided_consent@@consent_provided_by_patient Bool)
(declare-const patient_has_symptoms_of_chronic_hepatitis_c_now Bool)
(declare-const patient_is_undergoing_antiviral_therapy_now Bool)
(declare-const patient_has_chronic_hepatitis_c_virus_infection_now Bool)
(declare-const patient_can_undergo_antiviral_therapy_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_provided_consent@@consent_provided_by_patient patient_has_provided_consent) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_symptoms_of_chronic_hepatitis_c_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_undergoing_antiviral_therapy_now :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_chronic_hepatitis_c_virus_infection_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_can_undergo_antiviral_therapy_now :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 65.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
