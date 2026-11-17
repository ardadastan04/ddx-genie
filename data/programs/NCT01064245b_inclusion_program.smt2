;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_suspicion_of_cough_variant_asthma_now Bool)
(declare-const patient_has_previously_participated_in_studies Bool)
(declare-const patient_has_expressed_interest_in_participating_in_studies Bool)
(declare-const patient_is_exposed_to_corticosteroid_series_inthehistory Bool)
(declare-const patient_is_exposed_to_corticosteroid_series_inthehistory@@inhaled_route Bool)
(declare-const patient_is_exposed_to_corticosteroid_series_inthehistory@@systemic_route Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_corticosteroid_series_inthehistory@@inhaled_route patient_is_exposed_to_corticosteroid_series_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_corticosteroid_series_inthehistory@@systemic_route patient_is_exposed_to_corticosteroid_series_inthehistory) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! (and patient_has_suspicion_of_cough_variant_asthma_now (or patient_has_previously_participated_in_studies patient_has_expressed_interest_in_participating_in_studies)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! true :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
