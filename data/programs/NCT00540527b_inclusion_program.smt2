;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_neurological_deficit_now Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@sudden_and_focal Bool)
(declare-const patient_has_finding_of_neurological_deficit_now@@attributable_to_stroke Bool)
(declare-const symptoms_time_of_onset_recorded_datetime Real)
(declare-const patient_has_clearly_defined_time_of_onset_of_symptoms Bool)
(declare-const intravenous_treatment_possible_within_3_hours_of_symptom_onset Bool)
(declare-const intra_arterial_treatment_possible_within_6_hours_of_symptom_onset Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@sudden_and_focal patient_has_finding_of_neurological_deficit_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_neurological_deficit_now@@attributable_to_stroke patient_has_finding_of_neurological_deficit_now) :named REQ0_AUXILIARY1))
(assert (! (= patient_has_clearly_defined_time_of_onset_of_symptoms (not (= symptoms_time_of_onset_recorded_datetime 0))) :named REQ1_AUXILIARY0))
(assert (! (=> intravenous_treatment_possible_within_3_hours_of_symptom_onset patient_has_clearly_defined_time_of_onset_of_symptoms) :named REQ1_AUXILIARY1))
(assert (! (=> intra_arterial_treatment_possible_within_6_hours_of_symptom_onset patient_has_clearly_defined_time_of_onset_of_symptoms) :named REQ1_AUXILIARY2))

;; Other kept assertions
(assert (! (and patient_has_finding_of_neurological_deficit_now@@sudden_and_focal patient_has_finding_of_neurological_deficit_now@@attributable_to_stroke) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_clearly_defined_time_of_onset_of_symptoms :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or intravenous_treatment_possible_within_3_hours_of_symptom_onset intra_arterial_treatment_possible_within_6_hours_of_symptom_onset) :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (<= patient_age_value_recorded_now_in_years 80) :named REQ2_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
