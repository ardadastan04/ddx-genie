;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_carotid_artery_plaque_now Bool)
(declare-const patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent Real)
(declare-const patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent@@measured_by_north_american_symptomatic_carotid_endarterectomy_trial_method Bool)
(declare-const patient_has_finding_of_ischemic_stroke_inthepast15days Bool)
(declare-const patient_has_finding_of_ischemic_stroke_inthepast15days@@confirmed_on_computed_tomography Bool)
(declare-const patient_has_finding_of_ischemic_stroke_inthepast15days@@confirmed_on_magnetic_resonance_imaging Bool)
(declare-const patient_has_ability_to_give_informed_consent_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent@@measured_by_north_american_symptomatic_carotid_endarterectomy_trial_method true) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_ischemic_stroke_inthepast15days@@confirmed_on_computed_tomography patient_has_finding_of_ischemic_stroke_inthepast15days) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_ischemic_stroke_inthepast15days@@confirmed_on_magnetic_resonance_imaging patient_has_finding_of_ischemic_stroke_inthepast15days) :named REQ1_AUXILIARY2))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_finding_of_carotid_artery_plaque_now (>= patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent 50.0) patient_stenosis_of_carotid_artery_value_recorded_now_withunit_percent@@measured_by_north_american_symptomatic_carotid_endarterectomy_trial_method) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_ischemic_stroke_inthepast15days@@confirmed_on_computed_tomography patient_has_finding_of_ischemic_stroke_inthepast15days@@confirmed_on_magnetic_resonance_imaging) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_ability_to_give_informed_consent_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
