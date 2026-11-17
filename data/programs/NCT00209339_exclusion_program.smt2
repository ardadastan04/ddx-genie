;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_cardiac_ejection_fraction_value_recorded_now_withunit_percent Real)
(declare-const patient_has_finding_of_endocarditis_now Bool)
(declare-const patient_has_finding_of_rheumatic_heart_disease_now Bool)
(declare-const patient_has_finding_of_renal_insufficiency_now Bool)

;; Other kept assertions
(assert (! (not (< patient_cardiac_ejection_fraction_value_recorded_now_withunit_percent 30)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_endocarditis_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_rheumatic_heart_disease_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_renal_insufficiency_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
