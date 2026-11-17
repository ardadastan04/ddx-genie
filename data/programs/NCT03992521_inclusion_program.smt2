;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_malignant_neoplasm_of_breast_now Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplasm_of_breast_now@@diagnosed_histologically Bool)
(declare-const patient_is_exposed_to_primary_tumor_tissue_now Bool)
(declare-const patient_is_exposed_to_plasma_now Bool)
(declare-const patient_is_exposed_to_deoxyribonucleic_acid_now Bool)
(declare-const patient_has_plasma_dna_available_now Bool)
(declare-const patient_has_high_circulating_tumor_dna_content_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_malignant_neoplasm_of_breast_now@@diagnosed_histologically patient_has_diagnosis_of_malignant_neoplasm_of_breast_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_plasma_dna_available_now (and patient_is_exposed_to_plasma_now patient_is_exposed_to_deoxyribonucleic_acid_now)) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_malignant_neoplasm_of_breast_now@@diagnosed_histologically :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_exposed_to_primary_tumor_tissue_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_plasma_dna_available_now patient_has_high_circulating_tumor_dna_content_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
