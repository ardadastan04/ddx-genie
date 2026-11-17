;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_disorder_of_respiratory_system_now Bool)
(declare-const patient_has_diagnosis_of_pulmonary_hypertension_now Bool)
(declare-const patient_has_diagnosis_of_pulmonary_hypertension_now@@group_3 Bool)
(declare-const patient_has_finding_of_psychopathic_personality_trait_now Bool)
(declare-const patient_has_finding_of_addiction_now Bool)
(declare-const patient_is_able_to_coordinate_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_breastfeeding_now Bool)
(declare-const patient_has_finding_of_breastfed_now Bool)
(declare-const patient_has_finding_of_limited_life_expectancy_now Bool)
(declare-const patient_has_contraindication_for_magnetic_resonance_imaging_now Bool)
(declare-const patient_has_contraindication_for_positron_emission_tomography_now Bool)
(declare-const months_since_most_recent_cerebrovascular_event_value_recorded_in_months Real)
(declare-const patient_has_history_of_cerebrovascular_event_in_past_3_months Bool)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now Bool)
(declare-const patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@unstable Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_pulmonary_hypertension_now@@group_3 patient_has_diagnosis_of_pulmonary_hypertension_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_is_breastfeeding_now patient_has_finding_of_breastfed_now) :named REQ2_AUXILIARY0))
(assert (! (= patient_has_history_of_cerebrovascular_event_in_past_3_months (< months_since_most_recent_cerebrovascular_event_value_recorded_in_months 3)) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@unstable patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now) :named REQ6_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_disorder_of_respiratory_system_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_diagnosis_of_pulmonary_hypertension_now (not patient_has_diagnosis_of_pulmonary_hypertension_now@@group_3))) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_psychopathic_personality_trait_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_addiction_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (not patient_is_able_to_coordinate_now)) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_breastfeeding_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_limited_life_expectancy_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_for_magnetic_resonance_imaging_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_for_positron_emission_tomography_now) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_history_of_cerebrovascular_event_in_past_3_months) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_chronic_obstructive_pulmonary_disease_now@@unstable) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
