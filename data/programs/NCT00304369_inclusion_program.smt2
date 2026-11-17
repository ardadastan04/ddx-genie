;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_collection_of_stool_specimen_inthehistory Bool)
(declare-const patient_has_undergone_collection_of_stool_specimen_inthehistory@@outcome_is_positive_for_clostridium_difficile_toxin Bool)
(declare-const patient_has_received_treatment_for_clostridium_difficile_colitis_with_oral_metronidazole_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_collection_of_stool_specimen_inthehistory@@outcome_is_positive_for_clostridium_difficile_toxin patient_has_undergone_collection_of_stool_specimen_inthehistory) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_undergone_collection_of_stool_specimen_inthehistory@@outcome_is_positive_for_clostridium_difficile_toxin :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_received_treatment_for_clostridium_difficile_colitis_with_oral_metronidazole_inthehistory :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
