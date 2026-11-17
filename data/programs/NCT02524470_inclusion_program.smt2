;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_adult_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_has_finding_of_patient_in_hospital_now Bool)
(declare-const patient_has_finding_of_vital_signs_finding_now Bool)
(declare-const patient_has_finding_of_vital_signs_finding_now@@stable_by_clinical_caregivers Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_vital_signs_finding_now@@stable_by_clinical_caregivers patient_has_finding_of_vital_signs_finding_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (or (and patient_is_adult_now patient_sex_is_male_now patient_has_finding_of_patient_in_hospital_now patient_has_finding_of_vital_signs_finding_now@@stable_by_clinical_caregivers) (and patient_is_adult_now patient_sex_is_female_now patient_has_finding_of_patient_in_hospital_now patient_has_finding_of_vital_signs_finding_now@@stable_by_clinical_caregivers)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
