;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_febrile_urinary_tract_infection_now Bool)
(declare-const patient_has_finding_of_febrile_urinary_tract_infection_now@@suspected Bool)
(declare-const patient_has_finding_of_febrile_urinary_tract_infection_now@@confirmed Bool)
(declare-const patient_has_finding_of_flank_pain_now Bool)
(declare-const patient_has_finding_of_suprapubic_pain_now Bool)
(declare-const patient_has_finding_of_tenderness_of_kidney_now@@detected_on_physical_examination Bool)
(declare-const patient_has_finding_of_dysuria_now Bool)
(declare-const patient_has_finding_of_increased_frequency_of_urination_now Bool)
(declare-const patient_has_finding_of_urgent_desire_to_urinate_now Bool)
(declare-const patient_has_finding_of_urinary_symptoms_now Bool)
(declare-const patient_fulfills_signs_or_symptoms_criterion_now Bool)
(declare-const patient_fever_value_recorded_highest_at_home_withunit_celsius Real)
(declare-const patient_fever_value_recorded_highest_at_hospital_withunit_celsius Real)
(declare-const patient_fever_value_recorded_now_withunit_celsius Real)
(declare-const patient_has_fever_geq_38_now Bool)
(declare-const patient_has_undergone_urinalysis_now_outcome_is_positive Bool)
(declare-const patient_has_undergone_urinalysis_now_outcome_is_positive@@performed_as_urine_nitrite_test_or_urine_leukocyte_particle_count_test Bool)
(declare-const patient_has_undergone_urine_culture_inthehistory Bool)
(declare-const patient_has_undergone_urine_culture_inthehistory@@obtained_as_pretreatment_baseline Bool)
(declare-const patient_has_suspicion_of_infectious_disease_now Bool)
(declare-const patient_needs_to_undergo_intravenous_antibiotic_therapy_now Bool)
(declare-const patient_has_finding_of_tenderness_of_kidney_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_febrile_urinary_tract_infection_now@@suspected patient_has_finding_of_febrile_urinary_tract_infection_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_febrile_urinary_tract_infection_now@@confirmed patient_has_finding_of_febrile_urinary_tract_infection_now) :named REQ0_AUXILIARY1))
(assert (! (=> (or patient_has_finding_of_dysuria_now patient_has_finding_of_increased_frequency_of_urination_now patient_has_finding_of_urgent_desire_to_urinate_now) patient_has_finding_of_urinary_symptoms_now) :named REQ0_AUXILIARY2))
(assert (! (= patient_fulfills_signs_or_symptoms_criterion_now (or patient_has_finding_of_flank_pain_now patient_has_finding_of_suprapubic_pain_now patient_has_finding_of_tenderness_of_kidney_now@@detected_on_physical_examination patient_has_finding_of_urinary_symptoms_now)) :named REQ0_AUXILIARY3))
(assert (! (= patient_fever_value_recorded_now_withunit_celsius (ite (>= patient_fever_value_recorded_highest_at_home_withunit_celsius patient_fever_value_recorded_highest_at_hospital_withunit_celsius) patient_fever_value_recorded_highest_at_home_withunit_celsius patient_fever_value_recorded_highest_at_hospital_withunit_celsius)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_fever_geq_38_now (>= patient_fever_value_recorded_now_withunit_celsius 38.0)) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_undergone_urinalysis_now_outcome_is_positive@@performed_as_urine_nitrite_test_or_urine_leukocyte_particle_count_test patient_has_undergone_urinalysis_now_outcome_is_positive) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_undergone_urine_culture_inthehistory@@obtained_as_pretreatment_baseline patient_has_undergone_urine_culture_inthehistory) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_tenderness_of_kidney_now@@detected_on_physical_examination patient_has_finding_of_tenderness_of_kidney_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (or patient_sex_is_male_now patient_sex_is_female_now) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_febrile_urinary_tract_infection_now@@suspected patient_has_finding_of_febrile_urinary_tract_infection_now@@confirmed) :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_fulfills_signs_or_symptoms_criterion_now :named REQ0_COMPONENT3_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_fever_geq_38_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_undergone_urinalysis_now_outcome_is_positive patient_has_undergone_urinalysis_now_outcome_is_positive@@performed_as_urine_nitrite_test_or_urine_leukocyte_particle_count_test) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_suspicion_of_infectious_disease_now patient_needs_to_undergo_intravenous_antibiotic_therapy_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
