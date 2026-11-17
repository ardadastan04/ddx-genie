;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_capable_of_giving_consent Bool)
(declare-const patient_is_able_to_fill_in_questionnaire_in_italian_language Bool)
(declare-const patient_has_undergone_thyroidectomy_inthehistory Bool)
(declare-const patient_serum_thyroglobulin_level_value_recorded_now_withunit_nanograms_per_milliliter Real)
(declare-const patient_anti_thyroglobulin_antibody_value_recorded_now_withunit_international_units_per_milliliter Real)
(declare-const patient_anti_thyroglobulin_antibody_lower_limit_of_normal_value_now_withunit_international_units_per_milliliter Real)
(declare-const patient_is_exposed_to_levothyroxine_inthepast3months Bool)
(declare-const patient_is_exposed_to_levothyroxine_inthepast3months@@tablet_form Bool)
(declare-const patient_is_exposed_to_levothyroxine_inthepast3months@@stable_doses Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_levothyroxine_inthepast3months@@tablet_form patient_is_exposed_to_levothyroxine_inthepast3months) :named REQ5_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_levothyroxine_inthepast3months@@stable_doses patient_is_exposed_to_levothyroxine_inthepast3months) :named REQ5_AUXILIARY1))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_capable_of_giving_consent :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_fill_in_questionnaire_in_italian_language :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_thyroidectomy_inthehistory :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (< patient_serum_thyroglobulin_level_value_recorded_now_withunit_nanograms_per_milliliter 0.2) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< patient_anti_thyroglobulin_antibody_value_recorded_now_withunit_international_units_per_milliliter patient_anti_thyroglobulin_antibody_lower_limit_of_normal_value_now_withunit_international_units_per_milliliter) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and patient_is_exposed_to_levothyroxine_inthepast3months@@tablet_form patient_is_exposed_to_levothyroxine_inthepast3months@@stable_doses) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
