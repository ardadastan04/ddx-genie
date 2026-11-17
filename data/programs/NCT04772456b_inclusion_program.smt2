;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_glioma_inthehistory Bool)
(declare-const patient_has_diagnosis_of_glioma_inthehistory@@is_infiltrating Bool)
(declare-const patient_will_undergo_biopsy_inthefuture Bool)
(declare-const patient_will_undergo_biopsy_inthefuture@@for_tumor Bool)
(declare-const patient_will_undergo_excision_inthefuture Bool)
(declare-const patient_will_undergo_excision_inthefuture@@for_tumor Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_can_undergo_mri_with_contrast_now Bool)
(declare-const patient_has_undergone_serum_pregnancy_test_latest Bool)
(declare-const serum_pregnancy_test_result_value_latest_withunit_ng_per_ml Real)
(declare-const patient_is_pregnant_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_glioma_inthehistory@@is_infiltrating patient_has_diagnosis_of_glioma_inthehistory) :named REQ0_AUXILIARY0))
(assert (! (=> patient_will_undergo_biopsy_inthefuture@@for_tumor patient_will_undergo_biopsy_inthefuture) :named REQ0_AUXILIARY1))
(assert (! (=> patient_will_undergo_excision_inthefuture@@for_tumor patient_will_undergo_excision_inthefuture) :named REQ0_AUXILIARY2))
(assert (! (=> (and patient_has_undergone_serum_pregnancy_test_latest (< serum_pregnancy_test_result_value_latest_withunit_ng_per_ml 5.0)) (not patient_is_pregnant_now)) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_glioma_inthehistory@@is_infiltrating :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_will_undergo_biopsy_inthefuture@@for_tumor patient_will_undergo_excision_inthefuture@@for_tumor) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 80.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_can_undergo_mri_with_contrast_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_undergone_serum_pregnancy_test_latest (< serum_pregnancy_test_result_value_latest_withunit_ng_per_ml 5.0)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
