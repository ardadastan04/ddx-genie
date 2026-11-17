;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_hyperbilirubinemia_now Bool)
(declare-const patient_has_finding_of_hyperbilirubinemia_now@@low_risk Bool)
(declare-const patient_has_finding_of_hyperbilirubinemia_now@@requires_phototherapy Bool)
(declare-const patient_gestational_age_at_birth_value_recorded_in_weeks Real)
(declare-const patient_was_born_preterm_now Bool)
(declare-const patient_is_eligible_according_to_aap_guidelines_now Bool)
(declare-const patient_is_eligible_according_to_kmc_program_now Bool)
(declare-const patient_meets_combined_guidelines_for_phototherapy_now Bool)
(declare-const patient_has_finding_of_jaundice_now Bool)
(declare-const onset_of_jaundice_age_value_recorded_in_hours Real)
(declare-const patient_has_onset_of_jaundice_at_age_greater_than_48_hours Bool)
(declare-const patient_bilirubin_level_finding_value_recorded_now_withunit_g_per_dl Real)
(declare-const patient_has_finding_of_finding_of_blood_group_now Bool)
(declare-const patient_has_finding_of_finding_of_blood_group_now@@blood_group_of_mother Bool)
(declare-const patient_has_finding_of_finding_of_blood_group_now@@blood_group_of_child Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_hyperbilirubinemia_now@@low_risk patient_has_finding_of_hyperbilirubinemia_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_hyperbilirubinemia_now@@requires_phototherapy patient_has_finding_of_hyperbilirubinemia_now) :named REQ0_AUXILIARY1))
(assert (! (=> (< patient_gestational_age_at_birth_value_recorded_in_weeks 35.0) patient_was_born_preterm_now) :named REQ0_AUXILIARY2))
(assert (! (= patient_meets_combined_guidelines_for_phototherapy_now (and patient_is_eligible_according_to_aap_guidelines_now patient_is_eligible_according_to_kmc_program_now)) :named REQ0_AUXILIARY3))
(assert (! (= patient_has_onset_of_jaundice_at_age_greater_than_48_hours (and patient_has_finding_of_jaundice_now (> onset_of_jaundice_age_value_recorded_in_hours 48.0))) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_finding_of_blood_group_now@@blood_group_of_mother patient_has_finding_of_finding_of_blood_group_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_finding_of_blood_group_now@@blood_group_of_child patient_has_finding_of_finding_of_blood_group_now) :named REQ3_AUXILIARY1))

;; Other kept assertions
(assert (! (and patient_has_finding_of_hyperbilirubinemia_now@@low_risk patient_has_finding_of_hyperbilirubinemia_now@@requires_phototherapy patient_meets_combined_guidelines_for_phototherapy_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_onset_of_jaundice_at_age_greater_than_48_hours :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_bilirubin_level_finding_value_recorded_now_withunit_g_per_dl 18.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
