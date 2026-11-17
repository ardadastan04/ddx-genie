;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_coronary_arteriosclerosis_now Bool)
(declare-const patient_has_diagnosis_of_coronary_arteriosclerosis_now@@diagnosis_verified_by_angiography Bool)
(declare-const patient_has_undergone_percutaneous_coronary_intervention_now Bool)
(declare-const patient_has_undergone_percutaneous_coronary_intervention_now@@newly_undergone Bool)
(declare-const patient_has_undergone_coronary_artery_bypass_graft_now Bool)
(declare-const patient_has_undergone_coronary_artery_bypass_graft_now@@newly_undergone Bool)
(declare-const patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now Bool)
(declare-const patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour Real)
(declare-const patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour@@measured_on_unattended_sleep_recording_at_home Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_coronary_arteriosclerosis_now@@diagnosis_verified_by_angiography patient_has_diagnosis_of_coronary_arteriosclerosis_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_percutaneous_coronary_intervention_now@@newly_undergone patient_has_undergone_percutaneous_coronary_intervention_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_coronary_artery_bypass_graft_now@@newly_undergone patient_has_undergone_coronary_artery_bypass_graft_now) :named REQ0_AUXILIARY2))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_coronary_arteriosclerosis_now@@diagnosis_verified_by_angiography :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_undergone_percutaneous_coronary_intervention_now@@newly_undergone patient_has_undergone_coronary_artery_bypass_graft_now@@newly_undergone) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour@@measured_on_unattended_sleep_recording_at_home (>= patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour 15.0)) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
