;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_undergone_clostridium_difficile_assay_inthepast10days_outcome_is_negative@@temporalcontext_within10days_before_procedure Bool)
(declare-const patient_has_undergone_laboratory_test_inthepast10days_outcome_is_positive@@temporalcontext_within10days_before_procedure Bool)
(declare-const patient_has_symptoms_of_clostridioides_difficile_infection_now Bool)
(declare-const number_of_courses_of_appropriate_antibiotic_therapy_for_clostridioides_difficile_infection_value_recorded_inthehistory_withunit_count Real)
(declare-const patient_has_diagnosis_of_clostridioides_difficile_infection_inthehistory Bool)
(declare-const patient_has_undergone_clostridium_difficile_assay_inthepast10days_outcome_is_negative Bool)
(declare-const patient_has_undergone_laboratory_test_inthepast10days_outcome_is_positive Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_clostridium_difficile_assay_inthepast10days_outcome_is_negative@@temporalcontext_within10days_before_procedure patient_has_undergone_clostridium_difficile_assay_inthepast10days_outcome_is_negative) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_undergone_laboratory_test_inthepast10days_outcome_is_positive@@temporalcontext_within10days_before_procedure patient_has_undergone_laboratory_test_inthepast10days_outcome_is_positive) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_undergone_clostridium_difficile_assay_inthepast10days_outcome_is_negative@@temporalcontext_within10days_before_procedure (not patient_has_undergone_laboratory_test_inthepast10days_outcome_is_positive@@temporalcontext_within10days_before_procedure))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_has_symptoms_of_clostridioides_difficile_infection_now)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and (< number_of_courses_of_appropriate_antibiotic_therapy_for_clostridioides_difficile_infection_value_recorded_inthehistory_withunit_count 2) patient_has_diagnosis_of_clostridioides_difficile_infection_inthehistory)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
