;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_parkinsonism_now Bool)
(declare-const patient_has_diagnosis_of_parkinsonism_now@@meets_gelb_criteria Bool)
(declare-const patient_has_another_neurodegenerative_disease_meeting_appendix_2_now Bool)
(declare-const patient_has_diagnosis_of_alzheimer_s_disease_now Bool)
(declare-const patient_has_diagnosis_of_amyotrophic_lateral_sclerosis_now Bool)
(declare-const patient_has_diagnosis_of_restless_legs_syndrome_now Bool)
(declare-const patient_has_diagnosis_of_parkinsonism_now@@meets_criteria_set_out_in_appendix_2 Bool)
(declare-const patient_has_diagnosis_of_synucleinopathy_now@@meets_criteria_set_out_in_appendix_2 Bool)
(declare-const patient_has_diagnosis_of_dementia_due_to_lewy_body_disease_now Bool)
(declare-const patient_has_diagnosis_of_dementia_associated_with_parkinson_s_disease_now Bool)
(declare-const patient_has_diagnosis_of_multiple_system_atrophy_now Bool)
(declare-const patient_has_diagnosis_of_progressive_supranuclear_palsy_now Bool)
(declare-const patient_has_diagnosis_of_synucleinopathy_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_parkinsonism_now@@meets_gelb_criteria patient_has_diagnosis_of_parkinsonism_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_another_neurodegenerative_disease_meeting_appendix_2_now (or patient_has_diagnosis_of_parkinsonism_now@@meets_criteria_set_out_in_appendix_2 patient_has_diagnosis_of_synucleinopathy_now@@meets_criteria_set_out_in_appendix_2 patient_has_diagnosis_of_dementia_due_to_lewy_body_disease_now patient_has_diagnosis_of_dementia_associated_with_parkinson_s_disease_now patient_has_diagnosis_of_multiple_system_atrophy_now patient_has_diagnosis_of_progressive_supranuclear_palsy_now)) :named REQ1_AUXILIARY0))
(assert (! (=> (or patient_has_diagnosis_of_parkinsonism_now@@meets_criteria_set_out_in_appendix_2 patient_has_diagnosis_of_synucleinopathy_now@@meets_criteria_set_out_in_appendix_2) patient_has_another_neurodegenerative_disease_meeting_appendix_2_now) :named REQ1_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_parkinsonism_now@@meets_criteria_set_out_in_appendix_2 patient_has_diagnosis_of_parkinsonism_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_diagnosis_of_synucleinopathy_now@@meets_criteria_set_out_in_appendix_2 patient_has_diagnosis_of_synucleinopathy_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_parkinsonism_now@@meets_gelb_criteria :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_another_neurodegenerative_disease_meeting_appendix_2_now patient_has_diagnosis_of_amyotrophic_lateral_sclerosis_now patient_has_diagnosis_of_restless_legs_syndrome_now patient_has_diagnosis_of_alzheimer_s_disease_now) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
