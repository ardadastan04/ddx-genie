;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_meets_age_criteria_as_defined_above_now Bool)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_inthehistory Bool)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_inthehistory@@severe_attack Bool)
(declare-const patient_has_diagnosis_of_acute_pancreatitis_inthehistory@@required_icu_stay_of_at_least_48_hours Bool)
(declare-const patient_has_finding_of_necrosis_of_pancreas_now Bool)
(declare-const patient_has_finding_of_necrosis_of_pancreas_now@@evidence_on_computerized_tomography Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_acute_pancreatitis_inthehistory@@severe_attack patient_has_diagnosis_of_acute_pancreatitis_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_acute_pancreatitis_inthehistory@@required_icu_stay_of_at_least_48_hours patient_has_diagnosis_of_acute_pancreatitis_inthehistory) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_necrosis_of_pancreas_now@@evidence_on_computerized_tomography patient_has_finding_of_necrosis_of_pancreas_now) :named REQ1_AUXILIARY2))

;; Other kept assertions
(assert (! patient_meets_age_criteria_as_defined_above_now :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and patient_has_diagnosis_of_acute_pancreatitis_inthehistory@@severe_attack patient_has_diagnosis_of_acute_pancreatitis_inthehistory@@required_icu_stay_of_at_least_48_hours) patient_has_finding_of_necrosis_of_pancreas_now@@evidence_on_computerized_tomography) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
