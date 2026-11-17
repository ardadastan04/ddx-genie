;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_adult_now Bool)
(declare-const patient_has_finding_of_subclinical_hypothyroidism_now Bool)
(declare-const patient_thyrotrophin_value_recorded_now_withunit_milliunits_per_liter Real)
(declare-const patient_thyroxine_value_recorded_now_withunit_nanograms_per_deciliter Real)
(declare-const patient_triiodothyronine_value_recorded_now_withunit_nanograms_per_deciliter Real)
(declare-const patient_thyroxine_value_is_normal_now Bool)
(declare-const patient_triiodothyronine_value_is_normal_now Bool)
(declare-const patient_thyroxine_normal_reference_range_lower Real)
(declare-const patient_thyroxine_normal_reference_range_upper Real)
(declare-const patient_triiodothyronine_normal_reference_range_lower Real)
(declare-const patient_triiodothyronine_normal_reference_range_upper Real)

;; Existing auxiliary assertions
(assert (! (= patient_thyroxine_value_is_normal_now (and (>= patient_thyroxine_value_recorded_now_withunit_nanograms_per_deciliter patient_thyroxine_normal_reference_range_lower) (<= patient_thyroxine_value_recorded_now_withunit_nanograms_per_deciliter patient_thyroxine_normal_reference_range_upper))) :named REQ0_AUXILIARY0))
(assert (! (= patient_triiodothyronine_value_is_normal_now (and (>= patient_triiodothyronine_value_recorded_now_withunit_nanograms_per_deciliter patient_triiodothyronine_normal_reference_range_lower) (<= patient_triiodothyronine_value_recorded_now_withunit_nanograms_per_deciliter patient_triiodothyronine_normal_reference_range_upper))) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! patient_is_adult_now :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_subclinical_hypothyroidism_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_thyrotrophin_value_recorded_now_withunit_milliunits_per_liter 4.0) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_thyroxine_value_is_normal_now :named REQ0_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! patient_triiodothyronine_value_is_normal_now :named REQ0_COMPONENT4_OTHER_REQUIREMENTS))
