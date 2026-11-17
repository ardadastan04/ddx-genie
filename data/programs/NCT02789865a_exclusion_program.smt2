;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_appendicitis_now Bool)
(declare-const patient_has_finding_of_appendicitis_now@@perforated Bool)
(declare-const patient_has_finding_of_abscess_of_appendix_now Bool)
(declare-const patient_has_contraindication_for_colonoscopy_now Bool)
(declare-const patient_has_finding_of_allergy_to_contrast_media_inthehistory Bool)
(declare-const patient_has_finding_of_allergy_to_iodine_inthehistory Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_unable_to_cooperate Bool)
(declare-const patient_is_unable_to_provide_informed_consent Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_appendicitis_now@@perforated patient_has_finding_of_appendicitis_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_appendicitis_now@@perforated) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_abscess_of_appendix_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_for_colonoscopy_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_allergy_to_contrast_media_inthehistory) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_allergy_to_iodine_inthehistory) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_cooperate) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_provide_informed_consent) :named REQ5_COMPONENT1_OTHER_REQUIREMENTS))
