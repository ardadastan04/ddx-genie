;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_short_stature_now Bool)
(declare-const patient_has_finding_of_short_stature_now@@due_to_growth_hormone_deficiency Bool)
(declare-const patient_body_height_value_recorded_inthepast6months_withunit_cm Real)
(declare-const patient_body_height_value_recorded_inthepast6months_withunit_cm@@is_official_record Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_short_stature_now@@due_to_growth_hormone_deficiency patient_has_finding_of_short_stature_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_finding_of_short_stature_now@@due_to_growth_hormone_deficiency :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_body_height_value_recorded_inthepast6months_withunit_cm@@is_official_record (not (= patient_body_height_value_recorded_inthepast6months_withunit_cm 0))) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
