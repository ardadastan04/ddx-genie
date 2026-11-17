;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_taking_levodopa_containing_product_in_oral_dose_form_now Bool)
(declare-const patient_has_finding_of_dyskinesia_inthehistory Bool)
(declare-const patient_has_finding_of_dyskinesia_inthehistory@@confirmed_by_previous_clinical_observation Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_dyskinesia_inthehistory@@confirmed_by_previous_clinical_observation patient_has_finding_of_dyskinesia_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 21.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_taking_levodopa_containing_product_in_oral_dose_form_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_dyskinesia_inthehistory patient_has_finding_of_dyskinesia_inthehistory@@confirmed_by_previous_clinical_observation) :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
