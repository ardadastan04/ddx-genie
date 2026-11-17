;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_contraindication_for_starting_anti_hepatitis_c_virus_therapy Bool)
(declare-const patient_has_diagnosis_of_cirrhosis_of_liver_inthehistory Bool)
(declare-const patient_has_evidence_of_cirrhosis_of_liver Bool)
(declare-const patient_has_diagnosis_of_hepatic_failure_inthehistory Bool)
(declare-const patient_has_evidence_of_decompensated_liver_disease Bool)
(declare-const patient_has_evidence_of_disease_of_liver_now Bool)
(declare-const patient_has_evidence_of_disease_of_liver_now@@significant Bool)
(declare-const patient_has_evidence_of_viral_hepatitis_c_now Bool)
(declare-const patient_has_diagnosis_of_human_immunodeficiency_virus_infection_now Bool)
(declare-const patient_has_diagnosis_of_type_b_viral_hepatitis_now Bool)
(declare-const patient_is_woman Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_planning_to_be_pregnant Bool)
(declare-const patient_has_finding_of_breastfed_now Bool)
(declare-const patient_is_partner_of_woman Bool)
(declare-const partner_is_pregnant_now Bool)
(declare-const partner_is_breastfeeding_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_evidence_of_disease_of_liver_now@@significant patient_has_evidence_of_disease_of_liver_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_contraindication_for_starting_anti_hepatitis_c_virus_therapy) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_cirrhosis_of_liver_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_evidence_of_cirrhosis_of_liver) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_hepatic_failure_inthehistory) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_evidence_of_decompensated_liver_disease) :named REQ1_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_evidence_of_disease_of_liver_now@@significant patient_has_evidence_of_viral_hepatitis_c_now)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_human_immunodeficiency_virus_infection_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_type_b_viral_hepatitis_now) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_woman (or patient_is_pregnant_now patient_is_planning_to_be_pregnant patient_has_finding_of_breastfed_now))) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_partner_of_woman (or partner_is_pregnant_now partner_is_breastfeeding_now))) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
