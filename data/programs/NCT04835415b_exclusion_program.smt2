;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_altered_mental_status_now Bool)
(declare-const patient_has_finding_of_allergy_to_drug_inthehistory Bool)
(declare-const patient_has_finding_of_end_stage_liver_disease_now Bool)
(declare-const patient_has_finding_of_end_stage_renal_disease_now Bool)
(declare-const patient_has_finding_of_disorder_of_cardiovascular_system_now Bool)
(declare-const patient_has_finding_of_disorder_of_cardiovascular_system_now@@advanced Bool)
(declare-const patient_has_finding_of_disorder_of_respiratory_system_now Bool)
(declare-const patient_has_finding_of_disorder_of_respiratory_system_now@@advanced Bool)
(declare-const patient_has_finding_of_chronic_pain_now Bool)
(declare-const patient_is_undergoing_anticoagulant_therapy_now Bool)
(declare-const patient_has_contraindication_to_regional_anesthesia Bool)
(declare-const patient_has_finding_of_allergy_to_local_anesthetic_inthehistory Bool)
(declare-const patient_has_finding_of_blood_coagulation_disorder_now Bool)
(declare-const patient_has_finding_of_septic_focus_now Bool)
(declare-const patient_has_finding_of_septic_focus_now@@at_site_of_injection Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_disorder_of_cardiovascular_system_now@@advanced patient_has_finding_of_disorder_of_cardiovascular_system_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disorder_of_respiratory_system_now@@advanced patient_has_finding_of_disorder_of_respiratory_system_now) :named REQ2_AUXILIARY1))
(assert (! (=> (or patient_has_finding_of_allergy_to_local_anesthetic_inthehistory patient_has_finding_of_blood_coagulation_disorder_now patient_has_finding_of_septic_focus_now@@at_site_of_injection) patient_has_contraindication_to_regional_anesthesia) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_finding_of_septic_focus_now@@at_site_of_injection patient_has_finding_of_septic_focus_now) :named REQ5_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_altered_mental_status_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_allergy_to_drug_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_end_stage_liver_disease_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_end_stage_renal_disease_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_cardiovascular_system_now@@advanced) :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_respiratory_system_now@@advanced) :named REQ2_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_chronic_pain_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_anticoagulant_therapy_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_regional_anesthesia) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
