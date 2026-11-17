;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_hypersensitivity_to_beta_lactam_inthehistory Bool)
(declare-const patient_has_finding_of_beta_lactam_adverse_reaction_inthehistory Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_breastfeeding_now Bool)
(declare-const patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_urine_cultures Bool)
(declare-const patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_urine_cultures@@except_if_prior_treatment_was_with_pivmecillinam_or_nitrofurantoin Bool)
(declare-const patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_faecal_cultures Bool)
(declare-const patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_faecal_cultures@@except_if_prior_treatment_was_with_pivmecillinam_or_nitrofurantoin Bool)
(declare-const patient_creatinine_renal_clearance_value_recorded_now_withunit_milliliters_per_minute Real)
(declare-const patient_creatinine_renal_clearance_value_recorded_now_withunit_milliliters_per_minute@@estimated_by_cockcroft_gault_equation Bool)
(declare-const patient_creatinine_renal_clearance_value_recorded_now_withunit_milliliters_per_minute@@measured_at_screening Bool)
(declare-const patient_has_diagnosis_of_chronic_renal_insufficiency_now Bool)
(declare-const patient_is_undergoing_dialysis_procedure_now Bool)
(declare-const patient_is_undergoing_dialysis_procedure_now@@intermittent Bool)
(declare-const patient_is_undergoing_peritoneal_dialysis_now Bool)
(declare-const patient_has_finding_of_carrier_of_extended_spectrum_beta_lactamase_producing_bacteria_now Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now@@would_compromise_safety_or_data_quality_investigator_opinion Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_creatinine_renal_clearance_value_recorded_now_withunit_milliliters_per_minute@@estimated_by_cockcroft_gault_equation true) :named REQ3_AUXILIARY0))
(assert (! (=> patient_creatinine_renal_clearance_value_recorded_now_withunit_milliliters_per_minute@@measured_at_screening true) :named REQ3_AUXILIARY1))
(assert (! (=> patient_is_undergoing_dialysis_procedure_now@@intermittent patient_is_undergoing_dialysis_procedure_now) :named REQ3_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_disease_condition_finding_now@@would_compromise_safety_or_data_quality_investigator_opinion patient_has_finding_of_disease_condition_finding_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_faecal_cultures@@except_if_prior_treatment_was_with_pivmecillinam_or_nitrofurantoin patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_faecal_cultures) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_urine_cultures@@except_if_prior_treatment_was_with_pivmecillinam_or_nitrofurantoin patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_urine_cultures) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! (not patient_has_hypersensitivity_to_beta_lactam_inthehistory) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_beta_lactam_adverse_reaction_inthehistory) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_breastfeeding_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_urine_cultures (not patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_urine_cultures@@except_if_prior_treatment_was_with_pivmecillinam_or_nitrofurantoin))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_faecal_cultures (not patient_has_received_potentially_therapeutic_antibacterial_agent_within_1_month_before_randomisation_and_sampling_for_faecal_cultures@@except_if_prior_treatment_was_with_pivmecillinam_or_nitrofurantoin))) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_diagnosis_of_chronic_renal_insufficiency_now (< patient_creatinine_renal_clearance_value_recorded_now_withunit_milliliters_per_minute 10) patient_creatinine_renal_clearance_value_recorded_now_withunit_milliliters_per_minute@@estimated_by_cockcroft_gault_equation patient_creatinine_renal_clearance_value_recorded_now_withunit_milliliters_per_minute@@measured_at_screening)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_dialysis_procedure_now@@intermittent) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_peritoneal_dialysis_now) :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_carrier_of_extended_spectrum_beta_lactamase_producing_bacteria_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disease_condition_finding_now@@would_compromise_safety_or_data_quality_investigator_opinion) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
