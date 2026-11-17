;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_caucasian_affinity Bool)
(declare-const patient_has_caucasian_origin Bool)
(declare-const patient_age_of_diagnosis_value_recorded_now_withunit_years Real)
(declare-const patient_disease_duration_value_recorded_now_withunit_months Real)

;; Other kept assertions
(assert (! (not (and (not patient_has_caucasian_origin) (not patient_has_caucasian_affinity))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_age_of_diagnosis_value_recorded_now_withunit_years 18)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_disease_duration_value_recorded_now_withunit_months 3)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
