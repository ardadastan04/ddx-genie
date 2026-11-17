;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_myocardial_infarction_inthepast3months Bool)
(declare-const patient_has_finding_of_sustained_ventricular_tachycardia_inthehistory Bool)
(declare-const patient_has_finding_of_sustained_ventricular_fibrillation_inthehistory Bool)
(declare-const patient_has_finding_of_heart_failure_now Bool)
(declare-const patient_has_finding_of_heart_failure_now@@new_york_heart_association_class_iv Bool)
(declare-const patient_has_finding_of_preinfarction_syndrome_now Bool)
(declare-const patient_has_finding_of_syncope_now Bool)
(declare-const patient_has_finding_of_syncope_now@@is_presenting_symptom Bool)
(declare-const patient_is_unable_to_use_device_at_office_visit Bool)
(declare-const patient_is_unwilling_to_use_device Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_heart_failure_now@@new_york_heart_association_class_iv patient_has_finding_of_heart_failure_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_syncope_now@@is_presenting_symptom patient_has_finding_of_syncope_now) :named REQ4_AUXILIARY0))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_myocardial_infarction_inthepast3months) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_sustained_ventricular_tachycardia_inthehistory) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_sustained_ventricular_fibrillation_inthehistory) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_heart_failure_now@@new_york_heart_association_class_iv) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_preinfarction_syndrome_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_syncope_now@@is_presenting_symptom) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_use_device_at_office_visit) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unwilling_to_use_device) :named REQ5_COMPONENT1_OTHER_REQUIREMENTS))
