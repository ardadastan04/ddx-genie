;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_relapsing_remitting_multiple_sclerosis_now Bool)
(declare-const patient_has_diagnosis_of_relapsing_remitting_multiple_sclerosis_now@@diagnosed_in_accordance_with_2017_revised_mcdonald_criteria_thompson_2018 Bool)
(declare-const patient_has_diagnosis_of_secondary_progressive_multiple_sclerosis_now Bool)
(declare-const patient_has_diagnosis_of_secondary_progressive_multiple_sclerosis_now@@diagnosed_in_accordance_with_2017_revised_mcdonald_criteria_thompson_2018 Bool)
(declare-const patient_has_diagnosis_of_secondary_progressive_multiple_sclerosis_now@@with_relapses Bool)
(declare-const patient_number_of_documented_relapses_within_2_years_before_screening Real)
(declare-const patient_number_of_documented_relapses_within_1_year_before_randomization Real)
(declare-const patient_has_finding_of_finding_of_lesion_inthehistory Bool)
(declare-const patient_has_finding_of_finding_of_lesion_inthehistory@@gadolinium_enhancing Bool)
(declare-const patient_has_finding_of_finding_of_lesion_inthehistory@@temporalcontext_within6months_before_randomization Bool)
(declare-const expanded_disability_status_scale_score_value_recorded_at_baseline_withunit_none Real)
(declare-const expanded_disability_status_scale_score_value_recorded_at_screening_withunit_none Real)
(declare-const disease_duration_since_onset_value_in_years Real)
(declare-const patient_is_neurologically_stable_for_at_least_30_days_prior_to_screening Bool)
(declare-const patient_is_neurologically_stable_for_at_least_30_days_prior_to_baseline Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_breastfeeding_now Bool)
(declare-const patient_is_postmenopausal_now Bool)
(declare-const patient_is_infertile_now Bool)
(declare-const patient_is_using_effective_method_of_contraception_for_duration_of_study_now Bool)
(declare-const patient_lacks_childbearing_potential_now Bool)
(declare-const patient_meets_female_reproductive_eligibility_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_relapsing_remitting_multiple_sclerosis_now@@diagnosed_in_accordance_with_2017_revised_mcdonald_criteria_thompson_2018 patient_has_diagnosis_of_relapsing_remitting_multiple_sclerosis_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_secondary_progressive_multiple_sclerosis_now@@diagnosed_in_accordance_with_2017_revised_mcdonald_criteria_thompson_2018 patient_has_diagnosis_of_secondary_progressive_multiple_sclerosis_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_secondary_progressive_multiple_sclerosis_now@@with_relapses patient_has_diagnosis_of_secondary_progressive_multiple_sclerosis_now) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_finding_of_finding_of_lesion_inthehistory@@gadolinium_enhancing patient_has_finding_of_finding_of_lesion_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_finding_of_lesion_inthehistory@@temporalcontext_within6months_before_randomization patient_has_finding_of_finding_of_lesion_inthehistory) :named REQ1_AUXILIARY1))
(assert (! (= patient_lacks_childbearing_potential_now (or patient_is_postmenopausal_now patient_is_infertile_now)) :named REQ4_AUXILIARY0))
(assert (! (= patient_meets_female_reproductive_eligibility_now (and (not patient_is_pregnant_now) (not patient_is_breastfeeding_now) (or patient_lacks_childbearing_potential_now patient_is_using_effective_method_of_contraception_for_duration_of_study_now))) :named REQ4_AUXILIARY1))

;; Other kept assertions
(assert (! (or patient_has_diagnosis_of_relapsing_remitting_multiple_sclerosis_now@@diagnosed_in_accordance_with_2017_revised_mcdonald_criteria_thompson_2018 (and patient_has_diagnosis_of_secondary_progressive_multiple_sclerosis_now@@with_relapses patient_has_diagnosis_of_secondary_progressive_multiple_sclerosis_now@@diagnosed_in_accordance_with_2017_revised_mcdonald_criteria_thompson_2018)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= patient_number_of_documented_relapses_within_2_years_before_screening 1) (or (>= patient_number_of_documented_relapses_within_1_year_before_randomization 1) (and patient_has_finding_of_finding_of_lesion_inthehistory@@gadolinium_enhancing patient_has_finding_of_finding_of_lesion_inthehistory@@temporalcontext_within6months_before_randomization))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (>= expanded_disability_status_scale_score_value_recorded_at_baseline_withunit_none 0.0) (<= expanded_disability_status_scale_score_value_recorded_at_baseline_withunit_none 5.5)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (=> (<= expanded_disability_status_scale_score_value_recorded_at_screening_withunit_none 2.0) (<= disease_duration_since_onset_value_in_years 10.0)) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_neurologically_stable_for_at_least_30_days_prior_to_screening :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_neurologically_stable_for_at_least_30_days_prior_to_baseline :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or (not patient_sex_is_female_now) patient_meets_female_reproductive_eligibility_now) :named REQ4_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
