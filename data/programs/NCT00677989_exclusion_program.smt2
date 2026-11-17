;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=4 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_acute_perforated_appendicitis_now Bool)
(declare-const patient_has_diagnosis_of_acute_perforated_appendicitis_now@@revealed_by_pathologic_investigation_after_initial_clinical_and_imaging_diagnosis Bool)
(declare-const patient_has_diagnosis_of_diverticulitis_now Bool)
(declare-const patient_has_diagnosis_of_diverticulitis_now@@diagnosed_during_surgery Bool)
(declare-const patient_has_finding_of_female_pelvic_inflammatory_disease_now@@found_during_laparoscopic_examination Bool)
(declare-const patient_has_finding_of_disorder_of_female_genital_system_now@@found_during_laparoscopic_examination Bool)
(declare-const patient_has_finding_of_female_pelvic_inflammatory_disease_inthehistory@@diagnosed_before_operation Bool)
(declare-const patient_has_finding_of_disorder_of_female_genital_system_inthehistory@@diagnosed_before_operation Bool)
(declare-const patient_declines_to_enroll_in_this_study Bool)
(declare-const patient_has_finding_of_disorder_of_female_genital_system_inthehistory Bool)
(declare-const patient_has_finding_of_disorder_of_female_genital_system_now Bool)
(declare-const patient_has_finding_of_female_pelvic_inflammatory_disease_now Bool)
(declare-const patient_has_finding_of_female_pelvic_inflammatory_disease_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_acute_perforated_appendicitis_now@@revealed_by_pathologic_investigation_after_initial_clinical_and_imaging_diagnosis patient_has_diagnosis_of_acute_perforated_appendicitis_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_diverticulitis_now@@diagnosed_during_surgery patient_has_diagnosis_of_diverticulitis_now) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_disorder_of_female_genital_system_inthehistory@@diagnosed_before_operation patient_has_finding_of_disorder_of_female_genital_system_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_disorder_of_female_genital_system_now@@found_during_laparoscopic_examination patient_has_finding_of_disorder_of_female_genital_system_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_female_pelvic_inflammatory_disease_inthehistory@@diagnosed_before_operation patient_has_finding_of_female_pelvic_inflammatory_disease_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_finding_of_female_pelvic_inflammatory_disease_now@@found_during_laparoscopic_examination patient_has_finding_of_female_pelvic_inflammatory_disease_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 12)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_age_value_recorded_now_in_years 80)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_has_diagnosis_of_acute_perforated_appendicitis_now@@revealed_by_pathologic_investigation_after_initial_clinical_and_imaging_diagnosis)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_diverticulitis_now@@diagnosed_during_surgery) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_female_pelvic_inflammatory_disease_now@@found_during_laparoscopic_examination) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_female_genital_system_now@@found_during_laparoscopic_examination) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_female_pelvic_inflammatory_disease_inthehistory@@diagnosed_before_operation) :named REQ4_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disorder_of_female_genital_system_inthehistory@@diagnosed_before_operation) :named REQ4_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_declines_to_enroll_in_this_study) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
