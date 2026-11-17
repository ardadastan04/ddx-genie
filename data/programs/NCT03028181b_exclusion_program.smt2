;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_healthy_control Bool)
(declare-const patient_has_diagnosis_of_disease_now Bool)
(declare-const patient_has_diagnosis_of_disease_now@@identified_during_research_by_primary_care_clinicians Bool)
(declare-const patient_has_finding_of_harmful_pattern_of_use_of_alcohol_now Bool)
(declare-const patient_has_finding_of_misuses_drugs_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_disease_now@@identified_during_research_by_primary_care_clinicians patient_has_diagnosis_of_disease_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not (and patient_is_healthy_control patient_has_diagnosis_of_disease_now@@identified_during_research_by_primary_care_clinicians)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_harmful_pattern_of_use_of_alcohol_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_misuses_drugs_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
