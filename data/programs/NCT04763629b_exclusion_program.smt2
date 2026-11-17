;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_secondary_hypertension_now Bool)
(declare-const patient_has_diagnosis_of_heart_valve_disorder_now Bool)
(declare-const patient_has_diagnosis_of_heart_valve_disorder_now@@is_significant Bool)
(declare-const patient_has_finding_of_hypertrophic_cardiomyopathy_now Bool)
(declare-const patient_has_clinical_signs_of_myocardial_ischemia_now Bool)
(declare-const patient_has_clinical_signs_of_myocardial_ischemia_now@@during_ergometric_test Bool)
(declare-const patient_has_symptoms_of_myocardial_ischemia_now Bool)
(declare-const patient_has_symptoms_of_myocardial_ischemia_now@@during_ergometric_test Bool)
(declare-const patient_has_diagnosis_of_cardiac_arrhythmia_now Bool)
(declare-const patient_has_diagnosis_of_cardiac_arrhythmia_now@@uncontrolled Bool)
(declare-const patient_has_diagnosis_of_disorder_of_nervous_system_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_nervous_system_now@@contraindicates_or_limits_exercises Bool)
(declare-const patient_has_diagnosis_of_disorder_of_musculoskeletal_system_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_musculoskeletal_system_now@@contraindicates_or_limits_exercises Bool)
(declare-const patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent Real)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@significant Bool)
(declare-const patient_has_finding_of_peripheral_arterial_disease_now Bool)
(declare-const patient_has_finding_of_peripheral_arterial_disease_now@@symptomatic Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_heart_valve_disorder_now@@is_significant patient_has_diagnosis_of_heart_valve_disorder_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_clinical_signs_of_myocardial_ischemia_now@@during_ergometric_test patient_has_clinical_signs_of_myocardial_ischemia_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_symptoms_of_myocardial_ischemia_now@@during_ergometric_test patient_has_symptoms_of_myocardial_ischemia_now) :named REQ3_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_cardiac_arrhythmia_now@@uncontrolled patient_has_diagnosis_of_cardiac_arrhythmia_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_disorder_of_nervous_system_now@@contraindicates_or_limits_exercises patient_has_diagnosis_of_disorder_of_nervous_system_now) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_disorder_of_musculoskeletal_system_now@@contraindicates_or_limits_exercises patient_has_diagnosis_of_disorder_of_musculoskeletal_system_now) :named REQ5_AUXILIARY1))
(assert (! (= patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@significant (and patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now (< patient_forced_expired_volume_in_1_second_value_recorded_now_withunit_percent 50))) :named REQ6_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@significant patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now) :named REQ6_AUXILIARY1))
(assert (! (=> patient_has_finding_of_peripheral_arterial_disease_now@@symptomatic patient_has_finding_of_peripheral_arterial_disease_now) :named REQ7_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_secondary_hypertension_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_heart_valve_disorder_now@@is_significant) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hypertrophic_cardiomyopathy_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_clinical_signs_of_myocardial_ischemia_now@@during_ergometric_test) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_symptoms_of_myocardial_ischemia_now@@during_ergometric_test) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_cardiac_arrhythmia_now@@uncontrolled) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disorder_of_nervous_system_now@@contraindicates_or_limits_exercises) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disorder_of_musculoskeletal_system_now@@contraindicates_or_limits_exercises) :named REQ5_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@significant) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_peripheral_arterial_disease_now@@symptomatic) :named REQ7_COMPONENT0_OTHER_REQUIREMENTS))
