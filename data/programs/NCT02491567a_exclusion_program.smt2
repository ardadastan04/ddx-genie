;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_of_caucasian_origin Bool)
(declare-const patient_has_caucasian_affinity Bool)
(declare-const patient_age_at_autoimmune_thyroid_disease_diagnosis_in_years Real)
(declare-const patient_autoimmune_thyroid_disease_duration_in_months Real)

;; Other kept assertions
(assert (! (or patient_is_of_caucasian_origin patient_has_caucasian_affinity) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_is_of_caucasian_origin patient_has_caucasian_affinity) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (> patient_age_at_autoimmune_thyroid_disease_diagnosis_in_years 18)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_autoimmune_thyroid_disease_duration_in_months 3)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
