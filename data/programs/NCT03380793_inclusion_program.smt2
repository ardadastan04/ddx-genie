;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_suppurative_appendicitis_now Bool)
(declare-const patient_has_diagnosis_of_gangrenous_appendicitis_now Bool)
(declare-const patient_has_finding_of_right_sided_abdominal_pain_now@@metastatic Bool)
(declare-const patient_has_finding_of_abdominal_tenderness_now@@located_in_lower_abdomen Bool)
(declare-const patient_has_finding_of_rebound_tenderness_now Bool)
(declare-const patient_axillary_temperature_value_recorded_now_withunit_degrees_celsius Real)
(declare-const patient_white_blood_cell_count_value_recorded_now_withunit_10e9_per_liter@@measured_on_routine_blood_examination Real)
(declare-const lower_abdominal_tenderness_or_rebound_now Bool)
(declare-const pyrexia_criteria_met_now Bool)
(declare-const wbc_criteria_met_now Bool)
(declare-const gangrenous_appendicitis_criteria_met_now Bool)
(declare-const patient_has_finding_of_right_sided_abdominal_pain_now Bool)
(declare-const patient_has_finding_of_abdominal_tenderness_now Bool)

;; Existing auxiliary assertions
(assert (! (= lower_abdominal_tenderness_or_rebound_now (or patient_has_finding_of_abdominal_tenderness_now@@located_in_lower_abdomen patient_has_finding_of_rebound_tenderness_now)) :named REQ1_AUXILIARY0))
(assert (! (= pyrexia_criteria_met_now (>= patient_axillary_temperature_value_recorded_now_withunit_degrees_celsius 37.5)) :named REQ1_AUXILIARY1))
(assert (! (= wbc_criteria_met_now (> patient_white_blood_cell_count_value_recorded_now_withunit_10e9_per_liter@@measured_on_routine_blood_examination 10.0)) :named REQ1_AUXILIARY2))
(assert (! (= gangrenous_appendicitis_criteria_met_now (and patient_has_diagnosis_of_gangrenous_appendicitis_now patient_has_finding_of_right_sided_abdominal_pain_now@@metastatic lower_abdominal_tenderness_or_rebound_now pyrexia_criteria_met_now wbc_criteria_met_now)) :named REQ1_AUXILIARY3))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_abdominal_tenderness_now@@located_in_lower_abdomen patient_has_finding_of_abdominal_tenderness_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_right_sided_abdominal_pain_now@@metastatic patient_has_finding_of_right_sided_abdominal_pain_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 65) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or patient_has_diagnosis_of_suppurative_appendicitis_now gangrenous_appendicitis_criteria_met_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
