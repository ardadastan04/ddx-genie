;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_relapsing_remitting_multiple_sclerosis_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_illness_value_recorded_now_withunit_years Real)
(declare-const patient_has_finding_of_recurrent_disease_inthepast3months Bool)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)

;; Other kept assertions
(assert (! patient_has_diagnosis_of_relapsing_remitting_multiple_sclerosis_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 20.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 40.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (<= patient_illness_value_recorded_now_withunit_years 10.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_recurrent_disease_inthepast3months) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 25.0) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 35.0) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
