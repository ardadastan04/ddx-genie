;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const alvarado_score_value_recorded_now_withunit_points Real)
(declare-const patient_has_diagnosis_of_acute_appendicitis_without_peritonitis_now Bool)

;; Other kept assertions
(assert (! (>= alvarado_score_value_recorded_now_withunit_points 7) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_acute_appendicitis_without_peritonitis_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
