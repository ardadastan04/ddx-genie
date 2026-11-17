;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_exposed_to_levetiracetam_inthehistory Bool)
(declare-const patient_has_partial_seizures_inthehistory Bool)
(declare-const patient_has_partial_seizures_inthehistory@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_grand_mal_status_inthehistory Bool)
(declare-const patient_has_finding_of_grand_mal_status_inthehistory@@temporalcontext_within3months_before_visit_1 Bool)
(declare-const patient_has_finding_of_nonconvulsive_status_epilepticus_inthehistory Bool)
(declare-const patient_has_finding_of_nonconvulsive_status_epilepticus_inthehistory@@temporalcontext_within3months_before_visit_1 Bool)
(declare-const patient_has_finding_of_grand_mal_status_inthehistory@@temporalcontext_within3months_before_visit_1@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_nonconvulsive_status_epilepticus_inthehistory@@temporalcontext_within3months_before_visit_1@@strong_clinical_support Bool)
(declare-const patient_is_taking_vigabatrin_now Bool)
(declare-const patient_is_taking_tiagabine_now Bool)
(declare-const patient_is_taking_felbamate_now Bool)
(declare-const patient_felbamate_value_recorded_inthehistory_withunit_months Real)
(declare-const patient_is_undergoing_vagal_stimulation_now Bool)
(declare-const patient_is_taking_ketogenic_diet_now Bool)
(declare-const patient_is_taking_central_nervous_system_agent_now Bool)
(declare-const patient_is_taking_anticonvulsant_now Bool)
(declare-const patient_is_taking_anticonvulsant_now@@concomitant Bool)
(declare-const patient_is_taking_central_nervous_system_agent_now@@non_anticonvulsant Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_partial_seizures_inthehistory@@strong_clinical_support patient_has_partial_seizures_inthehistory) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_grand_mal_status_inthehistory@@temporalcontext_within3months_before_visit_1 patient_has_finding_of_grand_mal_status_inthehistory) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_nonconvulsive_status_epilepticus_inthehistory@@temporalcontext_within3months_before_visit_1 patient_has_finding_of_nonconvulsive_status_epilepticus_inthehistory) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_finding_of_grand_mal_status_inthehistory@@temporalcontext_within3months_before_visit_1@@strong_clinical_support patient_has_finding_of_grand_mal_status_inthehistory@@temporalcontext_within3months_before_visit_1) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_finding_of_nonconvulsive_status_epilepticus_inthehistory@@temporalcontext_within3months_before_visit_1@@strong_clinical_support patient_has_finding_of_nonconvulsive_status_epilepticus_inthehistory@@temporalcontext_within3months_before_visit_1) :named REQ2_AUXILIARY3))
(assert (! (=> patient_is_taking_anticonvulsant_now@@concomitant patient_is_taking_anticonvulsant_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_is_taking_central_nervous_system_agent_now@@non_anticonvulsant patient_is_taking_central_nervous_system_agent_now) :named REQ4_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_grand_mal_status_inthehistory@@temporalcontext_within3months_before_visit_1@@strong_clinical_support patient_has_finding_of_grand_mal_status_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_nonconvulsive_status_epilepticus_inthehistory@@temporalcontext_within3months_before_visit_1@@strong_clinical_support patient_has_finding_of_nonconvulsive_status_epilepticus_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not patient_is_exposed_to_levetiracetam_inthehistory) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_partial_seizures_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_grand_mal_status_inthehistory@@temporalcontext_within3months_before_visit_1) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_nonconvulsive_status_epilepticus_inthehistory@@temporalcontext_within3months_before_visit_1) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_vigabatrin_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_tiagabine_now) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_taking_felbamate_now (< patient_felbamate_value_recorded_inthehistory_withunit_months 18))) :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_vagal_stimulation_now) :named REQ3_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_ketogenic_diet_now) :named REQ3_COMPONENT4_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_central_nervous_system_agent_now@@non_anticonvulsant) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
