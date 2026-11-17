;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_dyspnea_on_exertion_now Bool)
(declare-const patient_has_finding_of_disability_affecting_daily_living_now Bool)
(declare-const patient_has_finding_of_chronic_obstructive_pulmonary_disease_now Bool)

;; Other kept assertions
(assert (! patient_has_finding_of_dyspnea_on_exertion_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_disability_affecting_daily_living_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_chronic_obstructive_pulmonary_disease_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
