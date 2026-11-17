;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=4 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_parkinsonism_now Bool)
(declare-const patient_has_finding_of_parkinsonism_now@@etiology_undetermined Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_disease_condition_finding_now@@can_reasonably_be_expected_to_subject_patient_to_unwarranted_risks Bool)
(declare-const patient_has_finding_of_seizure_disorder_inthehistory Bool)
(declare-const patient_has_finding_of_disease_of_liver_inthehistory Bool)
(declare-const patient_has_finding_of_kidney_disease_inthehistory Bool)
(declare-const patient_has_finding_of_myocardial_infarction_now@@currently_receiving_treatment Bool)
(declare-const patient_has_finding_of_cardiac_arrhythmia_now@@currently_receiving_treatment Bool)
(declare-const patient_has_finding_of_heart_failure_now@@currently_receiving_treatment Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_finding_of_myocardial_infarction_now Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now Bool)
(declare-const patient_has_finding_of_cardiac_arrhythmia_now Bool)
(declare-const patient_has_finding_of_heart_failure_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_parkinsonism_now@@etiology_undetermined patient_has_finding_of_parkinsonism_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_seizure_disorder_inthehistory patient_has_finding_of_disease_condition_finding_now@@can_reasonably_be_expected_to_subject_patient_to_unwarranted_risks) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disease_of_liver_inthehistory patient_has_finding_of_disease_condition_finding_now@@can_reasonably_be_expected_to_subject_patient_to_unwarranted_risks) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_finding_of_kidney_disease_inthehistory patient_has_finding_of_disease_condition_finding_now@@can_reasonably_be_expected_to_subject_patient_to_unwarranted_risks) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_finding_of_myocardial_infarction_now@@currently_receiving_treatment patient_has_finding_of_disease_condition_finding_now@@can_reasonably_be_expected_to_subject_patient_to_unwarranted_risks) :named REQ2_AUXILIARY3))
(assert (! (=> patient_has_finding_of_cardiac_arrhythmia_now@@currently_receiving_treatment patient_has_finding_of_disease_condition_finding_now@@can_reasonably_be_expected_to_subject_patient_to_unwarranted_risks) :named REQ2_AUXILIARY4))
(assert (! (=> patient_has_finding_of_heart_failure_now@@currently_receiving_treatment patient_has_finding_of_disease_condition_finding_now@@can_reasonably_be_expected_to_subject_patient_to_unwarranted_risks) :named REQ2_AUXILIARY5))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_cardiac_arrhythmia_now@@currently_receiving_treatment patient_has_finding_of_cardiac_arrhythmia_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_disease_condition_finding_now@@can_reasonably_be_expected_to_subject_patient_to_unwarranted_risks patient_has_finding_of_disease_condition_finding_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_heart_failure_now@@currently_receiving_treatment patient_has_finding_of_heart_failure_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_finding_of_myocardial_infarction_now@@currently_receiving_treatment patient_has_finding_of_myocardial_infarction_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))

;; Other kept assertions
(assert (! patient_has_finding_of_parkinsonism_now@@etiology_undetermined :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_sex_is_male_now (and patient_sex_is_female_now (>= patient_age_value_recorded_now_in_years 18.0) (<= patient_age_value_recorded_now_in_years 85.0))) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_has_finding_of_disease_condition_finding_now@@can_reasonably_be_expected_to_subject_patient_to_unwarranted_risks) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (not patient_sex_is_female_now) (not patient_is_pregnant_now)) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
