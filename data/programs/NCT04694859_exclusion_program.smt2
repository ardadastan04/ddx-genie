;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const annulus_size_value_recorded_now_in_millimeters Real)
(declare-const patient_has_finding_of_left_ventricular_thrombus_now Bool)
(declare-const patient_has_finding_of_endocarditis_now Bool)
(declare-const patient_has_finding_of_endocarditis_now@@active Bool)
(declare-const patient_has_high_risk_of_coronary_ostium_obstruction_now Bool)
(declare-const patient_has_plaques_with_mobile_thrombi_in_ascending_aorta_now Bool)
(declare-const patient_has_plaques_with_mobile_thrombi_in_arch_now Bool)
(declare-const patient_has_finding_of_hemodynamic_instability_now Bool)
(declare-const patient_life_expectancy_value_estimated_in_years Real)
(declare-const patient_has_finding_of_co_morbid_conditions_now Bool)
(declare-const patient_has_finding_of_co_morbid_conditions_now@@suggests_lack_of_improvement_of_quality_of_life Bool)
(declare-const patient_is_in_other_situations_adjudicated_by_local_heartteam_now Bool)
(declare-const patient_has_finding_of_finding_of_increased_risk_level_now Bool)
(declare-const patient_can_undergo_transcatheter_aortic_valve_implantation_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_endocarditis_now@@active patient_has_finding_of_endocarditis_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_co_morbid_conditions_now@@suggests_lack_of_improvement_of_quality_of_life patient_has_finding_of_co_morbid_conditions_now) :named REQ7_AUXILIARY0))

;; Other kept assertions
(assert (! (not (< annulus_size_value_recorded_now_in_millimeters 18)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> annulus_size_value_recorded_now_in_millimeters 29)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_left_ventricular_thrombus_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_endocarditis_now@@active) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_high_risk_of_coronary_ostium_obstruction_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_plaques_with_mobile_thrombi_in_ascending_aorta_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_plaques_with_mobile_thrombi_in_arch_now) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hemodynamic_instability_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_life_expectancy_value_estimated_in_years 1)) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_co_morbid_conditions_now@@suggests_lack_of_improvement_of_quality_of_life) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_in_other_situations_adjudicated_by_local_heartteam_now (not (or patient_has_finding_of_finding_of_increased_risk_level_now patient_can_undergo_transcatheter_aortic_valve_implantation_now)))) :named REQ8_COMPONENT0_OTHER_REQUIREMENTS))
