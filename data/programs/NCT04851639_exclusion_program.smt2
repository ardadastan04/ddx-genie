;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_at_birth Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplasm_of_prostate_inthehistory Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplasm_of_prostate_inthehistory@@advanced Bool)
(declare-const patient_has_diagnosis_of_metastatic_carcinoma_to_prostate_inthehistory Bool)
(declare-const patient_is_able_to_read_english_now Bool)
(declare-const patient_is_able_to_speak_english_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_malignant_neoplasm_of_prostate_inthehistory@@advanced patient_has_diagnosis_of_malignant_neoplasm_of_prostate_inthehistory) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_sex_is_male_at_birth) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and (not patient_has_diagnosis_of_malignant_neoplasm_of_prostate_inthehistory@@advanced) (not patient_has_diagnosis_of_metastatic_carcinoma_to_prostate_inthehistory))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or (not patient_is_able_to_read_english_now) (not patient_is_able_to_speak_english_now))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
