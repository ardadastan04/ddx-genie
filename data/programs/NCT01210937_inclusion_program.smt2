;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=6 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_carotid_artery_stenosis_now@@detectable_by_duplex_ultrasound Bool)
(declare-const patient_has_finding_of_carotid_artery_stenosis_inthehistory@@no_prior_procedure_done_on_stenosis Bool)
(declare-const patient_has_finding_of_carotid_artery_stenosis_now@@might_well_need_procedural_treatment_now Bool)
(declare-const patient_needs_to_undergo_carotid_endarterectomy_now Bool)
(declare-const patient_needs_to_undergo_insertion_of_carotid_artery_stent_now Bool)
(declare-const patient_has_undergone_medical_therapy_now Bool)
(declare-const patient_has_undergone_statin_prophylaxis_now Bool)
(declare-const patient_has_undergone_aspirin_therapy_now Bool)
(declare-const patient_has_undergone_coronary_artery_bypass_graft_now Bool)
(declare-const patient_has_undergone_coronary_artery_bypass_graft_now@@already_recovered_from_procedure Bool)
(declare-const patient_has_undergone_follow_up_visit_inthefuture1months@@in_person Bool)
(declare-const patient_has_finding_of_follow_up_status_inthefuture5years@@by_annual_letter Bool)
(declare-const patient_has_finding_of_follow_up_status_inthefuture5years@@willing Bool)
(declare-const patient_has_undergone_angiography_inthehistory Bool)
(declare-const patient_has_undergone_ct_angiography_inthehistory Bool)
(declare-const patient_has_undergone_magnetic_resonance_imaging_mri_of_vessels_inthehistory Bool)
(declare-const angiography_has_shown_carotid_endarterectomy_is_indicated Bool)
(declare-const patient_has_undergone_follow_up_visit_inthefuture1months Bool)
(declare-const patient_has_finding_of_follow_up_status_inthefuture5years Bool)
(declare-const patient_has_finding_of_carotid_artery_stenosis_inthehistory Bool)
(declare-const patient_has_finding_of_carotid_artery_stenosis_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_carotid_artery_stenosis_now@@might_well_need_procedural_treatment_now (or patient_needs_to_undergo_carotid_endarterectomy_now patient_needs_to_undergo_insertion_of_carotid_artery_stent_now)) :named REQ0_AUXILIARY0))
(assert (! (=> (or patient_has_undergone_statin_prophylaxis_now patient_has_undergone_aspirin_therapy_now) patient_has_undergone_medical_therapy_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_undergone_coronary_artery_bypass_graft_now@@already_recovered_from_procedure patient_has_undergone_coronary_artery_bypass_graft_now) :named REQ1_AUXILIARY1))
(assert (! (=> (or patient_has_undergone_ct_angiography_inthehistory patient_has_undergone_magnetic_resonance_imaging_mri_of_vessels_inthehistory) patient_has_undergone_angiography_inthehistory) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_carotid_artery_stenosis_inthehistory@@no_prior_procedure_done_on_stenosis patient_has_finding_of_carotid_artery_stenosis_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_carotid_artery_stenosis_now@@detectable_by_duplex_ultrasound patient_has_finding_of_carotid_artery_stenosis_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_carotid_artery_stenosis_now@@might_well_need_procedural_treatment_now patient_has_finding_of_carotid_artery_stenosis_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_finding_of_follow_up_status_inthefuture5years@@by_annual_letter patient_has_finding_of_follow_up_status_inthefuture5years) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_has_finding_of_follow_up_status_inthefuture5years@@willing patient_has_finding_of_follow_up_status_inthefuture5years) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))
(assert (! (=> patient_has_undergone_follow_up_visit_inthefuture1months@@in_person patient_has_undergone_follow_up_visit_inthefuture1months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_5))

;; Other kept assertions
(assert (! patient_has_finding_of_carotid_artery_stenosis_now@@detectable_by_duplex_ultrasound :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_carotid_artery_stenosis_inthehistory@@no_prior_procedure_done_on_stenosis :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_carotid_artery_stenosis_now@@might_well_need_procedural_treatment_now :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_follow_up_visit_inthefuture1months@@in_person :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_finding_of_follow_up_status_inthefuture5years@@by_annual_letter patient_has_finding_of_follow_up_status_inthefuture5years@@willing) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_angiography_inthehistory :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! angiography_has_shown_carotid_endarterectomy_is_indicated :named REQ3_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
