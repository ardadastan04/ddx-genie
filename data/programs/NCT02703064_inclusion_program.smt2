;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_premenopausal_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)
(declare-const patient_has_diagnosis_of_polycystic_ovary_syndrome_now Bool)
(declare-const patient_has_diagnosis_of_polycystic_ovary_syndrome_now@@diagnosed_by_rottadom_criteria Bool)
(declare-const patient_has_finding_of_hepatic_function_adequate_now Bool)
(declare-const patient_has_finding_of_renal_function_adequate_now Bool)
(declare-const patient_has_finding_of_cardiovascular_function_now Bool)
(declare-const patient_has_finding_of_hematological_function_adequate_now Bool)
(declare-const patient_has_finding_of_weight_finding_inthepast2months Bool)
(declare-const patient_has_finding_of_weight_finding_inthepast2months@@stable_weight Bool)
(declare-const patient_weight_change_value_recorded_inthepast2months_withunit_kilograms Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_polycystic_ovary_syndrome_now@@diagnosed_by_rottadom_criteria patient_has_diagnosis_of_polycystic_ovary_syndrome_now) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_finding_of_weight_finding_inthepast2months@@stable_weight (and patient_has_finding_of_weight_finding_inthepast2months (< patient_weight_change_value_recorded_inthepast2months_withunit_kilograms 3.0))) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_finding_of_weight_finding_inthepast2months@@stable_weight patient_has_finding_of_weight_finding_inthepast2months) :named REQ4_AUXILIARY1))

;; Other kept assertions
(assert (! (and patient_is_premenopausal_now patient_sex_is_female_now) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (<= patient_age_value_recorded_now_in_years 45) :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (< patient_body_mass_index_value_recorded_now_withunit_kg_per_m2 42) :named REQ0_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (and patient_has_diagnosis_of_polycystic_ovary_syndrome_now patient_has_diagnosis_of_polycystic_ovary_syndrome_now@@diagnosed_by_rottadom_criteria) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_hepatic_function_adequate_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_renal_function_adequate_now :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_cardiovascular_function_now :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_hematological_function_adequate_now :named REQ2_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_weight_finding_inthepast2months@@stable_weight :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
