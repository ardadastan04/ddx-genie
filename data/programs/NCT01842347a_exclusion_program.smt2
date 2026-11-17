;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_informed_assent Bool)
(declare-const patient_has_informed_consent Bool)
(declare-const patient_can_undergo_fecal_microbiota_transplantation_now Bool)
(declare-const patient_can_undergo_fecal_microbiota_transplantation_now@@eligibility_determined_by_treating_gastroenterologist Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_can_undergo_fecal_microbiota_transplantation_now@@eligibility_determined_by_treating_gastroenterologist patient_can_undergo_fecal_microbiota_transplantation_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_informed_consent) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_informed_assent) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_can_undergo_fecal_microbiota_transplantation_now@@eligibility_determined_by_treating_gastroenterologist) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
