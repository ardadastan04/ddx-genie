;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_gastric_neurostimulator_device_in_situ_now Bool)
(declare-const duration_of_gastric_neurostimulator_device_in_situ_now_in_months Real)
(declare-const patient_has_finding_of_abdominal_pain_inthepast2months Bool)
(declare-const patient_has_finding_of_abdominal_pain_inthepast2months@@moderate_severity Bool)
(declare-const patient_has_finding_of_abdominal_pain_inthepast2months@@severe_severity Bool)
(declare-const patient_has_finding_of_abdominal_pain_inthepast2months@@reported_on_at_least_one_pain_questionnaire Bool)
(declare-const patient_pain_value_recorded_inthepast2months_withunit_score_0_10 Real)
(declare-const patient_pain_value_recorded_inthepast2months_withunit_score_0_10@@measured_on_visual_analogue_scale_questionnaire Bool)
(declare-const patient_meets_abdominal_pain_criterion_inthepast2months Bool)
(declare-const patient_meets_abdominal_pain_criterion_inthepast2months@@refractory_to_original_enterra_gastric_electrical_stimulation_settings Bool)

;; Existing auxiliary assertions
(assert (! (= patient_meets_abdominal_pain_criterion_inthepast2months (or patient_has_finding_of_abdominal_pain_inthepast2months@@moderate_severity (and patient_has_finding_of_abdominal_pain_inthepast2months@@severe_severity patient_has_finding_of_abdominal_pain_inthepast2months@@reported_on_at_least_one_pain_questionnaire) (and patient_pain_value_recorded_inthepast2months_withunit_score_0_10@@measured_on_visual_analogue_scale_questionnaire (> patient_pain_value_recorded_inthepast2months_withunit_score_0_10 5)))) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_abdominal_pain_inthepast2months@@moderate_severity patient_has_finding_of_abdominal_pain_inthepast2months) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_finding_of_abdominal_pain_inthepast2months@@severe_severity patient_has_finding_of_abdominal_pain_inthepast2months) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_finding_of_abdominal_pain_inthepast2months@@reported_on_at_least_one_pain_questionnaire patient_has_finding_of_abdominal_pain_inthepast2months) :named REQ2_AUXILIARY3))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_meets_abdominal_pain_criterion_inthepast2months@@refractory_to_original_enterra_gastric_electrical_stimulation_settings patient_meets_abdominal_pain_criterion_inthepast2months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (and patient_has_finding_of_gastric_neurostimulator_device_in_situ_now (>= duration_of_gastric_neurostimulator_device_in_situ_now_in_months 2.0)) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_meets_abdominal_pain_criterion_inthepast2months :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_meets_abdominal_pain_criterion_inthepast2months :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_meets_abdominal_pain_criterion_inthepast2months@@refractory_to_original_enterra_gastric_electrical_stimulation_settings :named REQ3_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
