;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_unable_to_provide_informed_consent_now Bool)
(declare-const patient_is_unwilling_to_provide_informed_consent_now Bool)
(declare-const patient_has_undergone_carotid_endarterectomy_inthehistory Bool)
(declare-const patient_has_undergone_insertion_of_carotid_artery_stent_inthehistory Bool)
(declare-const patient_has_finding_of_aortic_valve_stenosis_now Bool)
(declare-const patient_has_finding_of_congestive_heart_failure_now Bool)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)

;; Other kept assertions
(assert (! (not (or patient_is_unable_to_provide_informed_consent_now patient_is_unwilling_to_provide_informed_consent_now)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_carotid_endarterectomy_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_insertion_of_carotid_artery_stent_inthehistory) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_aortic_valve_stenosis_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_congestive_heart_failure_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 35)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
