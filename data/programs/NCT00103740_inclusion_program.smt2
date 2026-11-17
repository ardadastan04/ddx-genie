;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=4 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_serum_alkaline_phosphatase_level_finding_value_recorded_now_withunit_u_per_l Real)
(declare-const upper_limit_of_normal_for_serum_alkaline_phosphatase_value_now_withunit_u_per_l Real)
(declare-const patient_has_diagnosis_of_osteitis_deformans_now Bool)
(declare-const patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_at_least_one_imaging_modality_xray_mri_ct_radioisotope Bool)
(declare-const patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_xray Bool)
(declare-const patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_mri Bool)
(declare-const patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_ct Bool)
(declare-const patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_radioisotope_imaging Bool)
(declare-const patient_has_washout_period_from_bisphosphonate_in_history Bool)
(declare-const washout_period_from_bisphosphonate_duration_in_days Real)
(declare-const patient_has_allergic_reaction_to_bisphosphonates_in_history Bool)
(declare-const patient_has_history_of_upper_gastrointestinal_disorder Bool)
(declare-const patient_has_history_of_iritis_or_uveitis Bool)
(declare-const calculated_creatinine_clearance_at_baseline_withunit_ml_per_min Real)
(declare-const patient_has_evidence_of_vitamin_d_deficiency_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_xray patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_at_least_one_imaging_modality_xray_mri_ct_radioisotope) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_mri patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_at_least_one_imaging_modality_xray_mri_ct_radioisotope) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_ct patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_at_least_one_imaging_modality_xray_mri_ct_radioisotope) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_radioisotope_imaging patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_at_least_one_imaging_modality_xray_mri_ct_radioisotope) :named REQ2_AUXILIARY3))
(assert (! (=> patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_at_least_one_imaging_modality_xray_mri_ct_radioisotope patient_has_diagnosis_of_osteitis_deformans_now) :named REQ2_AUXILIARY4))
(assert (! (=> (>= washout_period_from_bisphosphonate_duration_in_days 0) patient_has_washout_period_from_bisphosphonate_in_history) :named REQ4_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_ct patient_has_diagnosis_of_osteitis_deformans_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_mri patient_has_diagnosis_of_osteitis_deformans_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_radioisotope_imaging patient_has_diagnosis_of_osteitis_deformans_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_xray patient_has_diagnosis_of_osteitis_deformans_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 30) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_serum_alkaline_phosphatase_level_finding_value_recorded_now_withunit_u_per_l (* 2 upper_limit_of_normal_for_serum_alkaline_phosphatase_value_now_withunit_u_per_l)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_diagnosis_of_osteitis_deformans_now patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_at_least_one_imaging_modality_xray_mri_ct_radioisotope) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= washout_period_from_bisphosphonate_duration_in_days 180) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_allergic_reaction_to_bisphosphonates_in_history) :named REQ5_COMPONENT0_EXCLUSION))
(assert (! (not patient_has_history_of_upper_gastrointestinal_disorder) :named REQ6_COMPONENT0_EXCLUSION))
(assert (! (not patient_has_history_of_iritis_or_uveitis) :named REQ7_COMPONENT0_EXCLUSION))
(assert (! (>= calculated_creatinine_clearance_at_baseline_withunit_ml_per_min 30) :named REQ8_COMPONENT0_EXCLUSION))
(assert (! (not patient_has_evidence_of_vitamin_d_deficiency_now) :named REQ9_COMPONENT0_EXCLUSION))
