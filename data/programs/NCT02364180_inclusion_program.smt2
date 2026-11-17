;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_exposed_to_pyridostigmine_now@@for_treatment_of_any_condition_other_than_myasthenia_gravis Bool)
(declare-const patient_is_exposed_to_pyridostigmine_now@@for_treatment_of_myasthenia_gravis Bool)
(declare-const patient_is_exposed_to_pyridostigmine_now Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_exposed_to_pyridostigmine_now@@for_treatment_of_any_condition_other_than_myasthenia_gravis patient_is_exposed_to_pyridostigmine_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_is_exposed_to_pyridostigmine_now@@for_treatment_of_myasthenia_gravis patient_is_exposed_to_pyridostigmine_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! patient_is_exposed_to_pyridostigmine_now@@for_treatment_of_any_condition_other_than_myasthenia_gravis :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_is_exposed_to_pyridostigmine_now@@for_treatment_of_myasthenia_gravis) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
