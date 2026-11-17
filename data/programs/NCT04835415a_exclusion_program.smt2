;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_altered_mental_status_now Bool)
(declare-const patient_has_allergy_to_drug_or_medicament_inthehistory Bool)
(declare-const patient_has_allergy_to_drug_or_medicament_inthehistory@@drug_is_study_drug Bool)
(declare-const patient_has_finding_of_end_stage_liver_disease_now Bool)
(declare-const patient_has_finding_of_end_stage_renal_disease_now Bool)
(declare-const patient_has_finding_of_disorder_of_cardiovascular_system_now Bool)
(declare-const patient_has_finding_of_disorder_of_cardiovascular_system_now@@advanced Bool)
(declare-const patient_has_finding_of_disorder_of_respiratory_system_now Bool)
(declare-const patient_has_finding_of_disorder_of_respiratory_system_now@@advanced Bool)
(declare-const patient_has_finding_of_chronic_pain_now Bool)
(declare-const patient_is_exposed_to_anticoagulant_now Bool)
(declare-const patient_has_diagnosis_of_allergy_to_local_anesthetic_inthehistory Bool)
(declare-const patient_has_diagnosis_of_blood_coagulation_disorder_inthehistory Bool)
(declare-const patient_has_undergone_injection_now Bool)
(declare-const patient_has_undergone_injection_now@@septic_focus_at_site Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_allergy_to_drug_or_medicament_inthehistory@@drug_is_study_drug patient_has_allergy_to_drug_or_medicament_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disorder_of_cardiovascular_system_now@@advanced patient_has_finding_of_disorder_of_cardiovascular_system_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disorder_of_respiratory_system_now@@advanced patient_has_finding_of_disorder_of_respiratory_system_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_undergone_injection_now@@septic_focus_at_site patient_has_undergone_injection_now) :named REQ5_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_altered_mental_status_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_allergy_to_drug_or_medicament_inthehistory@@drug_is_study_drug) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_end_stage_liver_disease_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_end_stage_renal_disease_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_cardiovascular_system_now@@advanced) :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_respiratory_system_now@@advanced) :named REQ2_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_chronic_pain_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_anticoagulant_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or patient_has_diagnosis_of_allergy_to_local_anesthetic_inthehistory patient_has_diagnosis_of_blood_coagulation_disorder_inthehistory patient_has_undergone_injection_now@@septic_focus_at_site)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
