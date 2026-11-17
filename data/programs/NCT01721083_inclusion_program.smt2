;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_healthy_adult_now Bool)
(declare-const patient_has_finding_of_allergy_to_latex_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Other kept assertions
(assert (! patient_is_healthy_adult_now :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_allergy_to_latex_now) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
