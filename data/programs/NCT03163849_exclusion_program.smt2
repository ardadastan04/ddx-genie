;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_hypersensitivity_condition_now Bool)
(declare-const patient_has_finding_of_hypersensitivity_condition_now@@known Bool)
(declare-const patient_has_finding_of_hypersensitivity_condition_now@@to_any_component_of_antiviral_drug Bool)
(declare-const patient_has_undergone_transplantation_of_liver_inthehistory Bool)
(declare-const patient_has_finding_of_primary_haematological_abnormality_now Bool)
(declare-const patient_has_finding_of_primary_haematological_abnormality_now@@not_related_to_chronic_hepatitis_c_virus_infection Bool)
(declare-const patient_has_undergone_antiviral_therapy_inthehistory_outcome_is_negative Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_hypersensitivity_condition_now@@known patient_has_finding_of_hypersensitivity_condition_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_hypersensitivity_condition_now@@to_any_component_of_antiviral_drug patient_has_finding_of_hypersensitivity_condition_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_finding_of_primary_haematological_abnormality_now@@not_related_to_chronic_hepatitis_c_virus_infection patient_has_finding_of_primary_haematological_abnormality_now) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! (not (> patient_age_value_recorded_now_in_years 65)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_hypersensitivity_condition_now@@known patient_has_finding_of_hypersensitivity_condition_now@@to_any_component_of_antiviral_drug)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_transplantation_of_liver_inthehistory) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_primary_haematological_abnormality_now@@not_related_to_chronic_hepatitis_c_virus_infection) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_antiviral_therapy_inthehistory_outcome_is_negative) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
