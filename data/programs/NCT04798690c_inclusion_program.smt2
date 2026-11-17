;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_short_stature_now Bool)
(declare-const patient_has_finding_of_short_stature_now@@caused_by_turner_syndrome Bool)
(declare-const patient_has_undergone_measuring_height_of_patient_inthepast6months Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_short_stature_now@@caused_by_turner_syndrome patient_has_finding_of_short_stature_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_finding_of_short_stature_now@@caused_by_turner_syndrome :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_measuring_height_of_patient_inthepast6months :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
