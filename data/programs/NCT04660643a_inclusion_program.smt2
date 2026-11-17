;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter Real)
(declare-const patient_body_weight_value_recorded_now_withunit_kilograms Real)
(declare-const patient_body_height_value_recorded_now_withunit_meters Real)
(declare-const patient_bmi_calculated_from_weight_and_height_now_withunit_kilograms_per_square_meter Real)
(declare-const patient_meets_bmi_requirement_now Bool)
(declare-const patient_has_history_of_unsuccessful_dietary_effort_to_lose_body_weight Bool)
(declare-const patient_number_of_unsuccessful_dietary_efforts_to_lose_body_weight_in_the_history Int)

;; Existing auxiliary assertions
(assert (! (= patient_bmi_calculated_from_weight_and_height_now_withunit_kilograms_per_square_meter (/ patient_body_weight_value_recorded_now_withunit_kilograms (* patient_body_height_value_recorded_now_withunit_meters patient_body_height_value_recorded_now_withunit_meters))) :named REQ0_AUXILIARY0))
(assert (! (= patient_meets_bmi_requirement_now (or (>= patient_body_mass_index_value_recorded_now_withunit_kilograms_per_square_meter 30.0) (>= patient_bmi_calculated_from_weight_and_height_now_withunit_kilograms_per_square_meter 30.0))) :named REQ0_AUXILIARY1))
(assert (! (= patient_has_history_of_unsuccessful_dietary_effort_to_lose_body_weight (>= patient_number_of_unsuccessful_dietary_efforts_to_lose_body_weight_in_the_history 1)) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! patient_meets_bmi_requirement_now :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_history_of_unsuccessful_dietary_effort_to_lose_body_weight :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
