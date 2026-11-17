;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_gout_inthehistory Bool)
(declare-const patient_has_finding_of_uric_acid_urolithiasis_inthehistory Bool)
(declare-const patient_has_finding_of_uric_acid_nephrolithiasis_inthehistory Bool)
(declare-const patient_has_finding_of_renal_impairment_inthehistory Bool)
(declare-const patient_has_finding_of_gastric_ulcer_inthehistory Bool)
(declare-const patient_is_taking_systemic_corticosteroid_medication_concurrently Bool)
(declare-const patient_is_taking_immunosuppressant_now Bool)
(declare-const patient_is_taking_immunosuppressant_now@@concurrent_medication Bool)
(declare-const patient_is_receiving_radiotherapy_as_concurrent_treatment_now Bool)
(declare-const patient_has_finding_of_patient_status_determination_critical_now Bool)
(declare-const patient_has_finding_of_aids_now Bool)
(declare-const patient_has_undergone_immunological_therapy_inthepast1months Bool)
(declare-const patient_has_finding_of_persistent_generalized_lymphadenopathy_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_taking_immunosuppressant_now@@concurrent_medication patient_is_taking_immunosuppressant_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_gout_inthehistory) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_uric_acid_urolithiasis_inthehistory) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_uric_acid_nephrolithiasis_inthehistory) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_renal_impairment_inthehistory) :named REQ0_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_gastric_ulcer_inthehistory) :named REQ0_COMPONENT4_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_systemic_corticosteroid_medication_concurrently) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_immunosuppressant_now@@concurrent_medication) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_receiving_radiotherapy_as_concurrent_treatment_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_patient_status_determination_critical_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_aids_now) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_immunological_therapy_inthepast1months) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_persistent_generalized_lymphadenopathy_now) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
