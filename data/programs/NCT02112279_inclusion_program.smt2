;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_undergone_clostridium_difficile_assay_inthehistory_outcome_is_positive Bool)
(declare-const patient_has_undergone_clostridium_difficile_assay_inthehistory_outcome_is_positive@@temporalcontext_within10days_before_procedure Bool)
(declare-const patient_has_symptoms_of_clostridioides_difficile_infection_now Bool)
(declare-const number_of_courses_of_appropriate_antibiotic_therapy_for_clostridioides_difficile_infection_failed_in_the_history Real)
(declare-const patient_has_undergone_antibiotic_therapy_inthehistory@@failed_at_least_two_courses Bool)
(declare-const patient_has_undergone_antibiotic_therapy_inthehistory@@appropriate_for_clostridioides_difficile_infection Bool)
(declare-const patient_has_undergone_antibiotic_therapy_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_clostridium_difficile_assay_inthehistory_outcome_is_positive@@temporalcontext_within10days_before_procedure patient_has_undergone_clostridium_difficile_assay_inthehistory_outcome_is_positive) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_undergone_antibiotic_therapy_inthehistory@@failed_at_least_two_courses (>= number_of_courses_of_appropriate_antibiotic_therapy_for_clostridioides_difficile_infection_failed_in_the_history 2)) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_antibiotic_therapy_inthehistory@@appropriate_for_clostridioides_difficile_infection patient_has_undergone_antibiotic_therapy_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_undergone_antibiotic_therapy_inthehistory@@failed_at_least_two_courses patient_has_undergone_antibiotic_therapy_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_clostridium_difficile_assay_inthehistory_outcome_is_positive@@temporalcontext_within10days_before_procedure :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_symptoms_of_clostridioides_difficile_infection_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_undergone_antibiotic_therapy_inthehistory@@failed_at_least_two_courses patient_has_undergone_antibiotic_therapy_inthehistory@@appropriate_for_clostridioides_difficile_infection) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
