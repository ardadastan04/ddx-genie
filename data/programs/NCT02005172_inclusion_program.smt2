;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=6 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_symptoms_of_palpitations_now Bool)
(declare-const patient_has_symptoms_of_palpitations_now@@suggestive_of_arrhythmias Bool)
(declare-const patient_has_symptoms_of_palpitations_now@@usually_occurs_less_frequently_than_once_a_day Bool)
(declare-const patient_has_symptoms_of_near_syncope_now Bool)
(declare-const patient_has_symptoms_of_near_syncope_now@@suggestive_of_arrhythmias Bool)
(declare-const patient_has_symptoms_of_near_syncope_now@@usually_occurs_less_frequently_than_once_a_day Bool)
(declare-const patient_has_undergone_electrocardiographic_procedure_inthehistory@@outcome_is_non_diagnostic Bool)
(declare-const patient_has_undergone_holter_extended_electrocardiographic_recording_inthehistory@@outcome_is_non_diagnostic Bool)
(declare-const patient_has_undergone_electrocardiographic_procedure_inthehistory Bool)
(declare-const patient_has_undergone_holter_extended_electrocardiographic_recording_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_symptoms_of_palpitations_now patient_has_symptoms_of_near_syncope_now) (or patient_has_symptoms_of_palpitations_now@@suggestive_of_arrhythmias patient_has_symptoms_of_near_syncope_now@@suggestive_of_arrhythmias)) :named REQ0_AUXILIARY0))
(assert (! (=> (or patient_has_symptoms_of_palpitations_now patient_has_symptoms_of_near_syncope_now) (or patient_has_symptoms_of_palpitations_now@@usually_occurs_less_frequently_than_once_a_day patient_has_symptoms_of_near_syncope_now@@usually_occurs_less_frequently_than_once_a_day)) :named REQ0_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_symptoms_of_near_syncope_now@@suggestive_of_arrhythmias patient_has_symptoms_of_near_syncope_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_symptoms_of_near_syncope_now@@usually_occurs_less_frequently_than_once_a_day patient_has_symptoms_of_near_syncope_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_symptoms_of_palpitations_now@@suggestive_of_arrhythmias patient_has_symptoms_of_palpitations_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_symptoms_of_palpitations_now@@usually_occurs_less_frequently_than_once_a_day patient_has_symptoms_of_palpitations_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_has_undergone_electrocardiographic_procedure_inthehistory@@outcome_is_non_diagnostic patient_has_undergone_electrocardiographic_procedure_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))
(assert (! (=> patient_has_undergone_holter_extended_electrocardiographic_recording_inthehistory@@outcome_is_non_diagnostic patient_has_undergone_holter_extended_electrocardiographic_recording_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_5))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and patient_has_symptoms_of_palpitations_now patient_has_symptoms_of_palpitations_now@@suggestive_of_arrhythmias patient_has_symptoms_of_palpitations_now@@usually_occurs_less_frequently_than_once_a_day) (and patient_has_symptoms_of_near_syncope_now patient_has_symptoms_of_near_syncope_now@@suggestive_of_arrhythmias patient_has_symptoms_of_near_syncope_now@@usually_occurs_less_frequently_than_once_a_day)) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_undergone_electrocardiographic_procedure_inthehistory@@outcome_is_non_diagnostic patient_has_undergone_holter_extended_electrocardiographic_recording_inthehistory@@outcome_is_non_diagnostic) :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
