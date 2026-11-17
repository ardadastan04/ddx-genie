;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_presented_to_emergency_department_during_study_period Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_asthma_inthehistory Bool)
(declare-const patient_has_diagnosis_of_asthma_inthehistory@@as_reported_by_a_parent Bool)
(declare-const patient_has_diagnosis_of_asthma_inthehistory@@physician_diagnosed_as_reported_by_a_parent Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_asthma_inthehistory@@as_reported_by_a_parent patient_has_diagnosis_of_asthma_inthehistory) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_asthma_inthehistory@@physician_diagnosed_as_reported_by_a_parent patient_has_diagnosis_of_asthma_inthehistory@@as_reported_by_a_parent) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_asthma_inthehistory@@physician_diagnosed_as_reported_by_a_parent patient_has_diagnosis_of_asthma_inthehistory) :named REQ2_AUXILIARY2))

;; Other kept assertions
(assert (! patient_has_presented_to_emergency_department_during_study_period :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 1.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 17.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_asthma_inthehistory@@physician_diagnosed_as_reported_by_a_parent :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
