;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_near_fatal_asthma_inthehistory Bool)
(declare-const patient_required_stay_in_intensive_care_unit_in_the_history Bool)
(declare-const patient_has_high_risk_of_asthma_related_death Bool)
(declare-const patient_is_undergoing_oral_steroid_therapy_now Bool)
(declare-const patient_has_undergone_oral_steroid_therapy_inthepast4weeks Bool)
(declare-const patient_is_exposed_to_omalizumab_now Bool)
(declare-const patient_is_pregnant_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_high_risk_of_asthma_related_death (and patient_has_finding_of_near_fatal_asthma_inthehistory patient_required_stay_in_intensive_care_unit_in_the_history)) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_high_risk_of_asthma_related_death) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_oral_steroid_therapy_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_oral_steroid_therapy_inthepast4weeks) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_omalizumab_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
