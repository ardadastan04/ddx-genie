;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_currently_using_combined_oral_contraceptive_now Bool)
(declare-const patient_has_prescription_for_combined_oral_contraceptive_now Bool)
(declare-const patient_intends_to_initiate_combined_oral_contraceptive_use_for_contraception_now Bool)

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_is_currently_using_combined_oral_contraceptive_now (and patient_has_prescription_for_combined_oral_contraceptive_now patient_intends_to_initiate_combined_oral_contraceptive_use_for_contraception_now)) :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
