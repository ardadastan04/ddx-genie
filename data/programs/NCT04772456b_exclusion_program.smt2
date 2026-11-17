;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_can_undergo_magnetic_resonance_imaging_now Bool)
(declare-const patient_can_undergo_iodinated_contrast_media_now Bool)
(declare-const patient_has_finding_of_allergic_reaction_now Bool)
(declare-const patient_has_finding_of_allergic_reaction_now@@severe Bool)
(declare-const patient_has_finding_of_renal_insufficiency_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_allergic_reaction_now@@severe patient_has_finding_of_allergic_reaction_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_can_undergo_magnetic_resonance_imaging_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and (not patient_can_undergo_iodinated_contrast_media_now) patient_has_finding_of_allergic_reaction_now@@severe)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and (not patient_can_undergo_iodinated_contrast_media_now) patient_has_finding_of_renal_insufficiency_now)) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
