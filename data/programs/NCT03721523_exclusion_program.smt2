;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_lacking_capacity_now Bool)
(declare-const patient_has_finding_of_carotid_artery_occlusion_now Bool)
(declare-const patient_has_finding_of_allergy_to_contrast_media_now Bool)
(declare-const patient_has_finding_of_disability_severe_now Bool)
(declare-const patient_has_finding_of_disability_severe_now@@participation_would_cause_stress Bool)
(declare-const patient_has_finding_of_immobility_severe_now Bool)
(declare-const patient_has_finding_of_immobility_severe_now@@participation_would_cause_stress Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_disability_severe_now@@participation_would_cause_stress patient_has_finding_of_disability_severe_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_immobility_severe_now@@participation_would_cause_stress patient_has_finding_of_immobility_severe_now) :named REQ3_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_is_lacking_capacity_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_carotid_artery_occlusion_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_allergy_to_contrast_media_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or patient_has_finding_of_disability_severe_now@@participation_would_cause_stress patient_has_finding_of_immobility_severe_now@@participation_would_cause_stress)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
