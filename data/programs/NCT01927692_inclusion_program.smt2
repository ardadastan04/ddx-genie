;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_capacity_to_understand_and_sign_informed_consent_form_now Bool)
(declare-const patient_has_capacity_to_understand_informed_consent_form_now Bool)
(declare-const patient_has_capacity_to_sign_informed_consent_form_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@diagnosis_based_on_clinical_features Bool)
(declare-const patient_is_exposed_to_acetylcholine_receptor_antibody_now Bool)
(declare-const patient_needs_to_undergo_therapeutic_plasma_exchange_now Bool)
(declare-const patient_needs_to_undergo_therapeutic_plasma_exchange_now@@to_treat_myasthenia_gravis Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_capacity_to_understand_and_sign_informed_consent_form_now (and patient_has_capacity_to_understand_informed_consent_form_now patient_has_capacity_to_sign_informed_consent_form_now)) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@diagnosis_based_on_clinical_features patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_needs_to_undergo_therapeutic_plasma_exchange_now@@to_treat_myasthenia_gravis patient_needs_to_undergo_therapeutic_plasma_exchange_now) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_capacity_to_understand_informed_consent_form_now :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_capacity_to_sign_informed_consent_form_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_myasthenia_gravis_now@@diagnosis_based_on_clinical_features :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_exposed_to_acetylcholine_receptor_antibody_now :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_needs_to_undergo_therapeutic_plasma_exchange_now@@to_treat_myasthenia_gravis :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
