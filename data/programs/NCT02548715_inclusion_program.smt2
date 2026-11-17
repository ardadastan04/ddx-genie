;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_malignant_tumor_of_head_and_neck_now Bool)
(declare-const patient_has_diagnosis_of_malignant_tumor_of_head_and_neck_now@@defined_by_american_joint_committee_on_cancer_staging_system Bool)
(declare-const patient_has_diagnosis_of_malignant_tumor_of_head_and_neck_now@@biopsy_proven Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory@@performed_in_edmonton_alberta Bool)
(declare-const patient_has_undergone_head_and_neck_surgical_procedure_inthehistory Bool)
(declare-const patient_has_undergone_head_and_neck_surgical_procedure_inthehistory@@performed_in_edmonton_alberta Bool)
(declare-const patient_has_been_treated_with_curative_intent_ever Bool)
(declare-const patient_has_been_treated_with_curative_intent_ever@@for_head_and_neck_cancer Bool)
(declare-const patient_has_diagnosis_of_subclinical_hypothyroidism_now@@after_head_and_neck_surgery Bool)
(declare-const patient_thyrotrophin_value_recorded_now_withunit_miu_per_l Real)
(declare-const patient_free_thyroxine_value_recorded_now_withunit_pmol_per_l Real)
(declare-const patient_has_diagnosis_of_subclinical_hypothyroidism_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_malignant_tumor_of_head_and_neck_now@@defined_by_american_joint_committee_on_cancer_staging_system patient_has_diagnosis_of_malignant_tumor_of_head_and_neck_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_malignant_tumor_of_head_and_neck_now@@biopsy_proven patient_has_diagnosis_of_malignant_tumor_of_head_and_neck_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_surgical_procedure_inthehistory@@performed_in_edmonton_alberta patient_has_undergone_surgical_procedure_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_undergone_head_and_neck_surgical_procedure_inthehistory@@performed_in_edmonton_alberta patient_has_undergone_head_and_neck_surgical_procedure_inthehistory) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_undergone_head_and_neck_surgical_procedure_inthehistory patient_has_undergone_surgical_procedure_inthehistory) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_been_treated_with_curative_intent_ever@@for_head_and_neck_cancer patient_has_been_treated_with_curative_intent_ever) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_subclinical_hypothyroidism_now@@after_head_and_neck_surgery patient_has_undergone_head_and_neck_surgical_procedure_inthehistory) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_subclinical_hypothyroidism_now@@after_head_and_neck_surgery patient_has_diagnosis_of_subclinical_hypothyroidism_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (and patient_has_diagnosis_of_malignant_tumor_of_head_and_neck_now@@biopsy_proven patient_has_diagnosis_of_malignant_tumor_of_head_and_neck_now@@defined_by_american_joint_committee_on_cancer_staging_system) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_head_and_neck_surgical_procedure_inthehistory@@performed_in_edmonton_alberta :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_been_treated_with_curative_intent_ever@@for_head_and_neck_cancer :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_diagnosis_of_subclinical_hypothyroidism_now@@after_head_and_neck_surgery (>= patient_thyrotrophin_value_recorded_now_withunit_miu_per_l 4.0) (<= patient_thyrotrophin_value_recorded_now_withunit_miu_per_l 10.0) (>= patient_free_thyroxine_value_recorded_now_withunit_pmol_per_l 10.0) (<= patient_free_thyroxine_value_recorded_now_withunit_pmol_per_l 24.0)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
