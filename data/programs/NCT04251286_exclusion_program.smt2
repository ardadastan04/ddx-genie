;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_congenital_biliary_atresia_now Bool)
(declare-const patient_has_finding_of_genetic_disease_now Bool)
(declare-const patient_has_finding_of_genetic_disease_now@@serious Bool)
(declare-const patient_has_finding_of_metabolic_disease_now Bool)
(declare-const patient_has_finding_of_metabolic_disease_now@@serious Bool)
(declare-const patient_has_family_history_of_epilepsy Bool)
(declare-const patient_meets_other_exclusion_criteria_specified_in_protocol Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_genetic_disease_now@@serious patient_has_finding_of_genetic_disease_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_metabolic_disease_now@@serious patient_has_finding_of_metabolic_disease_now) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_congenital_biliary_atresia_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_genetic_disease_now@@serious) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_metabolic_disease_now@@serious) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_family_history_of_epilepsy) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_meets_other_exclusion_criteria_specified_in_protocol) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
