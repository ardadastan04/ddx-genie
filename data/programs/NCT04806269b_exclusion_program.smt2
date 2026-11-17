;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_disability_affecting_daily_living_now Bool)
(declare-const patient_has_finding_of_disability_affecting_daily_living_now@@caused_by_diseases_other_than_thyroid_dysfunction Bool)
(declare-const patient_is_taking_drug_or_medicament_now Bool)
(declare-const patient_is_taking_drug_or_medicament_now@@affecting_heart_rate Bool)
(declare-const patient_has_diagnosis_of_disease_now Bool)
(declare-const patient_has_diagnosis_of_disease_now@@affects_heart_rate Bool)
(declare-const patient_has_diagnosis_of_disease_now@@affects_heart_rate@@is_thyroid_dysfunction Bool)
(declare-const patient_has_diagnosis_of_disease_now@@is_arrhythmia Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_disability_affecting_daily_living_now@@caused_by_diseases_other_than_thyroid_dysfunction patient_has_finding_of_disability_affecting_daily_living_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_taking_drug_or_medicament_now@@affecting_heart_rate patient_is_taking_drug_or_medicament_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_disease_now@@is_arrhythmia patient_has_diagnosis_of_disease_now@@affects_heart_rate) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_disease_now@@affects_heart_rate patient_has_diagnosis_of_disease_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_disease_now@@affects_heart_rate@@is_thyroid_dysfunction patient_has_diagnosis_of_disease_now@@affects_heart_rate) :named REQ2_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_disease_now@@affects_heart_rate@@is_thyroid_dysfunction patient_has_diagnosis_of_disease_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_diagnosis_of_disease_now@@is_arrhythmia patient_has_diagnosis_of_disease_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_disability_affecting_daily_living_now@@caused_by_diseases_other_than_thyroid_dysfunction) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_drug_or_medicament_now@@affecting_heart_rate) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_diagnosis_of_disease_now@@affects_heart_rate (not patient_has_diagnosis_of_disease_now@@affects_heart_rate@@is_thyroid_dysfunction))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
