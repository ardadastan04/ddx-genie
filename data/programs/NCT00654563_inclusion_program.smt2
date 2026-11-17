;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_capable_of_providing_informed_consent_now Bool)
(declare-const patient_is_capable_of_giving_competent_informed_consent_now Bool)
(declare-const patient_is_capable_of_providing_assent_now Bool)
(declare-const legal_representative_is_able_to_provide_informed_consent_now Bool)
(declare-const patient_mini_mental_state_examination_score_value_recorded_now_withunit_score Real)
(declare-const patient_is_not_capable_of_giving_competent_informed_consent_due_to_mmse_now Bool)
(declare-const patient_has_voiced_concern_about_own_memory Bool)
(declare-const patient_family_has_voiced_concern_about_patient_memory Bool)
(declare-const patient_family_has_knowledge_of_patient_memory_disorder_diagnosis Bool)
(declare-const patient_has_diagnosis_of_memory_impairment_inthehistory Bool)
(declare-const patient_has_diagnosis_of_age_associated_memory_impairment_inthehistory Bool)
(declare-const patient_has_diagnosis_of_alzheimer_s_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_huntington_s_chorea_inthehistory Bool)
(declare-const patient_has_diagnosis_of_vascular_dementia_inthehistory Bool)
(declare-const patient_has_diagnosis_of_mixed_dementia_inthehistory Bool)
(declare-const patient_has_diagnosis_of_dementia_due_to_lewy_body_disease_inthehistory Bool)
(declare-const patient_has_diagnosis_of_frontotemporal_dementia_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_not_capable_of_giving_competent_informed_consent_due_to_mmse_now (< patient_mini_mental_state_examination_score_value_recorded_now_withunit_score 24)) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_age_associated_memory_impairment_inthehistory patient_has_diagnosis_of_memory_impairment_inthehistory) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_alzheimer_s_disease_inthehistory patient_has_diagnosis_of_memory_impairment_inthehistory) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_inthehistory patient_has_diagnosis_of_memory_impairment_inthehistory) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_diagnosis_of_huntington_s_chorea_inthehistory patient_has_diagnosis_of_memory_impairment_inthehistory) :named REQ2_AUXILIARY3))
(assert (! (=> patient_has_diagnosis_of_vascular_dementia_inthehistory patient_has_diagnosis_of_memory_impairment_inthehistory) :named REQ2_AUXILIARY4))
(assert (! (=> patient_has_diagnosis_of_mixed_dementia_inthehistory patient_has_diagnosis_of_memory_impairment_inthehistory) :named REQ2_AUXILIARY5))
(assert (! (=> patient_has_diagnosis_of_dementia_due_to_lewy_body_disease_inthehistory patient_has_diagnosis_of_memory_impairment_inthehistory) :named REQ2_AUXILIARY6))
(assert (! (=> patient_has_diagnosis_of_frontotemporal_dementia_inthehistory patient_has_diagnosis_of_memory_impairment_inthehistory) :named REQ2_AUXILIARY7))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_is_capable_of_providing_informed_consent_now (and (not patient_is_capable_of_giving_competent_informed_consent_now) patient_is_not_capable_of_giving_competent_informed_consent_due_to_mmse_now legal_representative_is_able_to_provide_informed_consent_now) (and patient_is_capable_of_providing_assent_now (not patient_is_capable_of_giving_competent_informed_consent_now) legal_representative_is_able_to_provide_informed_consent_now)) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_voiced_concern_about_own_memory patient_family_has_voiced_concern_about_patient_memory patient_family_has_knowledge_of_patient_memory_disorder_diagnosis) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
