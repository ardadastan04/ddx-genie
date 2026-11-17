;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_needs_to_undergo_surgical_procedure_now Bool)
(declare-const patient_needs_to_undergo_surgical_procedure_now@@immediate Bool)
(declare-const patient_needs_to_undergo_surgical_procedure_now@@indicated_by_clinical_criteria Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_contraindication_to_magnetic_resonance_imaging_scan Bool)
(declare-const patient_is_judged_not_suitable_to_participate_in_study_for_other_reasons Bool)
(declare-const patient_has_diagnosis_of_personality_disorder_now Bool)
(declare-const patient_has_diagnosis_of_harmful_pattern_of_use_of_alcohol_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_needs_to_undergo_surgical_procedure_now@@immediate patient_needs_to_undergo_surgical_procedure_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_needs_to_undergo_surgical_procedure_now@@indicated_by_clinical_criteria patient_needs_to_undergo_surgical_procedure_now) :named REQ0_AUXILIARY1))
(assert (! (=> (or patient_has_diagnosis_of_personality_disorder_now patient_has_diagnosis_of_harmful_pattern_of_use_of_alcohol_now) patient_is_judged_not_suitable_to_participate_in_study_for_other_reasons) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! (not (and patient_needs_to_undergo_surgical_procedure_now@@immediate patient_needs_to_undergo_surgical_procedure_now@@indicated_by_clinical_criteria)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_magnetic_resonance_imaging_scan) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_judged_not_suitable_to_participate_in_study_for_other_reasons) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
