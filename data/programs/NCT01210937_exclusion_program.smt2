;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const carotid_artery_stenosis_is_minor Bool)
(declare-const patient_has_small_likelihood_of_worthwhile_benefit Bool)
(declare-const patient_needs_to_undergo_carotid_endarterectomy_now Bool)
(declare-const patient_needs_to_undergo_carotid_endarterectomy_now@@indicated_by_angiographic_evidence Bool)
(declare-const patient_needs_to_undergo_therapeutic_procedure_now Bool)
(declare-const patient_needs_to_undergo_therapeutic_procedure_now@@indicated_by_inclusion_criteria Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_needs_to_undergo_carotid_endarterectomy_now@@indicated_by_angiographic_evidence patient_needs_to_undergo_carotid_endarterectomy_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_needs_to_undergo_therapeutic_procedure_now@@indicated_by_inclusion_criteria patient_needs_to_undergo_therapeutic_procedure_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (not (or patient_has_small_likelihood_of_worthwhile_benefit (and patient_needs_to_undergo_therapeutic_procedure_now@@indicated_by_inclusion_criteria patient_needs_to_undergo_carotid_endarterectomy_now@@indicated_by_angiographic_evidence (not carotid_artery_stenosis_is_minor)))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
