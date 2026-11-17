;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_acute_upper_gastrointestinal_hemorrhage_now Bool)
(declare-const patient_presents_to_emergency_department_with_acute_upper_gastrointestinal_bleeding_now Bool)
(declare-const patient_presents_to_emergency_department_with_overt_upper_gastrointestinal_bleeding_now Bool)
(declare-const patient_has_finding_of_upper_gastrointestinal_bleeding_now Bool)
(declare-const patient_has_finding_of_upper_gastrointestinal_bleeding_now@@overt Bool)
(declare-const patient_has_finding_of_coffee_ground_vomiting_now Bool)
(declare-const patient_has_finding_of_melena_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_coffee_ground_vomiting_now patient_has_finding_of_melena_now) patient_has_finding_of_upper_gastrointestinal_bleeding_now@@overt) :named REQ0_AUXILIARY0))
(assert (! (=> patient_presents_to_emergency_department_with_overt_upper_gastrointestinal_bleeding_now patient_has_finding_of_upper_gastrointestinal_bleeding_now@@overt) :named REQ0_AUXILIARY1))
(assert (! (=> patient_presents_to_emergency_department_with_acute_upper_gastrointestinal_bleeding_now patient_has_finding_of_acute_upper_gastrointestinal_hemorrhage_now) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_finding_of_upper_gastrointestinal_bleeding_now@@overt patient_has_finding_of_upper_gastrointestinal_bleeding_now) :named REQ0_AUXILIARY3))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_presents_to_emergency_department_with_acute_upper_gastrointestinal_bleeding_now patient_presents_to_emergency_department_with_overt_upper_gastrointestinal_bleeding_now) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_finding_of_coffee_ground_vomiting_now patient_has_finding_of_melena_now) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
