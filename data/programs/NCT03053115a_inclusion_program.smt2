;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_capable_of_giving_consent Bool)
(declare-const patient_has_absence_of_thyroid_gland_due_to_thyroidectomy_now Bool)
(declare-const patient_serum_thyroglobulin_level_value_recorded_now_withunit_ng_per_ml Real)
(declare-const patient_anti_thyroglobulin_antibody_value_recorded_now_withunit_units_per_ml Real)
(declare-const lower_limit_of_normal_range_for_anti_thyroglobulin_antibody_withunit_units_per_ml Real)
(declare-const patient_is_exposed_to_levothyroxine_sodium_inthepast3months Bool)
(declare-const patient_is_exposed_to_levothyroxine_sodium_inthepast3months@@administered_as_tablets Bool)
(declare-const patient_is_exposed_to_levothyroxine_sodium_inthepast3months@@in_stable_doses Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_levothyroxine_sodium_inthepast3months@@administered_as_tablets patient_is_exposed_to_levothyroxine_sodium_inthepast3months) :named REQ5_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_levothyroxine_sodium_inthepast3months@@in_stable_doses patient_is_exposed_to_levothyroxine_sodium_inthepast3months) :named REQ5_AUXILIARY1))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_capable_of_giving_consent :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_absence_of_thyroid_gland_due_to_thyroidectomy_now :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (< patient_serum_thyroglobulin_level_value_recorded_now_withunit_ng_per_ml 0.2) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< patient_anti_thyroglobulin_antibody_value_recorded_now_withunit_units_per_ml lower_limit_of_normal_range_for_anti_thyroglobulin_antibody_withunit_units_per_ml) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and patient_is_exposed_to_levothyroxine_sodium_inthepast3months@@administered_as_tablets patient_is_exposed_to_levothyroxine_sodium_inthepast3months@@in_stable_doses) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
