;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_metronidazole_containing_product_in_oral_dose_form_value_recorded_inthehistory_withunit_days Real)
(declare-const patient_metronidazole_containing_product_in_oral_dose_form_value_recorded_inthehistory_withunit_days@@for_treatment_of_clostridium_difficile_colitis Bool)

;; Other kept assertions
(assert (! (not (and patient_metronidazole_containing_product_in_oral_dose_form_value_recorded_inthehistory_withunit_days@@for_treatment_of_clostridium_difficile_colitis (< patient_metronidazole_containing_product_in_oral_dose_form_value_recorded_inthehistory_withunit_days 7))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
