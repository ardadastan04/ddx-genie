;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_inpatient_now Bool)
(declare-const patient_has_finding_of_diarrhea_now Bool)
(declare-const patient_has_finding_of_clostridioides_difficile_infection_now Bool)
(declare-const patient_has_finding_of_clostridioides_difficile_infection_now@@non_severe_or_severe_uncomplicated Bool)
(declare-const patient_has_finding_of_clostridium_difficile_infection_now Bool)
(declare-const patient_has_finding_of_clostridium_difficile_infection_now@@non_severe_or_severe_uncomplicated Bool)
(declare-const patient_has_finding_of_clostridium_difficile_diarrhea_now Bool)
(declare-const patient_has_finding_of_clostridium_difficile_diarrhea_now@@non_severe_or_severe_uncomplicated Bool)
(declare-const patient_has_finding_of_clostridium_difficile_colitis_now Bool)
(declare-const patient_has_finding_of_clostridium_difficile_colitis_now@@non_severe_or_severe_uncomplicated Bool)
(declare-const patient_has_taken_vancomycin_containing_product_in_oral_dose_form_inthepast96hours Bool)
(declare-const patient_has_taken_vancomycin_containing_product_in_oral_dose_form_inthepast96hours@@administered_at_university_of_virginia Bool)
(declare-const patient_is_able_to_provide_informed_consent Bool)
(declare-const patient_is_able_to_provide_informed_consent_in_person Bool)
(declare-const patient_is_able_to_provide_informed_consent_electronically Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_clostridioides_difficile_infection_now@@non_severe_or_severe_uncomplicated patient_has_finding_of_clostridioides_difficile_infection_now) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_finding_of_clostridium_difficile_infection_now@@non_severe_or_severe_uncomplicated patient_has_finding_of_clostridium_difficile_infection_now) :named REQ5_AUXILIARY1))
(assert (! (=> patient_has_finding_of_clostridium_difficile_diarrhea_now@@non_severe_or_severe_uncomplicated patient_has_finding_of_clostridium_difficile_diarrhea_now) :named REQ5_AUXILIARY2))
(assert (! (=> patient_has_finding_of_clostridium_difficile_colitis_now@@non_severe_or_severe_uncomplicated patient_has_finding_of_clostridium_difficile_colitis_now) :named REQ5_AUXILIARY3))
(assert (! (=> patient_has_taken_vancomycin_containing_product_in_oral_dose_form_inthepast96hours@@administered_at_university_of_virginia patient_has_taken_vancomycin_containing_product_in_oral_dose_form_inthepast96hours) :named REQ6_AUXILIARY0))
(assert (! (= patient_is_able_to_provide_informed_consent (or patient_is_able_to_provide_informed_consent_in_person patient_is_able_to_provide_informed_consent_electronically)) :named REQ7_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_inpatient_now :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_diarrhea_now :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_clostridioides_difficile_infection_now@@non_severe_or_severe_uncomplicated patient_has_finding_of_clostridium_difficile_infection_now@@non_severe_or_severe_uncomplicated patient_has_finding_of_clostridium_difficile_diarrhea_now@@non_severe_or_severe_uncomplicated patient_has_finding_of_clostridium_difficile_colitis_now@@non_severe_or_severe_uncomplicated) :named REQ5_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_taken_vancomycin_containing_product_in_oral_dose_form_inthepast96hours@@administered_at_university_of_virginia :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
