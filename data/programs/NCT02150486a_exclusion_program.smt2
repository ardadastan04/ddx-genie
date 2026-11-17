;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_undergoing_operation_on_abdominal_region_now Bool)
(declare-const patient_is_undergoing_operation_on_abdominal_region_now@@higher_risk Bool)
(declare-const patient_has_major_cardiovascular_risk_factor_as_defined_in_inclusion_criteria Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_operation_on_abdominal_region_now@@higher_risk patient_is_undergoing_operation_on_abdominal_region_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 45)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_operation_on_abdominal_region_now@@higher_risk) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_has_major_cardiovascular_risk_factor_as_defined_in_inclusion_criteria)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
