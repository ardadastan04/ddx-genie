;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_neurological_deficit_now Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@sudden_onset Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@presumed_secondary_to_focal_cerebral_ischemia Bool)
(declare-const planned_start_time_of_intravenous_administration_of_alteplase_value_in_hours_since_last_known_well Real)
(declare-const patient_has_finding_of_worsening_neurological_deficit_in_last_4_5_hours Bool)
(declare-const first_neurological_symptom_time_value_recorded_in_hours_since_last_known_well Real)
(declare-const patient_has_finding_of_acute_ischemic_stroke_now Bool)
(declare-const patient_has_finding_of_acute_ischemic_stroke_now@@measurable_neurological_deficit_of_sudden_onset_presumed_secondary_to_focal_cerebral_ischemia Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@attributable_to_acute_ischemic_stroke Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@in_middle_cerebral_artery_territory Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@is_disabling Bool)
(declare-const patient_national_institutes_of_health_stroke_scale_score_value_recorded_now_withunit_score Real)
(declare-const patient_national_institutes_of_health_stroke_scale_score_value_recorded_now_withunit_score@@for_left_hemisphere_acute_ischemic_stroke Bool)
(declare-const patient_national_institutes_of_health_stroke_scale_score_value_recorded_now_withunit_score@@for_other_acute_ischemic_stroke Bool)
(declare-const patient_has_evidence_of_occlusion_of_middle_cerebral_artery_stem_or_branch_prior_to_drug_administration Bool)
(declare-const patient_has_evidence_of_occlusion_of_middle_cerebral_artery_stem_or_branch_prior_to_drug_administration@@evidenced_by_transcranial_doppler_ultrasonography_or_ct_angiography_or_mr_angiography Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_acute_ischemic_stroke_now@@measurable_neurological_deficit_of_sudden_onset_presumed_secondary_to_focal_cerebral_ischemia (and patient_has_finding_of_neurological_deficit_now patient_has_finding_of_neurological_deficit_now@@sudden_onset patient_has_finding_of_neurological_deficit_now@@presumed_secondary_to_focal_cerebral_ischemia)) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_finding_of_acute_ischemic_stroke_now patient_has_finding_of_acute_ischemic_stroke_now@@measurable_neurological_deficit_of_sudden_onset_presumed_secondary_to_focal_cerebral_ischemia) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@attributable_to_acute_ischemic_stroke patient_has_finding_of_neurological_deficit_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@in_middle_cerebral_artery_territory patient_has_finding_of_neurological_deficit_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@is_disabling patient_has_finding_of_neurological_deficit_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_evidence_of_occlusion_of_middle_cerebral_artery_stem_or_branch_prior_to_drug_administration@@evidenced_by_transcranial_doppler_ultrasonography_or_ct_angiography_or_mr_angiography patient_has_evidence_of_occlusion_of_middle_cerebral_artery_stem_or_branch_prior_to_drug_administration) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_acute_ischemic_stroke_now@@measurable_neurological_deficit_of_sudden_onset_presumed_secondary_to_focal_cerebral_ischemia patient_has_finding_of_acute_ischemic_stroke_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@presumed_secondary_to_focal_cerebral_ischemia patient_has_finding_of_neurological_deficit_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@sudden_onset patient_has_finding_of_neurological_deficit_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! patient_has_finding_of_acute_ischemic_stroke_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (< planned_start_time_of_intravenous_administration_of_alteplase_value_in_hours_since_last_known_well 4.5) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not (and patient_has_finding_of_worsening_neurological_deficit_in_last_4_5_hours (>= (- planned_start_time_of_intravenous_administration_of_alteplase_value_in_hours_since_last_known_well first_neurological_symptom_time_value_recorded_in_hours_since_last_known_well) 4.5))) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (and patient_has_finding_of_neurological_deficit_now@@is_disabling patient_has_finding_of_neurological_deficit_now@@attributable_to_acute_ischemic_stroke patient_has_finding_of_neurological_deficit_now@@in_middle_cerebral_artery_territory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and patient_national_institutes_of_health_stroke_scale_score_value_recorded_now_withunit_score@@for_left_hemisphere_acute_ischemic_stroke (<= patient_national_institutes_of_health_stroke_scale_score_value_recorded_now_withunit_score 18)) (and patient_national_institutes_of_health_stroke_scale_score_value_recorded_now_withunit_score@@for_other_acute_ischemic_stroke (<= patient_national_institutes_of_health_stroke_scale_score_value_recorded_now_withunit_score 16))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_evidence_of_occlusion_of_middle_cerebral_artery_stem_or_branch_prior_to_drug_administration patient_has_evidence_of_occlusion_of_middle_cerebral_artery_stem_or_branch_prior_to_drug_administration@@evidenced_by_transcranial_doppler_ultrasonography_or_ct_angiography_or_mr_angiography) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 85) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
