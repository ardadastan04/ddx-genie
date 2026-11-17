;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_undergone_measurement_of_respiratory_function_inthehistory Bool)
(declare-const patient_percent_predicted_fev1_value_recorded_inthehistory_withunit_percent Real)
(declare-const patient_has_finding_of_chronic_disease_now Bool)
(declare-const patient_has_finding_of_chronic_infectious_disease_now Bool)
(declare-const patient_has_finding_of_human_immunodeficiency_virus_infection_now Bool)
(declare-const patient_has_finding_of_tuberculosis_infection_now Bool)
(declare-const patient_has_finding_of_malignancy_now Bool)
(declare-const patient_can_undergo_spirometry_now Bool)
(declare-const patient_is_undergoing_clinical_trial_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_human_immunodeficiency_virus_infection_now patient_has_finding_of_tuberculosis_infection_now patient_has_finding_of_malignancy_now) patient_has_finding_of_chronic_disease_now) :named REQ2_AUXILIARY0))
(assert (! (=> (or patient_has_finding_of_human_immunodeficiency_virus_infection_now patient_has_finding_of_tuberculosis_infection_now patient_has_finding_of_malignancy_now) patient_has_finding_of_chronic_infectious_disease_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 3)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_age_value_recorded_now_in_years 6)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_undergone_measurement_of_respiratory_function_inthehistory (< patient_percent_predicted_fev1_value_recorded_inthehistory_withunit_percent 70))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_chronic_disease_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_chronic_infectious_disease_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_can_undergo_spirometry_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_clinical_trial_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
