;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_cardiac_resynchronisation_therapy_indication_now Bool)
(declare-const patient_has_cardiac_resynchronisation_therapy_indication_now@@according_to_guidelines_and_class_i_iia Bool)
(declare-const patient_has_implantable_cardioverter_defibrillator_indication_now Bool)
(declare-const patient_has_implantable_cardioverter_defibrillator_indication_now@@according_to_guidelines_and_class_i_iia Bool)
(declare-const patient_has_undergone_automatic_defibrillator_procedure_inthehistory Bool)
(declare-const patient_has_undergone_automatic_defibrillator_procedure_inthehistory@@device_is_medtronic_marquis_family Bool)
(declare-const patient_has_undergone_cardiac_pacing_inthehistory@@is_antitachycardia Bool)
(declare-const patient_has_undergone_cardiac_pacing_inthehistory@@performed_in_right_ventricle Bool)
(declare-const patient_has_undergone_cardiac_pacing_inthehistory@@performed_in_both_ventricles Bool)
(declare-const patient_has_undergone_medtronic_marquis_family_defibrillator_implantation_with_required_pacing_capability_inthehistory Bool)
(declare-const patient_has_finding_of_chronic_atrial_fibrillation_now Bool)
(declare-const patient_has_undergone_ablation_of_atrioventricular_node_inthehistory Bool)
(declare-const patient_has_finding_of_complete_atrioventricular_block_now Bool)
(declare-const patient_has_finding_of_complete_atrioventricular_block_now@@confirmed_at_post_hospital_discharge Bool)
(declare-const patient_has_undergone_cardiac_pacing_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_cardiac_resynchronisation_therapy_indication_now@@according_to_guidelines_and_class_i_iia patient_has_cardiac_resynchronisation_therapy_indication_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_implantable_cardioverter_defibrillator_indication_now@@according_to_guidelines_and_class_i_iia patient_has_implantable_cardioverter_defibrillator_indication_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_automatic_defibrillator_procedure_inthehistory@@device_is_medtronic_marquis_family patient_has_undergone_automatic_defibrillator_procedure_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_undergone_medtronic_marquis_family_defibrillator_implantation_with_required_pacing_capability_inthehistory (and patient_has_undergone_automatic_defibrillator_procedure_inthehistory@@device_is_medtronic_marquis_family (or (and patient_has_undergone_cardiac_pacing_inthehistory@@is_antitachycardia patient_has_undergone_cardiac_pacing_inthehistory@@performed_in_right_ventricle) (and patient_has_undergone_cardiac_pacing_inthehistory@@is_antitachycardia patient_has_undergone_cardiac_pacing_inthehistory@@performed_in_both_ventricles)))) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_complete_atrioventricular_block_now@@confirmed_at_post_hospital_discharge patient_has_finding_of_complete_atrioventricular_block_now) :named REQ2_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_cardiac_pacing_inthehistory@@is_antitachycardia patient_has_undergone_cardiac_pacing_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_undergone_cardiac_pacing_inthehistory@@performed_in_both_ventricles patient_has_undergone_cardiac_pacing_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_undergone_cardiac_pacing_inthehistory@@performed_in_right_ventricle patient_has_undergone_cardiac_pacing_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! patient_has_cardiac_resynchronisation_therapy_indication_now@@according_to_guidelines_and_class_i_iia :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_implantable_cardioverter_defibrillator_indication_now@@according_to_guidelines_and_class_i_iia :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_medtronic_marquis_family_defibrillator_implantation_with_required_pacing_capability_inthehistory :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_chronic_atrial_fibrillation_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_ablation_of_atrioventricular_node_inthehistory :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_complete_atrioventricular_block_now@@confirmed_at_post_hospital_discharge :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
