;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)

;; Other kept assertions
(assert (! (or patient_sex_is_male_now patient_sex_is_female_now) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 30.0) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (< patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 40.0) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
