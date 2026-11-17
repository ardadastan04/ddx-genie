;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_at_birth Bool)
(declare-const patient_has_diagnosis_of_advanced_prostate_cancer_inthehistory Bool)
(declare-const patient_has_diagnosis_of_metastatic_carcinoma_to_prostate_inthehistory Bool)
(declare-const patient_is_able_to_read_english Bool)
(declare-const patient_is_able_to_speak_english Bool)

;; Other kept assertions
(assert (! patient_sex_is_male_at_birth :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_diagnosis_of_advanced_prostate_cancer_inthehistory patient_has_diagnosis_of_metastatic_carcinoma_to_prostate_inthehistory) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_able_to_read_english :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_able_to_speak_english :named REQ2_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
