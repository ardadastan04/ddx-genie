;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_major_cardiac_comorbid_illness_now Bool)
(declare-const patient_has_major_pulmonary_comorbid_illness_now_other_than_asthma Bool)
(declare-const patient_has_family_who_is_non_english_speaking_now Bool)
(declare-const patient_has_family_who_is_non_english_speaking_now@@primary_caregiver Bool)
(declare-const patient_has_finding_of_respiratory_distress_now Bool)
(declare-const patient_has_finding_of_respiratory_distress_now@@severe Bool)
(declare-const patient_was_triaged_to_medical_trauma_bay_now Bool)
(declare-const patient_was_triaged_to_medical_trauma_bay_now@@for_severe_respiratory_distress Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_family_who_is_non_english_speaking_now@@primary_caregiver patient_has_family_who_is_non_english_speaking_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_respiratory_distress_now@@severe patient_has_finding_of_respiratory_distress_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_was_triaged_to_medical_trauma_bay_now@@for_severe_respiratory_distress patient_was_triaged_to_medical_trauma_bay_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_major_pulmonary_comorbid_illness_now_other_than_asthma) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_major_cardiac_comorbid_illness_now) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_family_who_is_non_english_speaking_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_was_triaged_to_medical_trauma_bay_now@@for_severe_respiratory_distress) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
