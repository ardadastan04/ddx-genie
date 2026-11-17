;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter Real)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_eating_disorder_inthehistory Bool)
(declare-const patient_has_finding_of_eating_disorder_now Bool)
(declare-const patient_has_finding_of_substance_misuse_behavior_inthehistory Bool)
(declare-const patient_has_finding_of_substance_misuse_behavior_now Bool)
(declare-const patient_has_finding_of_eating_disorder_inthehistory@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_eating_disorder_now@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_substance_misuse_behavior_inthehistory@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_substance_misuse_behavior_now@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_weight_decreased_now Bool)
(declare-const patient_has_finding_of_weight_decreased_now@@recent Bool)
(declare-const patient_weight_value_recorded_previous_withunit_kilograms Real)
(declare-const patient_weight_value_recorded_recent_withunit_kilograms Real)
(declare-const patient_has_finding_of_weight_decreased_now@@recent@@strong_clinical_support Bool)
(declare-const patient_is_enrolled_in_other_research_study_now Bool)
(declare-const patient_is_enrolled_in_other_research_study_now@@would_interfere Bool)
(declare-const patient_is_enrolled_in_other_research_study_now@@would_interfere@@strong_clinical_support Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_eating_disorder_inthehistory@@strong_clinical_support patient_has_finding_of_eating_disorder_inthehistory) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_eating_disorder_now@@strong_clinical_support patient_has_finding_of_eating_disorder_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_finding_of_substance_misuse_behavior_inthehistory@@strong_clinical_support patient_has_finding_of_substance_misuse_behavior_inthehistory) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_finding_of_substance_misuse_behavior_now@@strong_clinical_support patient_has_finding_of_substance_misuse_behavior_now) :named REQ2_AUXILIARY3))
(assert (! (=> patient_has_finding_of_weight_decreased_now@@recent patient_has_finding_of_weight_decreased_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_weight_decreased_now@@recent@@strong_clinical_support patient_has_finding_of_weight_decreased_now@@recent) :named REQ3_AUXILIARY1))
(assert (! (=> patient_is_enrolled_in_other_research_study_now@@would_interfere patient_is_enrolled_in_other_research_study_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_is_enrolled_in_other_research_study_now@@would_interfere@@strong_clinical_support patient_is_enrolled_in_other_research_study_now@@would_interfere) :named REQ4_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_weight_decreased_now@@recent@@strong_clinical_support patient_has_finding_of_weight_decreased_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_is_enrolled_in_other_research_study_now@@would_interfere@@strong_clinical_support patient_is_enrolled_in_other_research_study_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not (< patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 23)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_finding_of_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 30)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_age_value_recorded_now_in_years 35)) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_eating_disorder_inthehistory) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_substance_misuse_behavior_inthehistory) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_eating_disorder_now) :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_substance_misuse_behavior_now) :named REQ2_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not (or (and patient_has_finding_of_weight_decreased_now@@recent (> (- patient_weight_value_recorded_previous_withunit_kilograms patient_weight_value_recorded_recent_withunit_kilograms) (* 0.05 patient_weight_value_recorded_previous_withunit_kilograms))) patient_has_finding_of_weight_decreased_now@@recent@@strong_clinical_support)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_enrolled_in_other_research_study_now@@would_interfere) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
