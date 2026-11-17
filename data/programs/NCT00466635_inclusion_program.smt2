;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_clostridium_difficile_diarrhea_now Bool)
(declare-const patient_has_childbearing_potential_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const serum_pregnancy_test_result_value_recorded_now_withunit_milli_international_units_per_milliliter Real)

;; Existing auxiliary assertions
(assert (! (= patient_is_pregnant_now (>= serum_pregnancy_test_result_value_recorded_now_withunit_milli_international_units_per_milliliter 5.0)) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_finding_of_clostridium_difficile_diarrhea_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (not patient_has_childbearing_potential_now) (not patient_is_pregnant_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
