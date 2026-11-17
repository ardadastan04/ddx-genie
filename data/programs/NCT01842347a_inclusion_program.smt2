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
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_recurrent_clostridium_difficile_infection_now Bool)
(declare-const patient_has_diagnosis_of_relapsing_clostridium_difficile_infection_now Bool)
(declare-const patient_has_undergone_metronidazole_therapy_now_outcome_is_negative Bool)
(declare-const patient_has_undergone_vancomycin_therapy_now_outcome_is_negative Bool)
(declare-const patient_has_undergone_fidaxomicin_therapy_now_outcome_is_negative Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_fecal_microbiota_transplantation_inthehistory@@decided_by_treating_gastroenterologist patient_has_undergone_fecal_microbiota_transplantation_inthehistory) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_months 18.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_fecal_microbiota_transplantation_inthehistory@@decided_by_treating_gastroenterologist :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_english_speaking :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_recipient :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_diagnosis_of_recurrent_clostridium_difficile_infection_now (and patient_has_diagnosis_of_relapsing_clostridium_difficile_infection_now patient_has_undergone_metronidazole_therapy_now_outcome_is_negative patient_has_undergone_vancomycin_therapy_now_outcome_is_negative (or (and (> patient_age_value_recorded_now_in_years 18) patient_has_undergone_fidaxomicin_therapy_now_outcome_is_negative) (<= patient_age_value_recorded_now_in_years 18)))) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
