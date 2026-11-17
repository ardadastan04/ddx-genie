;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_at_time_of_ivf_cycle_in_years Real)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_has_diagnosis_of_endometriosis_now Bool)
(declare-const patient_has_diagnosis_of_female_infertility_of_cervical_origin_now Bool)
(declare-const patient_has_diagnosis_of_female_infertility_of_tubal_origin_now Bool)
(declare-const patient_has_infertility_associated_diagnosis_other_than_polycystic_ovary_syndrome_now Bool)
(declare-const patient_has_infertility_associated_diagnosis_other_than_polycystic_ovary_syndrome_now@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_unexplained_infertility_now Bool)
(declare-const patient_is_infertile_now Bool)
(declare-const patient_has_finding_of_unexplained_infertility_now@@strong_clinical_support Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_diagnosis_of_female_infertility_of_tubal_origin_now patient_has_diagnosis_of_female_infertility_of_cervical_origin_now patient_has_diagnosis_of_endometriosis_now) patient_has_infertility_associated_diagnosis_other_than_polycystic_ovary_syndrome_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_infertility_associated_diagnosis_other_than_polycystic_ovary_syndrome_now@@strong_clinical_support patient_has_infertility_associated_diagnosis_other_than_polycystic_ovary_syndrome_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_unexplained_infertility_now patient_is_infertile_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_unexplained_infertility_now@@strong_clinical_support patient_has_finding_of_unexplained_infertility_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (not (>= patient_age_value_at_time_of_ivf_cycle_in_years 35)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_sex_is_female_now patient_has_infertility_associated_diagnosis_other_than_polycystic_ovary_syndrome_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_unexplained_infertility_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
