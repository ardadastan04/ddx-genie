;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_needs_to_undergo_operation_on_heart_now Bool)
(declare-const patient_needs_to_undergo_operation_on_thyroid_gland_now Bool)
(declare-const patient_is_undergoing_excision_of_thymus_now Bool)
(declare-const patient_is_undergoing_excision_of_thymus_now@@partial_resection Bool)
(declare-const patient_is_undergoing_excision_of_thymus_now@@performed_for_operative_technical_reasons_during_thyroid_surgery Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_excision_of_thymus_now@@performed_for_operative_technical_reasons_during_thyroid_surgery patient_is_undergoing_excision_of_thymus_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_undergoing_excision_of_thymus_now@@partial_resection patient_is_undergoing_excision_of_thymus_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 17) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_needs_to_undergo_operation_on_heart_now (and patient_needs_to_undergo_operation_on_thyroid_gland_now patient_is_undergoing_excision_of_thymus_now patient_is_undergoing_excision_of_thymus_now@@performed_for_operative_technical_reasons_during_thyroid_surgery)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
