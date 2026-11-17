;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_received_treatment_for_obstructive_sleep_apnea_syndrome_in_the_history Bool)
(declare-const patient_has_finding_of_central_sleep_apnea_syndrome_now Bool)
(declare-const patient_has_finding_of_central_sleep_apnea_syndrome_now@@main_type_presented Bool)
(declare-const patient_has_finding_of_cheyne_stokes_respiration_now Bool)
(declare-const patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour Real)
(declare-const patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour@@recorded_during_unattended_sleep_study_at_home Bool)
(declare-const patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_central_sleep_apnea_syndrome_now@@main_type_presented patient_has_finding_of_central_sleep_apnea_syndrome_now) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now (and (>= patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour 5) (< patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour 15) patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour@@recorded_during_unattended_sleep_study_at_home)) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_received_treatment_for_obstructive_sleep_apnea_syndrome_in_the_history) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_central_sleep_apnea_syndrome_now@@main_type_presented) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_cheyne_stokes_respiration_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
