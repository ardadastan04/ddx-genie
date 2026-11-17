;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_neurological_deficit_now Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@sudden_onset Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@focal Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@attributable_to_stroke Bool)
(declare-const patient_has_clearly_defined_time_of_onset Bool)
(declare-const time_from_symptom_onset_to_intravenous_treatment_in_hours Real)
(declare-const time_from_symptom_onset_to_intra_arterial_treatment_in_hours Real)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@sudden_onset patient_has_finding_of_neurological_deficit_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@focal patient_has_finding_of_neurological_deficit_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@attributable_to_stroke patient_has_finding_of_neurological_deficit_now) :named REQ0_AUXILIARY2))

;; Other kept assertions
(assert (! (and patient_has_finding_of_neurological_deficit_now@@sudden_onset patient_has_finding_of_neurological_deficit_now@@focal) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_neurological_deficit_now@@attributable_to_stroke :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_clearly_defined_time_of_onset :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (<= time_from_symptom_onset_to_intravenous_treatment_in_hours 3.0) :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (<= time_from_symptom_onset_to_intra_arterial_treatment_in_hours 6.0) :named REQ1_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 80.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
