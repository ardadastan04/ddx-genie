;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_exposed_to_antithyroperoxidase_antibody_now Bool)
(declare-const patient_is_exposed_to_anti_thyroglobulin_antibody_now Bool)
(declare-const patient_has_positive_antithyroperoxidase_antibody_titer_now Bool)
(declare-const patient_has_positive_anti_thyroglobulin_antibody_titer_now Bool)
(declare-const patient_has_finding_of_thyroid_dysfunction_now Bool)
(declare-const patient_is_receiving_levothyroxine_substitution_treatment_now Bool)
(declare-const patient_thyroid_stimulating_hormone_measurement_value_recorded_now_withunit_micro_international_units_per_milliliter Real)
(declare-const patient_has_finding_of_decreased_thyroxine_level_now Bool)
(declare-const patient_has_finding_of_serum_t4_level_normal_now Bool)
(declare-const patient_has_finding_of_decreased_triiodothyronine_level_now Bool)
(declare-const patient_has_finding_of_serum_t3_level_normal_now Bool)
(declare-const patient_has_finding_of_goiter_now Bool)
(declare-const patient_has_undergone_us_scan_of_thyroid_now_outcome_is_abnormal Bool)
(declare-const patient_has_finding_of_thyroid_dysfunction_now@@requires_levothyroxine_substitution Bool)
(declare-const patient_has_finding_of_thyroid_dysfunction_now@@tsh_above_5_and_t4_or_t3_decreased_or_normal Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_positive_antithyroperoxidase_antibody_titer_now patient_is_exposed_to_antithyroperoxidase_antibody_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_positive_anti_thyroglobulin_antibody_titer_now patient_is_exposed_to_anti_thyroglobulin_antibody_now) :named REQ0_AUXILIARY1))
(assert (! (= patient_has_finding_of_thyroid_dysfunction_now@@requires_levothyroxine_substitution (and patient_has_finding_of_thyroid_dysfunction_now patient_is_receiving_levothyroxine_substitution_treatment_now)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_finding_of_thyroid_dysfunction_now@@tsh_above_5_and_t4_or_t3_decreased_or_normal (and (> patient_thyroid_stimulating_hormone_measurement_value_recorded_now_withunit_micro_international_units_per_milliliter 5.0) (or patient_has_finding_of_decreased_thyroxine_level_now patient_has_finding_of_serum_t4_level_normal_now patient_has_finding_of_decreased_triiodothyronine_level_now patient_has_finding_of_serum_t3_level_normal_now))) :named REQ1_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_thyroid_dysfunction_now@@requires_levothyroxine_substitution patient_has_finding_of_thyroid_dysfunction_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_thyroid_dysfunction_now@@tsh_above_5_and_t4_or_t3_decreased_or_normal patient_has_finding_of_thyroid_dysfunction_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (or patient_has_positive_antithyroperoxidase_antibody_titer_now patient_has_positive_anti_thyroglobulin_antibody_titer_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_thyroid_dysfunction_now@@tsh_above_5_and_t4_or_t3_decreased_or_normal patient_has_finding_of_goiter_now patient_has_undergone_us_scan_of_thyroid_now_outcome_is_abnormal) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
