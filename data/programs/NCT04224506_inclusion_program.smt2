;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_signed_informed_consent Bool)
(declare-const patient_has_signed_informed_consent@@demonstrates_understanding_of_study_procedures_and_purpose Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now Bool)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now@@diagnosed_by_physician Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_signed_informed_consent@@demonstrates_understanding_of_study_procedures_and_purpose patient_has_signed_informed_consent) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_myasthenia_gravis_now@@diagnosed_by_physician patient_has_diagnosis_of_myasthenia_gravis_now) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! (or patient_sex_is_male_now patient_sex_is_female_now) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_myasthenia_gravis_now@@diagnosed_by_physician :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
