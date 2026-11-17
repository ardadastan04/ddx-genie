;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_hoehn_and_yahr_scale_score_value_recorded_now_withunit_none Real)
(declare-const patient_can_independently_walk_distance_value_recorded_in_meters Real)
(declare-const patient_has_cognitive_ability_to_follow_simple_commands_now Bool)

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 50.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_hoehn_and_yahr_scale_score_value_recorded_now_withunit_none 1) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_hoehn_and_yahr_scale_score_value_recorded_now_withunit_none 3) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_can_independently_walk_distance_value_recorded_in_meters 3.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_cognitive_ability_to_follow_simple_commands_now :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
