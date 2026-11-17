;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_hypersensitivity_to_active_substance_inthehistory Bool)
(declare-const patient_has_finding_of_adverse_reaction_to_pharmaceutical_excipient_inthehistory Bool)
(declare-const patient_has_finding_of_allergy_to_bisphosphonate_inthehistory Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_disease_of_liver_now Bool)
(declare-const patient_has_diagnosis_of_disease_of_liver_now@@severe Bool)
(declare-const patient_has_diagnosis_of_disorder_of_urinary_bladder_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_urinary_bladder_now@@severe Bool)
(declare-const patient_measurement_of_renal_clearance_of_creatinine_value_recorded_now_withunit_ml_per_min Real)
(declare-const patient_measurement_of_renal_clearance_of_creatinine_value_recorded_now_withunit_ml_per_min@@measured_at_baseline Bool)
(declare-const patient_has_finding_of_hypocalcemia_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_teeth_and_or_supporting_structures_inthehistory Bool)
(declare-const patient_will_undergo_dental_surgical_procedure_inthefuture Bool)
(declare-const patient_has_finding_of_vitamin_d_deficiency_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_disease_of_liver_now@@severe patient_has_diagnosis_of_disease_of_liver_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_disorder_of_urinary_bladder_now@@severe patient_has_diagnosis_of_disorder_of_urinary_bladder_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_hypersensitivity_to_active_substance_inthehistory) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_adverse_reaction_to_pharmaceutical_excipient_inthehistory) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_allergy_to_bisphosphonate_inthehistory) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_malignant_neoplastic_disease_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disease_of_liver_now@@severe) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disorder_of_urinary_bladder_now@@severe) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_measurement_of_renal_clearance_of_creatinine_value_recorded_now_withunit_ml_per_min@@measured_at_baseline (< patient_measurement_of_renal_clearance_of_creatinine_value_recorded_now_withunit_ml_per_min 35))) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hypocalcemia_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or patient_has_diagnosis_of_disorder_of_teeth_and_or_supporting_structures_inthehistory patient_will_undergo_dental_surgical_procedure_inthefuture)) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_vitamin_d_deficiency_now) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
