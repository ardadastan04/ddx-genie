;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_viral_hepatitis_c_now Bool)
(declare-const patient_is_positive_for_hepatitis_c_virus_ribonucleic_acid_now Bool)
(declare-const patient_is_approved_for_hepatitis_c_virus_infection_treatment_now Bool)

;; Other kept assertions
(assert (! patient_has_diagnosis_of_viral_hepatitis_c_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_positive_for_hepatitis_c_virus_ribonucleic_acid_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_approved_for_hepatitis_c_virus_infection_treatment_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
