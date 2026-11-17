;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_heart_disease_now Bool)
(declare-const patient_has_diagnosis_of_heart_disease_now@@known Bool)
(declare-const patient_has_pre_existing_diabetes Bool)
(declare-const patient_has_pre_existing_chronic_renal_failure Bool)
(declare-const patient_has_pre_existing_malignancy Bool)
(declare-const patient_has_finding_of_chronic_pancreatitis_now Bool)
(declare-const patient_has_finding_of_chronic_pancreatitis_now@@underlying Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_heart_disease_now@@known patient_has_diagnosis_of_heart_disease_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_chronic_pancreatitis_now@@underlying patient_has_finding_of_chronic_pancreatitis_now) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_age_value_recorded_now_in_years 80)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_heart_disease_now@@known) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_pre_existing_diabetes) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_pre_existing_chronic_renal_failure) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_pre_existing_malignancy) :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_chronic_pancreatitis_now@@underlying) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
