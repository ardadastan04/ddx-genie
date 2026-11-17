;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_finding_of_does_suckle_now Bool)
(declare-const patient_is_breastfeeding_now Bool)
(declare-const patient_has_finding_of_malignant_neoplastic_disease_late Bool)
(declare-const patient_is_near_death_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_breastfeeding_now patient_has_finding_of_does_suckle_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not (or patient_is_pregnant_now patient_has_finding_of_does_suckle_now)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_malignant_neoplastic_disease_late) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_near_death_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
