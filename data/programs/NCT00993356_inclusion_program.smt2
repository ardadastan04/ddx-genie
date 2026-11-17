;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_acromegaly_now Bool)
(declare-const patient_has_diagnosis_of_acromegaly_now@@newly_diagnosed Bool)
(declare-const patient_has_diagnosis_of_somatotroph_adenoma_now Bool)
(declare-const patient_is_previously_untreated Bool)
(declare-const growth_hormone_nadir_value_recorded_during_standard_75g_2hr_ogtt_withunit_micrograms_per_liter Real)
(declare-const patient_has_undergone_glucose_tolerance_test_now Bool)
(declare-const patient_has_finding_of_pituitary_macroadenoma_now Bool)
(declare-const patient_has_finding_of_pituitary_macroadenoma_now@@verified_by_pituitary_magnetic_resonance_imaging_scan Bool)
(declare-const patient_pituitary_macroadenoma_value_recorded_now_withunit_centimeter Real)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_acromegaly_now@@newly_diagnosed patient_has_diagnosis_of_acromegaly_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_pituitary_macroadenoma_now@@verified_by_pituitary_magnetic_resonance_imaging_scan patient_has_finding_of_pituitary_macroadenoma_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (and patient_has_diagnosis_of_acromegaly_now@@newly_diagnosed patient_has_diagnosis_of_somatotroph_adenoma_now) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_acromegaly_now@@newly_diagnosed :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_previously_untreated :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_undergone_glucose_tolerance_test_now (> growth_hormone_nadir_value_recorded_during_standard_75g_2hr_ogtt_withunit_micrograms_per_liter 2.5)) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (and patient_has_finding_of_pituitary_macroadenoma_now@@verified_by_pituitary_magnetic_resonance_imaging_scan (> patient_pituitary_macroadenoma_value_recorded_now_withunit_centimeter 1.0)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 80.0) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
