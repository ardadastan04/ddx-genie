;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_days Real)
(declare-const patient_gestational_age_value_recorded_now_in_weeks Real)
(declare-const parents_refuse_to_cooperate Bool)
(declare-const patient_has_finding_of_sepsis_now Bool)
(declare-const patient_has_finding_of_co_morbid_conditions_now Bool)

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_days 2)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_age_value_recorded_now_in_days 28)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (< patient_gestational_age_value_recorded_now_in_weeks 35)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_gestational_age_value_recorded_now_in_weeks 42)) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not parents_refuse_to_cooperate) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_sepsis_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_co_morbid_conditions_now) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
