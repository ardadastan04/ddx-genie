;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_mild_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_finding_of_moderate_chronic_obstructive_pulmonary_disease_now Bool)

;; Other kept assertions
(assert (! (or patient_has_finding_of_mild_chronic_obstructive_pulmonary_disease_now patient_has_finding_of_moderate_chronic_obstructive_pulmonary_disease_now) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
