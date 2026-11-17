;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_acute_diarrhea_now Bool)
(declare-const patient_has_finding_of_acute_diarrhea_now@@symptom_onset_within_48_hours_before_study_entry Bool)
(declare-const patient_loose_stool_value_recorded_inthepast24hours_withunit_count Real)
(declare-const patient_loose_stool_value_recorded_inthepast24hours_withunit_count@@temporalcontext_24_hours_before_study_entry Bool)
(declare-const patient_is_exposed_to_feces_now Bool)
(declare-const patient_is_exposed_to_feces_now@@most_recent Bool)
(declare-const patient_is_exposed_to_feces_now@@unformed Bool)
(declare-const patient_has_finding_of_abdominal_discomfort_now Bool)
(declare-const patient_has_finding_of_abdominal_wind_pain_inthehistory@@temporalcontext_within4hours_before_study_entry Bool)
(declare-const patient_has_finding_of_abdominal_wind_pain_inthehistory@@intensity_mild_to_severe Bool)
(declare-const patient_has_finding_of_abdominal_wind_pain_with_mild_to_severe_intensity_within_4h_before_study_entry Bool)
(declare-const patient_has_childbearing_potential_now Bool)
(declare-const patient_has_negative_pregnancy_test_at_screening Bool)
(declare-const patient_is_willing_to_adhere_to_protocol_prohibitions_and_restrictions Bool)
(declare-const patient_is_willing_to_adhere_to_protocol_prohibitions Bool)
(declare-const patient_is_willing_to_adhere_to_protocol_restrictions Bool)
(declare-const patient_has_signed_informed_consent_document_for_study_participation Bool)
(declare-const patient_has_signed_informed_consent_document_for_study_participation@@document_indicates_understanding_and_willingness Bool)
(declare-const patient_has_finding_of_abdominal_wind_pain_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_acute_diarrhea_now@@symptom_onset_within_48_hours_before_study_entry patient_has_finding_of_acute_diarrhea_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_feces_now@@most_recent patient_is_exposed_to_feces_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_feces_now@@unformed patient_is_exposed_to_feces_now) :named REQ3_AUXILIARY1))
(assert (! (= patient_has_finding_of_abdominal_wind_pain_with_mild_to_severe_intensity_within_4h_before_study_entry (and patient_has_finding_of_abdominal_wind_pain_inthehistory@@temporalcontext_within4hours_before_study_entry patient_has_finding_of_abdominal_wind_pain_inthehistory@@intensity_mild_to_severe)) :named REQ4_AUXILIARY0))
(assert (! (= patient_is_willing_to_adhere_to_protocol_prohibitions_and_restrictions (and patient_is_willing_to_adhere_to_protocol_prohibitions patient_is_willing_to_adhere_to_protocol_restrictions)) :named REQ6_AUXILIARY0))
(assert (! (=> patient_has_signed_informed_consent_document_for_study_participation@@document_indicates_understanding_and_willingness patient_has_signed_informed_consent_document_for_study_participation) :named REQ7_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_abdominal_wind_pain_inthehistory@@intensity_mild_to_severe patient_has_finding_of_abdominal_wind_pain_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_abdominal_wind_pain_inthehistory@@temporalcontext_within4hours_before_study_entry patient_has_finding_of_abdominal_wind_pain_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (or patient_sex_is_male_now (and patient_sex_is_female_now (>= patient_age_value_recorded_now_in_years 18))) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_acute_diarrhea_now@@symptom_onset_within_48_hours_before_study_entry :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= patient_loose_stool_value_recorded_inthepast24hours_withunit_count 3) patient_loose_stool_value_recorded_inthepast24hours_withunit_count@@temporalcontext_24_hours_before_study_entry) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_is_exposed_to_feces_now@@most_recent patient_is_exposed_to_feces_now@@unformed) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_abdominal_discomfort_now patient_has_finding_of_abdominal_wind_pain_with_mild_to_severe_intensity_within_4h_before_study_entry) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (not (and patient_sex_is_female_now patient_has_childbearing_potential_now)) patient_has_negative_pregnancy_test_at_screening) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
