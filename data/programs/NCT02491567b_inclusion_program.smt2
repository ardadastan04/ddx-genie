;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_exposed_to_thyroid_stimulating_immunoglobulins_now Bool)
(declare-const patient_has_positive_titer_of_thyroid_stimulating_antibody_now Bool)
(declare-const patient_has_finding_of_decreased_thyroid_stimulating_hormone_level_now Bool)
(declare-const patient_has_finding_of_increased_free_thyroxine_level_now Bool)
(declare-const patient_has_finding_of_increased_free_triiodothyronine_level_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_positive_titer_of_thyroid_stimulating_antibody_now patient_is_exposed_to_thyroid_stimulating_immunoglobulins_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_positive_titer_of_thyroid_stimulating_antibody_now :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_finding_of_decreased_thyroid_stimulating_hormone_level_now (or patient_has_finding_of_increased_free_thyroxine_level_now patient_has_finding_of_increased_free_triiodothyronine_level_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
