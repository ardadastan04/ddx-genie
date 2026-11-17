;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const moca_score_value_recorded_most_recent_withunit_points Real)
(declare-const patient_has_finding_of_cognitive_impairment_now Bool)
(declare-const patient_has_finding_of_cognitive_impairment_now@@measured_by_moca Bool)
(declare-const patient_has_finding_of_cognitive_impairment_now@@significant Bool)
(declare-const patient_has_finding_of_patient_s_condition_unstable_now Bool)
(declare-const patient_has_finding_of_unstable_psychiatric_condition_now Bool)
(declare-const patient_has_finding_of_hallucinations_now Bool)
(declare-const patient_is_exposed_to_dopamine_receptor_blocking_medications_now Bool)
(declare-const patient_is_exposed_to_neuroleptic_medications_now Bool)
(declare-const patient_is_exposed_to_antiemetic_medications_now Bool)
(declare-const patient_is_exposed_to_tetrabenazine_now Bool)
(declare-const patient_has_finding_of_patient_s_condition_unstable_inthehistory Bool)
(declare-const patient_has_finding_of_disorder_of_cardiovascular_system_now Bool)
(declare-const patient_has_finding_of_disorder_of_cardiovascular_system_now@@active Bool)
(declare-const patient_has_finding_of_malaise_inthehistory Bool)
(declare-const patient_has_finding_of_malaise_inthehistory@@recent Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory@@recent Bool)
(declare-const patient_is_exposed_to_anticoagulant_now Bool)
(declare-const patient_has_finding_of_harmful_pattern_of_substance_use_now Bool)
(declare-const patient_has_finding_of_amantadine_adverse_reaction_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_cognitive_impairment_now@@significant (and patient_has_finding_of_cognitive_impairment_now patient_has_finding_of_cognitive_impairment_now@@measured_by_moca (< moca_score_value_recorded_most_recent_withunit_points 25))) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_cognitive_impairment_now@@significant patient_has_finding_of_cognitive_impairment_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_cognitive_impairment_now@@measured_by_moca patient_has_finding_of_cognitive_impairment_now) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_finding_of_hallucinations_now patient_has_finding_of_unstable_psychiatric_condition_now) :named REQ1_AUXILIARY0))
(assert (! (=> (or patient_is_exposed_to_neuroleptic_medications_now patient_is_exposed_to_antiemetic_medications_now patient_is_exposed_to_tetrabenazine_now) patient_is_exposed_to_dopamine_receptor_blocking_medications_now) :named REQ2_AUXILIARY0))
(assert (! (=> (or patient_has_finding_of_disorder_of_cardiovascular_system_now@@active patient_has_finding_of_malaise_inthehistory@@recent patient_has_undergone_surgical_procedure_inthehistory@@recent) patient_has_finding_of_patient_s_condition_unstable_inthehistory) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disorder_of_cardiovascular_system_now@@active patient_has_finding_of_disorder_of_cardiovascular_system_now) :named REQ3_AUXILIARY1))
(assert (! (=> patient_has_finding_of_malaise_inthehistory@@recent patient_has_finding_of_malaise_inthehistory) :named REQ3_AUXILIARY2))
(assert (! (=> patient_has_undergone_surgical_procedure_inthehistory@@recent patient_has_undergone_surgical_procedure_inthehistory) :named REQ3_AUXILIARY3))

;; Other kept assertions
(assert (! (not patient_has_finding_of_cognitive_impairment_now@@significant) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_patient_s_condition_unstable_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_unstable_psychiatric_condition_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_dopamine_receptor_blocking_medications_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_patient_s_condition_unstable_inthehistory) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_anticoagulant_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_harmful_pattern_of_substance_use_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_amantadine_adverse_reaction_inthehistory) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
