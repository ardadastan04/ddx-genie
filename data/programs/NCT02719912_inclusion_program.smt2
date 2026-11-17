;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=6 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_mitral_valve_regurgitation_now@@degenerative Bool)
(declare-const patient_has_finding_of_mitral_valve_regurgitation_now@@symptomatic Bool)
(declare-const patient_has_finding_of_functional_mitral_regurgitation_now@@symptomatic Bool)
(declare-const mitral_regurgitation_severity_value_recorded_within_90_days_prior_to_procedure_withunit_grade Real)
(declare-const patient_has_finding_of_mitral_valve_regurgitation_now@@ischemic_etiology Bool)
(declare-const patient_has_finding_of_mitral_valve_regurgitation_now@@nonischemic_etiology Bool)
(declare-const patient_has_finding_of_mitral_valve_regurgitation_now@@based_on_qualifying_echocardiography_within_90_days_prior_to_procedure Bool)
(declare-const patient_has_finding_of_new_york_heart_association_classification_class_iii_now Bool)
(declare-const patient_has_finding_of_new_york_heart_association_classification_class_iv_now Bool)
(declare-const patient_is_at_high_risk_for_open_heart_valvuloplasty_of_mitral_valve_without_replacement_now Bool)
(declare-const patient_is_at_high_risk_for_open_heart_valvuloplasty_of_mitral_valve_without_replacement_now@@in_the_consideration_of_the_site_heart_team Bool)
(declare-const patient_is_at_high_risk_for_replacement_of_mitral_valve_now Bool)
(declare-const patient_is_at_high_risk_for_replacement_of_mitral_valve_now@@in_the_consideration_of_the_site_heart_team Bool)
(declare-const patient_left_ventricular_ejection_fraction_value_recorded_inthepast30days_withunit_percent Real)
(declare-const mitral_valve_annular_commissure_to_commissure_dimension_value_recorded_by_echocardiography_in_mm Real)
(declare-const patient_left_atrium_cavity_size_value_recorded_now_withunit_cm Real)
(declare-const patient_left_atrium_cavity_size_value_recorded_now_withunit_cm@@measured_by_echocardiography Bool)
(declare-const patient_has_finding_of_mitral_valve_regurgitation_now Bool)
(declare-const patient_has_finding_of_functional_mitral_regurgitation_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_at_high_risk_for_open_heart_valvuloplasty_of_mitral_valve_without_replacement_now@@in_the_consideration_of_the_site_heart_team patient_is_at_high_risk_for_open_heart_valvuloplasty_of_mitral_valve_without_replacement_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_at_high_risk_for_replacement_of_mitral_valve_now@@in_the_consideration_of_the_site_heart_team patient_is_at_high_risk_for_replacement_of_mitral_valve_now) :named REQ2_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_functional_mitral_regurgitation_now@@symptomatic patient_has_finding_of_functional_mitral_regurgitation_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_mitral_valve_regurgitation_now@@based_on_qualifying_echocardiography_within_90_days_prior_to_procedure patient_has_finding_of_mitral_valve_regurgitation_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_mitral_valve_regurgitation_now@@degenerative patient_has_finding_of_mitral_valve_regurgitation_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_finding_of_mitral_valve_regurgitation_now@@ischemic_etiology patient_has_finding_of_mitral_valve_regurgitation_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_has_finding_of_mitral_valve_regurgitation_now@@nonischemic_etiology patient_has_finding_of_mitral_valve_regurgitation_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))
(assert (! (=> patient_has_finding_of_mitral_valve_regurgitation_now@@symptomatic patient_has_finding_of_mitral_valve_regurgitation_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_5))

;; Other kept assertions
(assert (! (or (and patient_has_finding_of_mitral_valve_regurgitation_now@@degenerative patient_has_finding_of_mitral_valve_regurgitation_now@@symptomatic (>= mitral_regurgitation_severity_value_recorded_within_90_days_prior_to_procedure_withunit_grade 3)) (and patient_has_finding_of_functional_mitral_regurgitation_now@@symptomatic (>= mitral_regurgitation_severity_value_recorded_within_90_days_prior_to_procedure_withunit_grade 3))) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (and patient_has_finding_of_mitral_valve_regurgitation_now@@ischemic_etiology patient_has_finding_of_mitral_valve_regurgitation_now@@based_on_qualifying_echocardiography_within_90_days_prior_to_procedure) (and patient_has_finding_of_mitral_valve_regurgitation_now@@nonischemic_etiology patient_has_finding_of_mitral_valve_regurgitation_now@@based_on_qualifying_echocardiography_within_90_days_prior_to_procedure)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_new_york_heart_association_classification_class_iii_now patient_has_finding_of_new_york_heart_association_classification_class_iv_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_is_at_high_risk_for_open_heart_valvuloplasty_of_mitral_valve_without_replacement_now@@in_the_consideration_of_the_site_heart_team patient_is_at_high_risk_for_replacement_of_mitral_valve_now@@in_the_consideration_of_the_site_heart_team) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_left_ventricular_ejection_fraction_value_recorded_inthepast30days_withunit_percent 30.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= mitral_valve_annular_commissure_to_commissure_dimension_value_recorded_by_echocardiography_in_mm 30.0) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= mitral_valve_annular_commissure_to_commissure_dimension_value_recorded_by_echocardiography_in_mm 35.0) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and patient_left_atrium_cavity_size_value_recorded_now_withunit_cm@@measured_by_echocardiography (< patient_left_atrium_cavity_size_value_recorded_now_withunit_cm 5.5)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
