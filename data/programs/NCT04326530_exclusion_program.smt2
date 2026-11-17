;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_acute_asthma_inthepast4weeks Bool)
(declare-const patient_has_finding_of_acute_asthma_inthepast4weeks@@required_oral_corticosteroid_therapy Bool)
(declare-const patient_is_exposed_to_leukotriene_receptor_antagonist_inthepast4weeks Bool)
(declare-const patient_has_undergone_inhaled_steroid_therapy_inthepast4weeks Bool)
(declare-const patient_has_finding_of_respiratory_tract_infection_inthepast4weeks Bool)
(declare-const patient_has_diagnosis_of_disorder_of_immune_function_now Bool)
(declare-const patient_has_diagnosis_of_metabolic_disease_now Bool)
(declare-const patient_has_diagnosis_of_heart_disease_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_nervous_system_now Bool)
(declare-const patient_has_major_malformation_of_respiratory_system_now Bool)
(declare-const patient_has_finding_of_tobacco_smoking_behavior_finding_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_acute_asthma_inthepast4weeks@@required_oral_corticosteroid_therapy patient_has_finding_of_acute_asthma_inthepast4weeks) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_acute_asthma_inthepast4weeks@@required_oral_corticosteroid_therapy) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_leukotriene_receptor_antagonist_inthepast4weeks) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_inhaled_steroid_therapy_inthepast4weeks) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_respiratory_tract_infection_inthepast4weeks) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disorder_of_immune_function_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_metabolic_disease_now) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_heart_disease_now) :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disorder_of_nervous_system_now) :named REQ3_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_major_malformation_of_respiratory_system_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_tobacco_smoking_behavior_finding_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
