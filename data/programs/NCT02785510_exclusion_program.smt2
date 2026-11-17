;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_by_united_kingdom_brain_bank_criteria Bool)
(declare-const patient_has_diagnosis_of_vascular_parkinsonism_inthehistory Bool)
(declare-const patient_has_finding_of_cerebrovascular_accident_inthehistory Bool)
(declare-const patient_has_diagnosis_of_parkinsonism_caused_by_drug_now Bool)
(declare-const patient_has_history_of_exposure_to_dopaminergic_neurotoxin Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_by_united_kingdom_brain_bank_criteria patient_has_diagnosis_of_parkinson_s_disease_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not (and patient_has_diagnosis_of_vascular_parkinsonism_inthehistory patient_has_finding_of_cerebrovascular_accident_inthehistory (not patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_by_united_kingdom_brain_bank_criteria))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_diagnosis_of_parkinsonism_caused_by_drug_now (not patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_by_united_kingdom_brain_bank_criteria))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_history_of_exposure_to_dopaminergic_neurotoxin (not patient_has_diagnosis_of_parkinson_s_disease_now@@diagnosed_by_united_kingdom_brain_bank_criteria))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
