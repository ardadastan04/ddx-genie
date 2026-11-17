;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_asymptomatic_now Bool)
(declare-const patient_has_finding_of_carotid_atherosclerosis_now Bool)
(declare-const patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent Real)
(declare-const patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent@@measured_by_north_american_symptomatic_carotid_endarterectomy_trial_method Bool)
(declare-const patient_has_ability_to_give_informed_consent Bool)

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_finding_of_carotid_atherosclerosis_now (>= patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent 50.0) patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent@@measured_by_north_american_symptomatic_carotid_endarterectomy_trial_method) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_asymptomatic_now :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_ability_to_give_informed_consent :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
