;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_malignant_neoplastic_disease_now Bool)
(declare-const patient_has_finding_of_malignant_neoplastic_disease_now@@is_another_tumor Bool)
(declare-const patient_has_finding_of_malignant_neoplastic_disease_now@@is_aggravating Bool)
(declare-const patient_prostate_specific_antigen_value_recorded_now_withunit_ng_per_ml Real)
(declare-const patient_free_total_prostate_specific_antigen_ratio_value_recorded_now_withunit_ratio Real)
(declare-const patient_maximum_intravesical_pressure_value_recorded_now_withunit_cmh2o Real)
(declare-const patient_has_diagnosis_of_urethral_stricture_now Bool)
(declare-const patient_has_finding_of_urinary_tract_infectious_disease_now Bool)
(declare-const patient_has_finding_of_disorder_of_nervous_system_now Bool)
(declare-const patient_has_surgical_contraindication_now Bool)
(declare-const patient_has_diagnosis_of_heart_disease_now Bool)
(declare-const patient_has_diagnosis_of_heart_disease_now@@severe Bool)
(declare-const patient_has_diagnosis_of_disorder_of_lung_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_lung_now@@severe Bool)
(declare-const patient_has_diagnosis_of_diaphragmatic_hernia_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_malignant_neoplastic_disease_now@@is_another_tumor patient_has_finding_of_malignant_neoplastic_disease_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_malignant_neoplastic_disease_now@@is_aggravating patient_has_finding_of_malignant_neoplastic_disease_now) :named REQ0_AUXILIARY1))
(assert (! (=> (or patient_has_diagnosis_of_heart_disease_now@@severe patient_has_diagnosis_of_disorder_of_lung_now@@severe patient_has_diagnosis_of_diaphragmatic_hernia_now) patient_has_surgical_contraindication_now) :named REQ6_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_heart_disease_now@@severe patient_has_diagnosis_of_heart_disease_now) :named REQ6_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_disorder_of_lung_now@@severe patient_has_diagnosis_of_disorder_of_lung_now) :named REQ6_AUXILIARY2))

;; Other kept assertions
(assert (! (not (and patient_has_finding_of_malignant_neoplastic_disease_now@@is_another_tumor patient_has_finding_of_malignant_neoplastic_disease_now@@is_aggravating)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_prostate_specific_antigen_value_recorded_now_withunit_ng_per_ml 20.0)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and (>= patient_prostate_specific_antigen_value_recorded_now_withunit_ng_per_ml 4.0) (<= patient_prostate_specific_antigen_value_recorded_now_withunit_ng_per_ml 20.0) (< patient_free_total_prostate_specific_antigen_ratio_value_recorded_now_withunit_ratio 0.16))) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (< patient_maximum_intravesical_pressure_value_recorded_now_withunit_cmh2o 15)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_urethral_stricture_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_urinary_tract_infectious_disease_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_nervous_system_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_surgical_contraindication_now) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
