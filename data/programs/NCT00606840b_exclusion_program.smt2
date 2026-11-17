;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kgperm2 Real)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_eating_disorder_inthehistory Bool)
(declare-const patient_has_finding_of_eating_disorder_now Bool)
(declare-const patient_has_finding_of_substance_misuse_behavior_inthehistory Bool)
(declare-const patient_has_finding_of_substance_misuse_behavior_now Bool)
(declare-const patient_weight_decreased_value_recorded_now_withunit_percent Real)
(declare-const patient_weight_decreased_value_recorded_now_withunit_percent@@recent Bool)
(declare-const patient_has_recent_weight_loss_greater_than_5_percent Bool)
(declare-const patient_has_recent_weight_loss_greater_than_5_percent@@strong_clinical_support Bool)
(declare-const patient_is_currently_enrolled_in_another_research_study_that_would_interfere Bool)

;; Existing auxiliary assertions
(assert (! (=> (and patient_weight_decreased_value_recorded_now_withunit_percent@@recent (> patient_weight_decreased_value_recorded_now_withunit_percent 5)) patient_has_recent_weight_loss_greater_than_5_percent) :named REQ3_AUXILIARY0_BRIDGE))
(assert (! (=> patient_has_recent_weight_loss_greater_than_5_percent@@strong_clinical_support patient_has_recent_weight_loss_greater_than_5_percent) :named REQ3_AUXILIARY1_BRIDGE))

;; Other kept assertions
(assert (! (not (< patient_finding_of_body_mass_index_value_recorded_now_withunit_kgperm2 23)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_finding_of_body_mass_index_value_recorded_now_withunit_kgperm2 30)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_age_value_recorded_now_in_years 35)) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_eating_disorder_inthehistory) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_substance_misuse_behavior_inthehistory) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_eating_disorder_now) :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_substance_misuse_behavior_now) :named REQ2_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_recent_weight_loss_greater_than_5_percent) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_currently_enrolled_in_another_research_study_that_would_interfere) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
