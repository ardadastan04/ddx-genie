;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_term_infant_now Bool)
(declare-const patient_has_finding_of_near_term_neonate_now Bool)
(declare-const patient_gestational_age_value_recorded_now_withunit_weeks Real)
(declare-const patient_birth_weight_value_recorded_now_withunit_grams Real)

;; Other kept assertions
(assert (! (or (and patient_has_finding_of_term_infant_now (>= patient_gestational_age_value_recorded_now_withunit_weeks 35.0) (>= patient_birth_weight_value_recorded_now_withunit_grams 2000.0)) (and patient_has_finding_of_near_term_neonate_now (>= patient_gestational_age_value_recorded_now_withunit_weeks 35.0) (>= patient_birth_weight_value_recorded_now_withunit_grams 2000.0))) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
