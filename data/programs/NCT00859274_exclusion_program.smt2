;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_exposed_to_corticosteroid_series_inthehistory Bool)
(declare-const patient_is_exposed_to_corticosteroid_series_inthehistory@@route_inhaled Bool)
(declare-const patient_is_exposed_to_corticosteroid_series_inthehistory@@route_oral Bool)
(declare-const patient_has_finding_of_febrile_respiratory_infection_recently Bool)
(declare-const patient_has_finding_of_asthma_now Bool)
(declare-const patient_has_finding_of_asthma_now@@unstable Bool)
(declare-const patient_has_finding_of_severe_asthma_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_corticosteroid_series_inthehistory@@route_inhaled patient_is_exposed_to_corticosteroid_series_inthehistory) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_corticosteroid_series_inthehistory@@route_oral patient_is_exposed_to_corticosteroid_series_inthehistory) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_asthma_now@@unstable patient_has_finding_of_asthma_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_is_exposed_to_corticosteroid_series_inthehistory@@route_inhaled) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_corticosteroid_series_inthehistory@@route_oral) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_febrile_respiratory_infection_recently) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_severe_asthma_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_asthma_now@@unstable) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
