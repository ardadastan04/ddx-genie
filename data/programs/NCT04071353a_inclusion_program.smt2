;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=1
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_chronic_active_hepatitis_c_now Bool)
(declare-const patient_has_undergone_interferon_antiviral_therapy_inthehistory@@administered_with_ribavirin Bool)
(declare-const patient_has_undergone_interferon_antiviral_therapy_inthehistory@@duration_in_months Real)
(declare-const patient_has_undergone_interferon_antiviral_therapy_inthehistory Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_interferon_antiviral_therapy_inthehistory@@administered_with_ribavirin patient_has_undergone_interferon_antiviral_therapy_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_chronic_active_hepatitis_c_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_undergone_interferon_antiviral_therapy_inthehistory@@administered_with_ribavirin (>= patient_has_undergone_interferon_antiviral_therapy_inthehistory@@duration_in_months 6.0)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
