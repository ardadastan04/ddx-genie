;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_can_undergo_magnetic_resonance_imaging_now Bool)
(declare-const patient_can_undergo_iodinated_contrast_media_now Bool)
(declare-const patient_can_undergo_iodinated_contrast_media_now@@inability_due_to_severe_reaction Bool)
(declare-const patient_can_undergo_iodinated_contrast_media_now@@inability_due_to_renal_insufficiency Bool)
(declare-const patient_has_finding_of_renal_insufficiency_now Bool)
(declare-const patient_has_hypersensitivity_to_iodinated_contrast_media_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_can_undergo_iodinated_contrast_media_now@@inability_due_to_severe_reaction (not patient_can_undergo_iodinated_contrast_media_now)) :named REQ1_AUXILIARY0))
(assert (! (=> patient_can_undergo_iodinated_contrast_media_now@@inability_due_to_renal_insufficiency (not patient_can_undergo_iodinated_contrast_media_now)) :named REQ1_AUXILIARY1))
(assert (! (=> patient_can_undergo_iodinated_contrast_media_now@@inability_due_to_severe_reaction patient_has_hypersensitivity_to_iodinated_contrast_media_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_can_undergo_iodinated_contrast_media_now@@inability_due_to_renal_insufficiency patient_has_finding_of_renal_insufficiency_now) :named REQ1_AUXILIARY3))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_can_undergo_iodinated_contrast_media_now@@inability_due_to_renal_insufficiency patient_can_undergo_iodinated_contrast_media_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_can_undergo_iodinated_contrast_media_now@@inability_due_to_severe_reaction patient_can_undergo_iodinated_contrast_media_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not patient_can_undergo_magnetic_resonance_imaging_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_can_undergo_iodinated_contrast_media_now@@inability_due_to_severe_reaction) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_can_undergo_iodinated_contrast_media_now@@inability_due_to_renal_insufficiency) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
