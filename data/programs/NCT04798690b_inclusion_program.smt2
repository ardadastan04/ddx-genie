;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_short_stature_now Bool)
(declare-const patient_has_finding_of_short_stature_now@@due_to_idiopathic_short_stature Bool)
(declare-const patient_body_height_value_recorded_inthepast6months_withunit_cm@@is_official_record Bool)
(declare-const patient_body_height_value_recorded_inthepast6months_withunit_cm Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_short_stature_now@@due_to_idiopathic_short_stature patient_has_finding_of_short_stature_now) :named REQ0_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_body_height_value_recorded_inthepast6months_withunit_cm@@is_official_record patient_body_height_value_recorded_inthepast6months_withunit_cm) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! patient_has_finding_of_short_stature_now@@due_to_idiopathic_short_stature :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_body_height_value_recorded_inthepast6months_withunit_cm@@is_official_record :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
