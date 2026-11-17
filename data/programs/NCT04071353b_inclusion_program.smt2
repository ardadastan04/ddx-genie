;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_hepatitis_c_now Bool)
(declare-const patient_is_exposed_to_antiviral_inthehistory Bool)
(declare-const patient_is_exposed_to_antiviral_inthehistory@@direct_acting Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_antiviral_inthehistory@@direct_acting patient_is_exposed_to_antiviral_inthehistory) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_chronic_hepatitis_c_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_exposed_to_antiviral_inthehistory@@direct_acting :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
