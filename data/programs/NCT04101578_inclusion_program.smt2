;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_myasthenia_gravis_now Bool)
(declare-const patient_is_exposed_to_pyridostigmine_now@@unequivocal_clinical_response Bool)
(declare-const patient_has_undergone_procedure_to_identify_antibody_now_outcome_is_positive Bool)
(declare-const patient_repetitive_nerve_stimulation_value_recorded_now_withunit_percent Real)
(declare-const patient_has_decrement_gt_10_percent_in_repetitive_nerve_stimulation_now Bool)
(declare-const patient_has_supporting_evidence_for_mg_now Bool)
(declare-const patient_is_exposed_to_pyridostigmine_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_decrement_gt_10_percent_in_repetitive_nerve_stimulation_now (> patient_repetitive_nerve_stimulation_value_recorded_now_withunit_percent 10.0)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_supporting_evidence_for_mg_now (or patient_is_exposed_to_pyridostigmine_now@@unequivocal_clinical_response patient_has_undergone_procedure_to_identify_antibody_now_outcome_is_positive patient_has_decrement_gt_10_percent_in_repetitive_nerve_stimulation_now)) :named REQ1_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_exposed_to_pyridostigmine_now@@unequivocal_clinical_response patient_is_exposed_to_pyridostigmine_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 14.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_myasthenia_gravis_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_supporting_evidence_for_mg_now :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
