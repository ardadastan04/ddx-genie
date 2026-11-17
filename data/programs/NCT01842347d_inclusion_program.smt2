;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_months Real)
(declare-const patient_has_undergone_fecal_microbiota_transplantation_inthehistory Bool)
(declare-const patient_has_undergone_fecal_microbiota_transplantation_inthehistory@@decided_by_treating_gastroenterologist Bool)
(declare-const patient_is_english_speaking Bool)
(declare-const patient_is_recipient Bool)
(declare-const patient_has_severe_clostridioides_difficile_infection_now Bool)
(declare-const patient_is_exposed_to_vancomycin_now Bool)
(declare-const patient_is_exposed_to_vancomycin_now@@no_response_after_4_hours Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_fecal_microbiota_transplantation_inthehistory@@decided_by_treating_gastroenterologist patient_has_undergone_fecal_microbiota_transplantation_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_vancomycin_now@@no_response_after_4_hours patient_is_exposed_to_vancomycin_now) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_months 18.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_english_speaking :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_recipient :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_severe_clostridioides_difficile_infection_now :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_exposed_to_vancomycin_now@@no_response_after_4_hours :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
