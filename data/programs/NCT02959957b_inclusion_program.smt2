;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=4 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_febrile_urinary_tract_infection_now@@suspected Bool)
(declare-const patient_has_finding_of_febrile_urinary_tract_infection_now@@confirmed Bool)
(declare-const patient_has_finding_of_flank_pain_now Bool)
(declare-const patient_has_finding_of_suprapubic_pain_now Bool)
(declare-const patient_has_finding_of_tenderness_of_kidney_now@@detected_on_physical_examination Bool)
(declare-const patient_has_finding_of_dysuria_now Bool)
(declare-const patient_has_finding_of_increased_frequency_of_urination_now Bool)
(declare-const patient_has_finding_of_urgent_desire_to_urinate_now Bool)
(declare-const patient_has_urinary_symptoms_now Bool)
(declare-const patient_fever_value_recorded_now_withunit_degrees_celsius Real)
(declare-const patient_fever_value_recorded_now_withunit_degrees_celsius@@recorded_at_home_or_hospital Bool)
(declare-const patient_has_positive_urine_leukocyte_particle_count_test_now Bool)
(declare-const patient_has_positive_urine_nitrite_test_now Bool)
(declare-const patient_has_undergone_urinalysis_now Bool)
(declare-const patient_has_undergone_urinalysis_now@@performed_as_urine_nitrite_test_or_urine_leukocyte_particle_count_test Bool)
(declare-const patient_has_undergone_urine_culture_inthehistory Bool)
(declare-const patient_has_undergone_urine_culture_inthehistory@@pre_treatment_baseline Bool)
(declare-const patient_has_finding_of_infectious_disease_now Bool)
(declare-const patient_has_finding_of_infectious_disease_now@@presumed Bool)
(declare-const patient_needs_to_undergo_intravenous_antibiotic_therapy_now Bool)
(declare-const patient_has_finding_of_tenderness_of_kidney_now Bool)
(declare-const patient_has_finding_of_febrile_urinary_tract_infection_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_dysuria_now patient_has_finding_of_increased_frequency_of_urination_now patient_has_finding_of_urgent_desire_to_urinate_now) patient_has_urinary_symptoms_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_undergone_urinalysis_now@@performed_as_urine_nitrite_test_or_urine_leukocyte_particle_count_test (and patient_has_undergone_urinalysis_now (or patient_has_positive_urine_nitrite_test_now patient_has_positive_urine_leukocyte_particle_count_test_now))) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_undergone_urine_culture_inthehistory@@pre_treatment_baseline patient_has_undergone_urine_culture_inthehistory) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_infectious_disease_now@@presumed patient_has_finding_of_infectious_disease_now) :named REQ4_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_febrile_urinary_tract_infection_now@@confirmed patient_has_finding_of_febrile_urinary_tract_infection_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_febrile_urinary_tract_infection_now@@suspected patient_has_finding_of_febrile_urinary_tract_infection_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_tenderness_of_kidney_now@@detected_on_physical_examination patient_has_finding_of_tenderness_of_kidney_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_undergone_urinalysis_now@@performed_as_urine_nitrite_test_or_urine_leukocyte_particle_count_test patient_has_undergone_urinalysis_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))

;; Other kept assertions
(assert (! (and (or patient_sex_is_male_now patient_sex_is_female_now) (>= patient_age_value_recorded_now_in_years 18.0) (or patient_has_finding_of_febrile_urinary_tract_infection_now@@suspected patient_has_finding_of_febrile_urinary_tract_infection_now@@confirmed) (or patient_has_finding_of_flank_pain_now patient_has_finding_of_suprapubic_pain_now patient_has_finding_of_tenderness_of_kidney_now@@detected_on_physical_examination patient_has_urinary_symptoms_now)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= patient_fever_value_recorded_now_withunit_degrees_celsius 38.0) patient_fever_value_recorded_now_withunit_degrees_celsius@@recorded_at_home_or_hospital) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_positive_urine_nitrite_test_now patient_has_positive_urine_leukocyte_particle_count_test_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_finding_of_infectious_disease_now@@presumed patient_needs_to_undergo_intravenous_antibiotic_therapy_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
