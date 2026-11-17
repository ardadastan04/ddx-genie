;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_undergoing_operation_on_abdominal_region_now Bool)
(declare-const patient_is_undergoing_operation_on_abdominal_region_now@@higher_risk Bool)
(declare-const patient_personal_risk_factor_value_recorded_now_withunit_count@@cardiovascular Bool)
(declare-const patient_personal_risk_factor_value_recorded_now_withunit_count@@minor Bool)
(declare-const patient_personal_risk_factor_value_recorded_now_withunit_count@@cardiovascular@@minor Real)
(declare-const patient_personal_risk_factor_value_recorded_now_withunit_count Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_operation_on_abdominal_region_now@@higher_risk patient_is_undergoing_operation_on_abdominal_region_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_personal_risk_factor_value_recorded_now_withunit_count@@cardiovascular true) :named REQ2_AUXILIARY0))
(assert (! (=> patient_personal_risk_factor_value_recorded_now_withunit_count@@minor true) :named REQ2_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_personal_risk_factor_value_recorded_now_withunit_count@@cardiovascular patient_personal_risk_factor_value_recorded_now_withunit_count) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_personal_risk_factor_value_recorded_now_withunit_count@@minor patient_personal_risk_factor_value_recorded_now_withunit_count) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 45)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_operation_on_abdominal_region_now@@higher_risk) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (>= patient_personal_risk_factor_value_recorded_now_withunit_count@@cardiovascular@@minor 2)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
