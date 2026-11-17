;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_needs_to_undergo_excision_of_thymus_now Bool)
(declare-const patient_needs_to_undergo_excision_of_thymus_now@@indication_is_elective Bool)
(declare-const patient_needs_to_undergo_excision_of_thymus_now@@indication_due_to_thymoma Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_needs_to_undergo_excision_of_thymus_now@@indication_is_elective patient_needs_to_undergo_excision_of_thymus_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_needs_to_undergo_excision_of_thymus_now@@indication_due_to_thymoma patient_needs_to_undergo_excision_of_thymus_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 17) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_needs_to_undergo_excision_of_thymus_now@@indication_is_elective patient_needs_to_undergo_excision_of_thymus_now@@indication_due_to_thymoma) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ2_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
