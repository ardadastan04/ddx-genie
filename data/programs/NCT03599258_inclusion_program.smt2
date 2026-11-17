;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const gestational_age_at_birth_value_recorded_in_weeks Real)
(declare-const gestational_age_at_birth_value_recorded_in_days Real)
(declare-const patient_has_finding_of_hyperbilirubinemia_now Bool)
(declare-const patient_has_finding_of_hyperbilirubinemia_now@@significant Bool)
(declare-const patient_has_finding_of_hyperbilirubinemia_now@@requires_phototherapy Bool)
(declare-const patient_has_finding_of_hyperbilirubinemia_now@@determined_by_attending_neonatologist_utilizing_aap_management_bhutani_nomogram Bool)
(declare-const patient_is_neonate_now Bool)
(declare-const patient_was_born_at_term_now Bool)
(declare-const patient_is_undergoing_light_therapy_now@@applied_in_hospitalized_infant Bool)
(declare-const patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks Bool)
(declare-const patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks@@gestational_age_criterion Bool)
(declare-const patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks@@phototherapy_applied_in_hospitalized_infant Bool)
(declare-const patient_is_undergoing_light_therapy_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_hyperbilirubinemia_now@@significant patient_has_finding_of_hyperbilirubinemia_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_hyperbilirubinemia_now@@requires_phototherapy patient_has_finding_of_hyperbilirubinemia_now) :named REQ3_AUXILIARY1))
(assert (! (=> patient_has_finding_of_hyperbilirubinemia_now@@determined_by_attending_neonatologist_utilizing_aap_management_bhutani_nomogram patient_has_finding_of_hyperbilirubinemia_now) :named REQ3_AUXILIARY2))
(assert (! (= patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks@@gestational_age_criterion (>= gestational_age_at_birth_value_recorded_in_weeks 35.0)) :named REQ4_AUXILIARY0))
(assert (! (= patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks@@phototherapy_applied_in_hospitalized_infant patient_is_undergoing_light_therapy_now@@applied_in_hospitalized_infant) :named REQ4_AUXILIARY1))
(assert (! (= patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks (and patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks@@gestational_age_criterion patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks@@phototherapy_applied_in_hospitalized_infant)) :named REQ4_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_undergoing_light_therapy_now@@applied_in_hospitalized_infant patient_is_undergoing_light_therapy_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks@@gestational_age_criterion patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks@@phototherapy_applied_in_hospitalized_infant patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! (or (> gestational_age_at_birth_value_recorded_in_weeks 35) (and (= gestational_age_at_birth_value_recorded_in_weeks 35) (> gestational_age_at_birth_value_recorded_in_days 0))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_finding_of_hyperbilirubinemia_now@@significant patient_has_finding_of_hyperbilirubinemia_now@@requires_phototherapy patient_has_finding_of_hyperbilirubinemia_now@@determined_by_attending_neonatologist_utilizing_aap_management_bhutani_nomogram patient_is_neonate_now patient_was_born_at_term_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_meets_guidelines_for_phototherapy_in_hospitalized_infants_35_or_more_weeks :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
