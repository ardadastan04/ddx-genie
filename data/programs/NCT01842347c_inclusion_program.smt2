;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_months Real)
(declare-const patient_has_undergone_fecal_microbiota_transplantation_now Bool)
(declare-const patient_has_undergone_fecal_microbiota_transplantation_now@@decided_by_treating_gastroenterologist_for_the_patient Bool)
(declare-const patient_is_english_speaking Bool)
(declare-const patient_is_recipient Bool)
(declare-const patient_has_diagnosis_of_clostridioides_difficile_infection_now Bool)
(declare-const patient_has_diagnosis_of_clostridioides_difficile_infection_now@@moderate_severity Bool)
(declare-const patient_has_diagnosis_of_clostridioides_difficile_infection_now@@not_responding_to_vancomycin_for_at_least_one_week Bool)
(declare-const patient_is_exposed_to_vancomycin_inthepast1weeks Bool)
(declare-const patient_is_exposed_to_vancomycin_inthepast1weeks@@administered_for_at_least_one_week Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_fecal_microbiota_transplantation_now@@decided_by_treating_gastroenterologist_for_the_patient patient_has_undergone_fecal_microbiota_transplantation_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_clostridioides_difficile_infection_now@@moderate_severity patient_has_diagnosis_of_clostridioides_difficile_infection_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_clostridioides_difficile_infection_now@@not_responding_to_vancomycin_for_at_least_one_week patient_has_diagnosis_of_clostridioides_difficile_infection_now) :named REQ4_AUXILIARY1))
(assert (! (=> patient_is_exposed_to_vancomycin_inthepast1weeks@@administered_for_at_least_one_week patient_is_exposed_to_vancomycin_inthepast1weeks) :named REQ4_AUXILIARY2))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_months 18.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_fecal_microbiota_transplantation_now@@decided_by_treating_gastroenterologist_for_the_patient :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_english_speaking :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_recipient :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_diagnosis_of_clostridioides_difficile_infection_now@@moderate_severity patient_has_diagnosis_of_clostridioides_difficile_infection_now@@not_responding_to_vancomycin_for_at_least_one_week) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
