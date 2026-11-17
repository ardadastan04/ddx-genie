;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_glucose_tolerance_test_inthehistory Bool)
(declare-const patient_has_undergone_glucose_tolerance_test_inthehistory@@uses_75_gram_glucose_load Bool)
(declare-const patient_plasma_fasting_glucose_measurement_value_recorded_inthehistory_withunit_milligrams_per_deciliter Real)
(declare-const patient_plasma_2_hour_glucose_measurement_value_recorded_inthehistory_withunit_milligrams_per_deciliter Real)
(declare-const patient_hemoglobin_a1c_measurement_value_recorded_inthehistory_withunit_percent Real)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_glucose_tolerance_test_inthehistory@@uses_75_gram_glucose_load patient_has_undergone_glucose_tolerance_test_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (and patient_has_undergone_glucose_tolerance_test_inthehistory patient_has_undergone_glucose_tolerance_test_inthehistory@@uses_75_gram_glucose_load (<= patient_plasma_fasting_glucose_measurement_value_recorded_inthehistory_withunit_milligrams_per_deciliter 125.0)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_undergone_glucose_tolerance_test_inthehistory patient_has_undergone_glucose_tolerance_test_inthehistory@@uses_75_gram_glucose_load (>= patient_plasma_2_hour_glucose_measurement_value_recorded_inthehistory_withunit_milligrams_per_deciliter 200.0)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (and patient_has_undergone_glucose_tolerance_test_inthehistory patient_has_undergone_glucose_tolerance_test_inthehistory@@uses_75_gram_glucose_load (<= patient_hemoglobin_a1c_measurement_value_recorded_inthehistory_withunit_percent 6.9)) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
