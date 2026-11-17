;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_diarrhea_value_recorded_inthepast24hours_withunit_per_day Real)
(declare-const investigator_judges_c_difficile_is_likely_causative_agent_of_patient_diarrhea_now Bool)
(declare-const patient_is_exposed_to_feces_now Bool)
(declare-const patient_is_exposed_to_feces_now@@positive_for_clostridioides_difficile_glutamate_dehydrogenase_and_toxin_a_or_toxin_b Bool)
(declare-const patient_stool_is_positive_for_clostridioides_difficile_glutamate_dehydrogenase_now Bool)
(declare-const patient_stool_is_positive_for_clostridioides_difficile_toxin_a_now Bool)
(declare-const patient_stool_is_positive_for_clostridioides_difficile_toxin_b_now Bool)
(declare-const patient_has_finding_of_clostridioides_difficile_infection_now Bool)
(declare-const patient_has_finding_of_clostridioides_difficile_infection_now@@primary_episode Bool)
(declare-const patient_has_finding_of_clostridioides_difficile_infection_now@@first_recurrence Bool)
(declare-const investigator_expects_patient_to_survive_for_anticipated_study_duration_with_effective_antibiotic_therapy_and_appropriate_supportive_care Bool)
(declare-const patient_is_receiving_supportive_care_now Bool)
(declare-const patient_is_receiving_supportive_care_now@@is_appropriate Bool)
(declare-const patient_is_undergoing_antibiotic_therapy_now Bool)
(declare-const patient_is_undergoing_antibiotic_therapy_now@@is_effective Bool)
(declare-const patient_has_finding_of_hospital_patient_now Bool)
(declare-const patient_is_inpatient_now Bool)
(declare-const patient_is_outpatient_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_feces_now@@positive_for_clostridioides_difficile_glutamate_dehydrogenase_and_toxin_a_or_toxin_b patient_is_exposed_to_feces_now) :named REQ1_AUXILIARY0))
(assert (! (= patient_is_exposed_to_feces_now@@positive_for_clostridioides_difficile_glutamate_dehydrogenase_and_toxin_a_or_toxin_b (and patient_is_exposed_to_feces_now patient_stool_is_positive_for_clostridioides_difficile_glutamate_dehydrogenase_now (or patient_stool_is_positive_for_clostridioides_difficile_toxin_a_now patient_stool_is_positive_for_clostridioides_difficile_toxin_b_now))) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_clostridioides_difficile_infection_now@@primary_episode patient_has_finding_of_clostridioides_difficile_infection_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_clostridioides_difficile_infection_now@@first_recurrence patient_has_finding_of_clostridioides_difficile_infection_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_is_receiving_supportive_care_now@@is_appropriate patient_is_receiving_supportive_care_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_is_undergoing_antibiotic_therapy_now@@is_effective patient_is_undergoing_antibiotic_therapy_now) :named REQ3_AUXILIARY1))
(assert (! (= patient_has_finding_of_hospital_patient_now (or patient_is_inpatient_now patient_is_outpatient_now)) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_diarrhea_value_recorded_inthepast24hours_withunit_per_day 3) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! investigator_judges_c_difficile_is_likely_causative_agent_of_patient_diarrhea_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_exposed_to_feces_now@@positive_for_clostridioides_difficile_glutamate_dehydrogenase_and_toxin_a_or_toxin_b :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_clostridioides_difficile_infection_now@@primary_episode patient_has_finding_of_clostridioides_difficile_infection_now@@first_recurrence) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! investigator_expects_patient_to_survive_for_anticipated_study_duration_with_effective_antibiotic_therapy_and_appropriate_supportive_care :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_hospital_patient_now :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
