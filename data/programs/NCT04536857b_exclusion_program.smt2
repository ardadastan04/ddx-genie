;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_secondary_parkinsonism_now Bool)
(declare-const patient_has_diagnosis_of_parkinsonism_caused_by_drug_now Bool)
(declare-const patient_has_diagnosis_of_atypical_parkinsonism_now Bool)
(declare-const patient_has_diagnosis_of_multiple_system_atrophy_now Bool)
(declare-const patient_has_diagnosis_of_multiple_system_atrophy_now@@meets_all_inclusion_criteria_for_probable_multiple_system_atrophy Bool)
(declare-const patient_has_diagnosis_of_progressive_supranuclear_palsy_now Bool)
(declare-const patient_has_at_least_one_red_flag_of_movement_disorder_society_pd_criteria_in_comprehensive_assessments_during_follow_up Bool)
(declare-const patient_has_diagnosis_of_malignant_neoplastic_disease_inthepast5years Bool)
(declare-const patient_has_condition_that_risks_lumbar_puncture_procedure_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_unable_to_comply_with_study_procedures Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_parkinsonism_caused_by_drug_now patient_has_diagnosis_of_secondary_parkinsonism_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_progressive_supranuclear_palsy_now patient_has_diagnosis_of_atypical_parkinsonism_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_multiple_system_atrophy_now@@meets_all_inclusion_criteria_for_probable_multiple_system_atrophy patient_has_diagnosis_of_multiple_system_atrophy_now) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_secondary_parkinsonism_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or (and patient_has_diagnosis_of_atypical_parkinsonism_now (not (and patient_has_diagnosis_of_multiple_system_atrophy_now patient_has_diagnosis_of_multiple_system_atrophy_now@@meets_all_inclusion_criteria_for_probable_multiple_system_atrophy))))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_at_least_one_red_flag_of_movement_disorder_society_pd_criteria_in_comprehensive_assessments_during_follow_up) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_malignant_neoplastic_disease_inthepast5years) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_condition_that_risks_lumbar_puncture_procedure_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_comply_with_study_procedures) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
