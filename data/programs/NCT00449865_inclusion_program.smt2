;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_able_to_give_informed_consent_now Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now@@presents_with_asymmetric_features Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now@@time_since_diagnosis_leq_5_years Bool)
(declare-const patient_has_finding_of_bradykinesia_now Bool)
(declare-const patient_has_finding_of_muscle_rigidity_now Bool)
(declare-const patient_has_finding_of_resting_tremor_now Bool)
(declare-const time_since_diagnosis_of_parkinson_s_disease_value_recorded_now_in_years Real)
(declare-const patient_has_been_treated_with_dopaminergic_therapy_inthehistory Bool)
(declare-const patient_dopaminergic_therapy_value_recorded_inthehistory_withunit_days Real)
(declare-const patient_is_responsive_to_dopaminergic_therapy_inthehistory Bool)
(declare-const patient_dopamine_receptor_agonist_value_recorded_inthehistory_withunit_days Real)
(declare-const patient_levodopa_value_recorded_inthehistory_withunit_days Real)
(declare-const patient_is_exposed_to_dopamine_receptor_agonist_inthehistory Bool)
(declare-const patient_is_exposed_to_levodopa_inthehistory Bool)
(declare-const patient_is_responsive_to_dopamine_receptor_agonist_inthehistory Bool)
(declare-const patient_is_responsive_to_levodopa_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_bradykinesia_now patient_has_finding_of_resting_tremor_now patient_has_finding_of_muscle_rigidity_now) patient_has_diagnosis_of_parkinson_s_disease_now@@presents_with_asymmetric_features) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_now@@presents_with_asymmetric_features patient_has_diagnosis_of_parkinson_s_disease_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_now@@time_since_diagnosis_leq_5_years patient_has_diagnosis_of_parkinson_s_disease_now) :named REQ1_AUXILIARY2))
(assert (! (= patient_has_diagnosis_of_parkinson_s_disease_now@@time_since_diagnosis_leq_5_years (<= time_since_diagnosis_of_parkinson_s_disease_value_recorded_now_in_years 5.0)) :named REQ1_AUXILIARY3))
(assert (! (= patient_has_been_treated_with_dopaminergic_therapy_inthehistory (or patient_is_exposed_to_dopamine_receptor_agonist_inthehistory patient_is_exposed_to_levodopa_inthehistory)) :named REQ2_AUXILIARY0))
(assert (! (= patient_dopaminergic_therapy_value_recorded_inthehistory_withunit_days (+ patient_dopamine_receptor_agonist_value_recorded_inthehistory_withunit_days patient_levodopa_value_recorded_inthehistory_withunit_days)) :named REQ2_AUXILIARY1))
(assert (! (= patient_is_responsive_to_dopaminergic_therapy_inthehistory (or patient_is_responsive_to_dopamine_receptor_agonist_inthehistory patient_is_responsive_to_levodopa_inthehistory)) :named REQ2_AUXILIARY2))

;; Other kept assertions
(assert (! patient_is_able_to_give_informed_consent_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now@@presents_with_asymmetric_features :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now@@time_since_diagnosis_leq_5_years :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_been_treated_with_dopaminergic_therapy_inthehistory (>= patient_dopaminergic_therapy_value_recorded_inthehistory_withunit_days 90.0) (<= patient_dopaminergic_therapy_value_recorded_inthehistory_withunit_days 730.0)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_responsive_to_dopaminergic_therapy_inthehistory :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
