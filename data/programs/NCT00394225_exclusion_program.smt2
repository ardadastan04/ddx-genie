;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast4weeks Bool)
(declare-const patient_is_undergoing_oxygen_therapy_now Bool)
(declare-const patient_has_finding_of_cardiovascular_system_alteration_now Bool)
(declare-const patient_has_finding_of_cardiovascular_system_alteration_now@@significant Bool)
(declare-const patient_has_finding_of_musculoskeletal_alteration_now Bool)
(declare-const patient_has_finding_of_musculoskeletal_alteration_now@@significant Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_cardiovascular_system_alteration_now@@significant patient_has_finding_of_cardiovascular_system_alteration_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_musculoskeletal_alteration_now@@significant patient_has_finding_of_musculoskeletal_alteration_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_acute_exacerbation_of_chronic_obstructive_pulmonary_disease_inthepast4weeks) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_oxygen_therapy_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_cardiovascular_system_alteration_now@@significant) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_musculoskeletal_alteration_now@@significant) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
