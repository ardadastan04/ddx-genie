;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_snoring_value_recorded_now_withunit_minutes Real)
(declare-const patient_snoring_value_recorded_now_withunit_minutes@@measured_during_sleep_study Bool)
(declare-const patient_central_sleep_apnea_syndrome_value_recorded_now_withunit_percent Real)
(declare-const patient_central_sleep_apnea_syndrome_value_recorded_now_withunit_percent@@measured_during_sleep_study Bool)

;; Other kept assertions
(assert (! (not (and patient_snoring_value_recorded_now_withunit_minutes@@measured_during_sleep_study (< patient_snoring_value_recorded_now_withunit_minutes 60))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_central_sleep_apnea_syndrome_value_recorded_now_withunit_percent@@measured_during_sleep_study (> patient_central_sleep_apnea_syndrome_value_recorded_now_withunit_percent 5))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
