;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_alcohol_intake_above_recommended_sensible_limits_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_finding_of_chronic_liver_disease_now Bool)
(declare-const patient_has_finding_of_chronic_liver_disease_now@@caused_by_another_cause_other_than_hepatitis_c_virus_infection Bool)
(declare-const patient_has_finding_of_autoimmune_hepatitis_now Bool)
(declare-const patient_has_finding_of_primary_sclerosing_cholangitis_now Bool)
(declare-const patient_has_finding_of_primary_biliary_cholangitis_now Bool)
(declare-const patient_has_finding_of_alpha_1_antitrypsin_deficiency_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_autoimmune_hepatitis_now patient_has_finding_of_primary_sclerosing_cholangitis_now patient_has_finding_of_primary_biliary_cholangitis_now patient_has_finding_of_alpha_1_antitrypsin_deficiency_now) patient_has_finding_of_chronic_liver_disease_now@@caused_by_another_cause_other_than_hepatitis_c_virus_infection) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_chronic_liver_disease_now@@caused_by_another_cause_other_than_hepatitis_c_virus_infection patient_has_finding_of_chronic_liver_disease_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_alcohol_intake_above_recommended_sensible_limits_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_chronic_liver_disease_now@@caused_by_another_cause_other_than_hepatitis_c_virus_infection) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
