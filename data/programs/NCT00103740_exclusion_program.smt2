;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_allergy_to_bisphosphonate_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_upper_gastrointestinal_tract_inthehistory Bool)
(declare-const patient_has_finding_of_iritis_inthehistory Bool)
(declare-const patient_has_finding_of_uveitis_inthehistory Bool)
(declare-const patient_measurement_of_renal_clearance_of_creatinine_value_recorded_now_withunit_milliliters_per_minute Real)
(declare-const patient_measurement_of_renal_clearance_of_creatinine_value_recorded_now_withunit_milliliters_per_minute@@temporalcontext_at_baseline Bool)
(declare-const patient_has_finding_of_vitamin_d_deficiency_now Bool)

;; Other kept assertions
(assert (! (not patient_has_finding_of_allergy_to_bisphosphonate_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disorder_of_upper_gastrointestinal_tract_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_iritis_inthehistory) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_uveitis_inthehistory) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_measurement_of_renal_clearance_of_creatinine_value_recorded_now_withunit_milliliters_per_minute@@temporalcontext_at_baseline (< patient_measurement_of_renal_clearance_of_creatinine_value_recorded_now_withunit_milliliters_per_minute 30))) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_vitamin_d_deficiency_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
