;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_will_undergo_duplex_ultrasonography_of_carotid_artery_inthefuture Bool)
(declare-const patient_will_undergo_duplex_ultrasonography_of_carotid_artery_inthefuture@@diagnostic_intent Bool)
(declare-const patient_has_diagnosis_of_hypertensive_disorder_now Bool)
(declare-const patient_has_finding_of_disorder_of_lipid_metabolism_now Bool)
(declare-const patient_has_finding_of_diabetes_mellitus_now Bool)
(declare-const patient_has_finding_of_tobacco_user_inthehistory Bool)
(declare-const patient_has_diagnosis_of_coronary_arteriosclerosis_now Bool)
(declare-const patient_has_diagnosis_of_peripheral_arterial_disease_now Bool)
(declare-const patient_has_finding_of_atherosclerosis_of_artery_now Bool)
(declare-const patient_has_finding_of_atherosclerosis_of_artery_now@@family_history Bool)
(declare-const patient_has_finding_of_atherosclerosis_of_artery_now@@early_onset Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_atherosclerosis_of_artery_now@@family_history patient_has_finding_of_atherosclerosis_of_artery_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_atherosclerosis_of_artery_now@@early_onset patient_has_finding_of_atherosclerosis_of_artery_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_will_undergo_duplex_ultrasonography_of_carotid_artery_inthefuture@@diagnostic_intent patient_will_undergo_duplex_ultrasonography_of_carotid_artery_inthefuture) :named REQ0_AUXILIARY2))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 65.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_diagnosis_of_hypertensive_disorder_now patient_has_finding_of_disorder_of_lipid_metabolism_now patient_has_finding_of_diabetes_mellitus_now patient_has_finding_of_tobacco_user_inthehistory patient_has_diagnosis_of_coronary_arteriosclerosis_now patient_has_diagnosis_of_peripheral_arterial_disease_now (and patient_has_finding_of_atherosclerosis_of_artery_now@@family_history patient_has_finding_of_atherosclerosis_of_artery_now@@early_onset)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
