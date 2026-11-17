;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_cerebrovascular_accident_now Bool)
(declare-const patient_has_diagnosis_of_cerebrovascular_accident_now@@diagnosis_by_radiological_imaging Bool)
(declare-const patient_cerebrovascular_accident_time_elapsed_inthehistory_withunit_months Real)
(declare-const patient_has_finding_of_patient_s_condition_stable_now Bool)
(declare-const patient_has_signed_informed_consent_form Bool)
(declare-const patient_has_dated_informed_consent_form Bool)
(declare-const patient_has_signed_and_dated_informed_consent_form Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_cerebrovascular_accident_now@@diagnosis_by_radiological_imaging patient_has_diagnosis_of_cerebrovascular_accident_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_signed_and_dated_informed_consent_form (and patient_has_signed_informed_consent_form patient_has_dated_informed_consent_form)) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_cerebrovascular_accident_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_cerebrovascular_accident_now@@diagnosis_by_radiological_imaging :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_cerebrovascular_accident_time_elapsed_inthehistory_withunit_months 1.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_patient_s_condition_stable_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
