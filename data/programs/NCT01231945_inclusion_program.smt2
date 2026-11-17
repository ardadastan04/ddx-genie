;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_residence_is_in_rural_china_now Bool)
(declare-const patient_has_diagnosis_of_malignant_tumor_of_cervix_inthehistory Bool)
(declare-const patient_has_cervix_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_can_undergo_screening_for_malignant_neoplasm_of_cervix_now Bool)
(declare-const patient_is_able_to_provide_informed_consent Bool)

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= patient_age_value_recorded_now_in_years 25.0) (<= patient_age_value_recorded_now_in_years 65.0)) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_residence_is_in_rural_china_now :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_malignant_tumor_of_cervix_inthehistory) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_cervix_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_is_pregnant_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_can_undergo_screening_for_malignant_neoplasm_of_cervix_now :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_provide_informed_consent :named REQ5_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
