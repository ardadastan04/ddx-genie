;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_chronic_kidney_disease_stage_3_now Bool)
(declare-const patient_has_finding_of_chronic_kidney_disease_stage_4_now Bool)
(declare-const patient_has_finding_of_chronic_kidney_disease_stage_5_now Bool)
(declare-const patient_is_receiving_dialysis_now Bool)

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 20.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_chronic_kidney_disease_stage_3_now patient_has_finding_of_chronic_kidney_disease_stage_4_now patient_has_finding_of_chronic_kidney_disease_stage_5_now patient_is_receiving_dialysis_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
