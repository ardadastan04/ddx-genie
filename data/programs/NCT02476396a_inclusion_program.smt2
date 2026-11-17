;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_undergoing_carotid_endarterectomy_now Bool)
(declare-const patient_is_undergoing_carotid_artery_stenting_now Bool)
(declare-const patient_is_undergoing_carotid_artery_stenting_now@@for_established_clinical_criteria Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_female Bool)
(declare-const patient_is_male Bool)
(declare-const patient_is_english_speaking Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_carotid_artery_stenting_now@@for_established_clinical_criteria patient_is_undergoing_carotid_artery_stenting_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (or patient_is_undergoing_carotid_endarterectomy_now patient_is_undergoing_carotid_artery_stenting_now@@for_established_clinical_criteria) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_is_male patient_is_female) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_english_speaking :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
