;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_other_than_parkinson_s_disease_now Bool)
(declare-const mattis_dementia_rating_scale_total_score_value_recorded_most_recent_withunit_points Real)
(declare-const patient_has_diagnosis_of_dementia_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_parturient_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_diagnosis_of_dementia_now (< mattis_dementia_rating_scale_total_score_value_recorded_most_recent_withunit_points 130)) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_other_than_parkinson_s_disease_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_dementia_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_parturient_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
