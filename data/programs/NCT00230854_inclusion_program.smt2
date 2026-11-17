;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_viral_hepatitis_c_now Bool)
(declare-const patient_hepatitis_c_virus_genotype_value_now_withunit_numeric Int)
(declare-const patient_is_exposed_to_interferon_inthehistory Bool)
(declare-const patient_is_exposed_to_interferon_inthehistory@@pegylated_form Bool)
(declare-const patient_is_exposed_to_interferon_inthehistory@@as_therapy Bool)
(declare-const patient_is_exposed_to_ribavirin_inthehistory Bool)
(declare-const patient_is_exposed_to_ribavirin_inthehistory@@as_therapy Bool)
(declare-const patient_has_finding_of_determination_of_outcome_unsuccessful_inthehistory Bool)
(declare-const patient_has_finding_of_determination_of_outcome_unsuccessful_inthehistory@@documented Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_interferon_inthehistory@@pegylated_form patient_is_exposed_to_interferon_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_interferon_inthehistory@@as_therapy patient_is_exposed_to_interferon_inthehistory) :named REQ1_AUXILIARY1))
(assert (! (=> patient_is_exposed_to_ribavirin_inthehistory@@as_therapy patient_is_exposed_to_ribavirin_inthehistory) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_finding_of_determination_of_outcome_unsuccessful_inthehistory@@documented patient_has_finding_of_determination_of_outcome_unsuccessful_inthehistory) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_finding_of_viral_hepatitis_c_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (= patient_hepatitis_c_virus_genotype_value_now_withunit_numeric 1) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_is_exposed_to_interferon_inthehistory@@pegylated_form patient_is_exposed_to_interferon_inthehistory@@as_therapy) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_exposed_to_ribavirin_inthehistory@@as_therapy :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_determination_of_outcome_unsuccessful_inthehistory@@documented :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
