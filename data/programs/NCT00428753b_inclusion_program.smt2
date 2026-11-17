;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_assented_to_participate_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_adult_now Bool)
(declare-const patient_has_diagnosis_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_now Bool)
(declare-const patient_has_diagnosis_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_now@@confirmed_by_positive_test Bool)
(declare-const patient_has_finding_of_fever_now Bool)
(declare-const patient_has_finding_of_respiratory_symptoms_now Bool)
(declare-const patient_has_tested_positive_for_influenza_a_virus_subtype_h5n1_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_now@@confirmed_by_positive_test patient_has_diagnosis_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_now@@confirmed_by_positive_test patient_has_tested_positive_for_influenza_a_virus_subtype_h5n1_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (or (not patient_is_adult_now) patient_has_assented_to_participate_now) :named REQ0_COMPONENT4_OTHER_REQUIREMENTS))
(assert (! (or patient_is_adult_now (> patient_age_value_recorded_now_in_years 1.0)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and (not patient_has_tested_positive_for_influenza_a_virus_subtype_h5n1_now) (and (not patient_has_finding_of_fever_now) (not patient_has_finding_of_respiratory_symptoms_now))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
