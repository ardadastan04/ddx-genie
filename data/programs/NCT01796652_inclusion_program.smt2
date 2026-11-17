;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_now Bool)
(declare-const patient_has_finding_of_abdominal_pain_now Bool)
(declare-const patient_amylase_measurement_value_recorded_now_withunit_u_per_l Real)
(declare-const patient_has_undergone_amylase_measurement_now Bool)
(declare-const patient_triacylglycerol_lipase_measurement_value_recorded_now_withunit_u_per_l Real)
(declare-const patient_has_undergone_triacylglycerol_lipase_measurement_now Bool)
(declare-const patient_has_undergone_imaging_of_abdomen_now Bool)
(declare-const patient_has_undergone_imaging_of_abdomen_now@@demonstrates_changes_of_acute_pancreatitis Bool)
(declare-const amylase_upper_limit_of_normal_withunit_u_per_l Real)
(declare-const triacylglycerol_lipase_upper_limit_of_normal_withunit_u_per_l Real)
(declare-const patient_has_amylase_3x_uln_now Bool)
(declare-const patient_has_lipase_3x_uln_now Bool)
(declare-const patient_has_elevated_pancreatic_enzymes_now Bool)
(declare-const patient_has_abdominal_imaging_changes_of_acute_pancreatitis_now Bool)
(declare-const findings_count Int)
(declare-const time_since_symptom_onset_in_hours Real)
(declare-const imrie_score_value_recorded_within_24_hours_of_hospital_presentation_withunit_none Real)
(declare-const harmless_acute_pancreatitis_hap_score_value_recorded_within_24_hours_of_hospital_presentation_withunit_none Real)
(declare-const hematocrit_value_recorded_on_presentation_withunit_percent Real)
(declare-const patient_has_finding_of_hematocrit_above_reference_range_now Bool)
(declare-const patient_lacks_hemoconcentration_on_presentation Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_amylase_3x_uln_now (and patient_has_undergone_amylase_measurement_now (>= patient_amylase_measurement_value_recorded_now_withunit_u_per_l (* 3.0 amylase_upper_limit_of_normal_withunit_u_per_l)))) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_lipase_3x_uln_now (and patient_has_undergone_triacylglycerol_lipase_measurement_now (>= patient_triacylglycerol_lipase_measurement_value_recorded_now_withunit_u_per_l (* 3.0 triacylglycerol_lipase_upper_limit_of_normal_withunit_u_per_l)))) :named REQ0_AUXILIARY1))
(assert (! (= patient_has_elevated_pancreatic_enzymes_now (or patient_has_amylase_3x_uln_now patient_has_lipase_3x_uln_now)) :named REQ0_AUXILIARY2))
(assert (! (= patient_has_abdominal_imaging_changes_of_acute_pancreatitis_now (and patient_has_undergone_imaging_of_abdomen_now patient_has_undergone_imaging_of_abdomen_now@@demonstrates_changes_of_acute_pancreatitis)) :named REQ0_AUXILIARY3))
(assert (! (= findings_count (+ (ite patient_has_finding_of_abdominal_pain_now 1 0) (ite patient_has_elevated_pancreatic_enzymes_now 1 0) (ite patient_has_abdominal_imaging_changes_of_acute_pancreatitis_now 1 0))) :named REQ0_AUXILIARY4))
(assert (! (= patient_has_finding_of_hematocrit_above_reference_range_now (> hematocrit_value_recorded_on_presentation_withunit_percent 44.0)) :named REQ3_AUXILIARY0))
(assert (! (= patient_lacks_hemoconcentration_on_presentation (not patient_has_finding_of_hematocrit_above_reference_range_now)) :named REQ3_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_imaging_of_abdomen_now@@demonstrates_changes_of_acute_pancreatitis patient_has_undergone_imaging_of_abdomen_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (and patient_has_diagnosis_of_acute_pancreatitis_now (>= findings_count 2)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= time_since_symptom_onset_in_hours 48.0) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (<= imrie_score_value_recorded_within_24_hours_of_hospital_presentation_withunit_none 5) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= harmless_acute_pancreatitis_hap_score_value_recorded_within_24_hours_of_hospital_presentation_withunit_none 2) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_lacks_hemoconcentration_on_presentation :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
