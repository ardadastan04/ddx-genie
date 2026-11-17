;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_chronic_degenerative_disorder_inthehistory Bool)
(declare-const patient_has_finding_of_chronic_degenerative_disorder_inthehistory@@excluding_myasthenia_gravis Bool)
(declare-const patient_has_finding_of_chronic_degenerative_disorder_inthehistory@@can_produce_weakness_or_fatigue Bool)
(declare-const patient_has_finding_of_mental_disorder_inthehistory Bool)
(declare-const patient_has_finding_of_mental_disorder_inthehistory@@excluding_myasthenia_gravis Bool)
(declare-const patient_has_finding_of_disorder_of_nervous_system_inthehistory Bool)
(declare-const patient_has_finding_of_disorder_of_nervous_system_inthehistory@@excluding_myasthenia_gravis Bool)
(declare-const patient_has_finding_of_asthenia_inthehistory Bool)
(declare-const patient_has_finding_of_fatigue_inthehistory Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_severe_anxiety_now Bool)
(declare-const patient_has_finding_of_severe_depression_now Bool)
(declare-const patient_has_finding_of_severe_schizophrenia_now Bool)
(declare-const patient_has_finding_of_impaired_cognition_now Bool)
(declare-const patient_assessment_using_mini_mental_state_examination_value_recorded_now_withunit_score Real)
(declare-const life_expectancy_value_in_years Real)
(declare-const patient_has_finding_of_severe_systemic_illness_now Bool)
(declare-const patient_has_finding_of_severe_systemic_illness_now@@associated_with_life_expectancy_less_than_4_years Bool)
(declare-const patient_is_unwilling_to_consent_to_collection_of_biological_samples Bool)
(declare-const patient_is_able_to_provide_informed_consent_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_chronic_degenerative_disorder_inthehistory@@excluding_myasthenia_gravis patient_has_finding_of_chronic_degenerative_disorder_inthehistory) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_chronic_degenerative_disorder_inthehistory@@can_produce_weakness_or_fatigue patient_has_finding_of_chronic_degenerative_disorder_inthehistory) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_mental_disorder_inthehistory@@excluding_myasthenia_gravis patient_has_finding_of_mental_disorder_inthehistory) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_finding_of_disorder_of_nervous_system_inthehistory@@excluding_myasthenia_gravis patient_has_finding_of_disorder_of_nervous_system_inthehistory) :named REQ0_AUXILIARY3))
(assert (! (=> patient_has_finding_of_severe_systemic_illness_now@@associated_with_life_expectancy_less_than_4_years patient_has_finding_of_severe_systemic_illness_now) :named REQ4_AUXILIARY0))
(assert (! (= patient_has_finding_of_severe_systemic_illness_now@@associated_with_life_expectancy_less_than_4_years (and patient_has_finding_of_severe_systemic_illness_now (< life_expectancy_value_in_years 4))) :named REQ4_AUXILIARY1))

;; Other kept assertions
(assert (! (not (and patient_has_finding_of_chronic_degenerative_disorder_inthehistory@@excluding_myasthenia_gravis patient_has_finding_of_chronic_degenerative_disorder_inthehistory@@can_produce_weakness_or_fatigue)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_mental_disorder_inthehistory@@excluding_myasthenia_gravis (or patient_has_finding_of_asthenia_inthehistory patient_has_finding_of_fatigue_inthehistory))) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_disorder_of_nervous_system_inthehistory@@excluding_myasthenia_gravis (or patient_has_finding_of_asthenia_inthehistory patient_has_finding_of_fatigue_inthehistory))) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not (<= patient_age_value_recorded_now_in_years 14)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_severe_anxiety_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_severe_depression_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_severe_schizophrenia_now) :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_impaired_cognition_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (<= patient_assessment_using_mini_mental_state_examination_value_recorded_now_withunit_score 24)) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_severe_systemic_illness_now@@associated_with_life_expectancy_less_than_4_years) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unwilling_to_consent_to_collection_of_biological_samples) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_able_to_provide_informed_consent_now) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
