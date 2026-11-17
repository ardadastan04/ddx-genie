;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_biopsy_of_prostate_inthehistory Bool)
(declare-const patient_has_undergone_biopsy_of_prostate_inthehistory@@outcome_is_negative Bool)
(declare-const patient_number_of_prior_negative_prostate_biopsies_value_recorded_history_withunit_count Int)
(declare-const prostate_specific_antigen_value_latest_withunit_nanograms_per_milliliter Real)

;; Existing auxiliary assertions
(assert (! (=> (>= patient_number_of_prior_negative_prostate_biopsies_value_recorded_history_withunit_count 1) patient_has_undergone_biopsy_of_prostate_inthehistory@@outcome_is_negative) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_biopsy_of_prostate_inthehistory@@outcome_is_negative patient_has_undergone_biopsy_of_prostate_inthehistory) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (>= patient_number_of_prior_negative_prostate_biopsies_value_recorded_history_withunit_count 1) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> prostate_specific_antigen_value_latest_withunit_nanograms_per_milliliter 4.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
