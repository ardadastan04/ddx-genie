;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_antithyroperoxidase_antibody_value_recorded_now_withunit_international_units_per_milliliter Real)
(declare-const patient_anti_thyroglobulin_antibody_value_recorded_now_withunit_international_units_per_milliliter Real)
(declare-const patient_has_positive_titer_of_antithyroperoxidase_antibody_now Bool)
(declare-const patient_has_positive_titer_of_antithyroglobulin_antibody_now Bool)
(declare-const patient_has_finding_of_thyroid_dysfunction_now Bool)
(declare-const patient_is_undergoing_levothyroxine_therapy_now Bool)
(declare-const patient_thyrotrophin_value_recorded_now_withunit_mcu_per_ml Real)
(declare-const patient_free_thyroxine_value_recorded_now_withunit_unspecified Real)
(declare-const patient_free_triiodothyronine_value_recorded_now_withunit_unspecified Real)
(declare-const patient_free_thyroxine_reference_range_upper_now_withunit_unspecified Real)
(declare-const patient_free_triiodothyronine_reference_range_upper_now_withunit_unspecified Real)

;; Existing auxiliary assertions
(assert (! (= patient_has_positive_titer_of_antithyroperoxidase_antibody_now (> patient_antithyroperoxidase_antibody_value_recorded_now_withunit_international_units_per_milliliter 60)) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_positive_titer_of_antithyroglobulin_antibody_now (> patient_anti_thyroglobulin_antibody_value_recorded_now_withunit_international_units_per_milliliter 60)) :named REQ0_AUXILIARY1))
(assert (! (<= patient_free_thyroxine_value_recorded_now_withunit_unspecified patient_free_thyroxine_reference_range_upper_now_withunit_unspecified) :named REQ1_AUXILIARY0))
(assert (! (<= patient_free_triiodothyronine_value_recorded_now_withunit_unspecified patient_free_triiodothyronine_reference_range_upper_now_withunit_unspecified) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! (or patient_has_positive_titer_of_antithyroperoxidase_antibody_now patient_has_positive_titer_of_antithyroglobulin_antibody_now) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_finding_of_thyroid_dysfunction_now patient_is_undergoing_levothyroxine_therapy_now (> patient_thyrotrophin_value_recorded_now_withunit_mcu_per_ml 5.0) (or (<= patient_free_thyroxine_value_recorded_now_withunit_unspecified patient_free_thyroxine_reference_range_upper_now_withunit_unspecified) (<= patient_free_triiodothyronine_value_recorded_now_withunit_unspecified patient_free_triiodothyronine_reference_range_upper_now_withunit_unspecified))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
