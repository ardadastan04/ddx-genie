;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_asthma_inthehistory Bool)
(declare-const patient_presents_to_clinic_with_severe_acute_exacerbation_now Bool)
(declare-const patient_presents_to_hospital_with_severe_acute_exacerbation_now Bool)
(declare-const patient_presents_to_hospital_with_severe_acute_asthma_exacerbation_now Bool)
(declare-const patient_presents_to_clinic_with_severe_acute_asthma_exacerbation_now Bool)
(declare-const patient_is_male Bool)
(declare-const patient_is_female Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (=> patient_presents_to_hospital_with_severe_acute_asthma_exacerbation_now patient_presents_to_hospital_with_severe_acute_exacerbation_now) :named REQ0_AUXILIARY_BRIDGE_HOSPITAL_ASTHMA_EXACERBATION_TO_SEVERE_ACUTE_EXACERBATION))
(assert (! (=> patient_presents_to_clinic_with_severe_acute_asthma_exacerbation_now patient_presents_to_clinic_with_severe_acute_exacerbation_now) :named REQ0_AUXILIARY_BRIDGE_CLINIC_ASTHMA_EXACERBATION_TO_SEVERE_ACUTE_EXACERBATION))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_asthma_inthehistory :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_presents_to_hospital_with_severe_acute_asthma_exacerbation_now patient_presents_to_clinic_with_severe_acute_asthma_exacerbation_now) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (or patient_is_male patient_is_female) (>= patient_age_value_recorded_now_in_years 2) (<= patient_age_value_recorded_now_in_years 10)) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
