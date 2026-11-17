;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_disease_now Bool)
(declare-const patient_has_diagnosis_of_disease_now@@is_specified_neurodegenerative_disease Bool)
(declare-const patient_has_diagnosis_of_parkinsonism_now Bool)
(declare-const patient_has_diagnosis_of_parkinsonism_now@@meets_gelb_criteria Bool)
(declare-const patient_is_undergoing_clinical_trial_now Bool)
(declare-const patient_is_undergoing_clinical_trial_now@@is_therapeutic_trial Bool)
(declare-const patient_is_undergoing_clinical_trial_now@@is_another_trial Bool)
(declare-const patient_is_undergoing_clinical_trial_now@@in_exclusion_period Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_parkinsonism_now@@meets_gelb_criteria patient_has_diagnosis_of_parkinsonism_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_disease_now@@is_specified_neurodegenerative_disease patient_has_diagnosis_of_disease_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_is_undergoing_clinical_trial_now@@is_therapeutic_trial patient_is_undergoing_clinical_trial_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_undergoing_clinical_trial_now@@is_another_trial patient_is_undergoing_clinical_trial_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_is_undergoing_clinical_trial_now@@in_exclusion_period patient_is_undergoing_clinical_trial_now) :named REQ1_AUXILIARY2))

;; Other kept assertions
(assert (! (not (and patient_has_diagnosis_of_disease_now (not (or patient_has_diagnosis_of_parkinsonism_now@@meets_gelb_criteria patient_has_diagnosis_of_disease_now@@is_specified_neurodegenerative_disease)))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_undergoing_clinical_trial_now@@is_therapeutic_trial patient_is_undergoing_clinical_trial_now@@is_another_trial)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_clinical_trial_now@@in_exclusion_period) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
