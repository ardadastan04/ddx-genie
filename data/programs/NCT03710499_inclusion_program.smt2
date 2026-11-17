;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_acromegaly_now Bool)
(declare-const patient_has_finding_of_acromegaly_now@@active Bool)
(declare-const patient_has_finding_of_acromegaly_now@@controlled Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_patient_s_condition_stable_now Bool)
(declare-const patient_is_eligible_for_treatment_protocol_now Bool)
(declare-const patient_has_finding_of_hormone_deficiency_now Bool)
(declare-const patient_is_undergoing_hormone_replacement_therapy_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_acromegaly_now@@active patient_has_finding_of_acromegaly_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_acromegaly_now@@controlled patient_has_finding_of_acromegaly_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! patient_has_finding_of_acromegaly_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (< patient_age_value_recorded_now_in_years 65) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_acromegaly_now@@active patient_has_finding_of_acromegaly_now@@controlled) :named REQ0_COMPONENT3_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_patient_s_condition_stable_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_eligible_for_treatment_protocol_now :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or (not patient_has_finding_of_hormone_deficiency_now) patient_is_undergoing_hormone_replacement_therapy_now) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
