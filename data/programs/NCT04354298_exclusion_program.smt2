;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const montreal_cognitive_assessment_score_value_recorded_withunit_points Real)
(declare-const patient_has_diagnosis_of_co_morbid_conditions_now Bool)
(declare-const patient_has_diagnosis_of_co_morbid_conditions_now@@severe Bool)
(declare-const patient_has_finding_of_physical_activity_barrier_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_co_morbid_conditions_now@@severe patient_has_diagnosis_of_co_morbid_conditions_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not (<= montreal_cognitive_assessment_score_value_recorded_withunit_points 22)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_co_morbid_conditions_now@@severe) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_physical_activity_barrier_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
