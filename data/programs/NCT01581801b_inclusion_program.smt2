;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)
(declare-const patient_has_finding_of_sleep_apnea_now Bool)
(declare-const patient_has_finding_of_severe_coxarthritis_now Bool)
(declare-const patient_has_finding_of_severe_gonarthritis_now Bool)
(declare-const patient_has_finding_of_severe_hypertension_now Bool)
(declare-const patient_has_at_least_one_complication_now Bool)
(declare-const patient_is_able_to_understand_study_process Bool)
(declare-const patient_is_able_to_comply_with_study_process Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_sleep_apnea_now patient_has_finding_of_severe_coxarthritis_now patient_has_finding_of_severe_gonarthritis_now patient_has_finding_of_severe_hypertension_now) patient_has_at_least_one_complication_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 25.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 65.0) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 35.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 50.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (=> (and (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 35.0) (< patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 40.0)) patient_has_at_least_one_complication_now) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_understand_study_process :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_comply_with_study_process :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
