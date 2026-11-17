;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_refused_to_sign_informed_consent_form Bool)
(declare-const patient_has_undergone_bariatric_operative_procedure_inthehistory Bool)
(declare-const patient_has_undergone_total_abdominal_colectomy_with_ileoproctostomy_inthehistory Bool)
(declare-const patient_has_undergone_excision_of_colon_and_rectum_inthehistory Bool)
(declare-const patient_has_undergone_construction_of_stoma_inthehistory Bool)
(declare-const patient_has_undergone_postoperative_ostomy_inthehistory Bool)
(declare-const patient_has_undergone_creation_of_ileo_anal_pouch_inthehistory Bool)
(declare-const patient_has_undergone_clinical_drug_trial_inthepast12weeks Bool)
(declare-const patient_is_receiving_total_parenteral_nutrition_now Bool)

;; Other kept assertions
(assert (! (not patient_refused_to_sign_informed_consent_form) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_bariatric_operative_procedure_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_total_abdominal_colectomy_with_ileoproctostomy_inthehistory) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_excision_of_colon_and_rectum_inthehistory) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_construction_of_stoma_inthehistory) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_postoperative_ostomy_inthehistory) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_creation_of_ileo_anal_pouch_inthehistory) :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_clinical_drug_trial_inthepast12weeks) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_receiving_total_parenteral_nutrition_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
