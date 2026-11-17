;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_disease_of_liver_now Bool)
(declare-const patient_has_finding_of_disease_of_liver_now@@acute Bool)
(declare-const patient_has_finding_of_acute_nephropathy_now Bool)
(declare-const patient_has_finding_of_disease_of_liver_now@@acute@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_acute_nephropathy_now@@strong_clinical_support Bool)
(declare-const patient_can_undergo_tb_chemotherapy_now Bool)
(declare-const patient_can_undergo_tb_chemotherapy_now@@temporalcontext_during_time_sputum_samples_are_provided Bool)
(declare-const patient_has_condition_compromising_ability_to_take_oral_drugs_during_time_sputum_samples_are_provided Bool)
(declare-const patient_has_condition_compromising_ability_to_take_oral_drugs_during_time_sputum_samples_are_provided@@oral_drugs_are_anti_tb_or_non_tb_mycobacteria_medicines Bool)
(declare-const patient_has_condition_compromising_ability_to_absorb_oral_drugs_during_time_sputum_samples_are_provided Bool)
(declare-const patient_has_condition_compromising_ability_to_absorb_oral_drugs_during_time_sputum_samples_are_provided@@oral_drugs_are_anti_tb_or_non_tb_mycobacteria_medicines Bool)
(declare-const patient_has_condition_compromising_ability_to_take_oral_drugs_during_time_sputum_samples_are_provided@@strong_clinical_support Bool)
(declare-const patient_has_condition_compromising_ability_to_absorb_oral_drugs_during_time_sputum_samples_are_provided@@strong_clinical_support Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_disease_of_liver_now@@acute patient_has_finding_of_disease_of_liver_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disease_of_liver_now@@acute@@strong_clinical_support patient_has_finding_of_disease_of_liver_now@@acute) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_acute_nephropathy_now@@strong_clinical_support patient_has_finding_of_acute_nephropathy_now) :named REQ0_AUXILIARY2))
(assert (! (=> patient_can_undergo_tb_chemotherapy_now@@temporalcontext_during_time_sputum_samples_are_provided patient_can_undergo_tb_chemotherapy_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_condition_compromising_ability_to_take_oral_drugs_during_time_sputum_samples_are_provided@@oral_drugs_are_anti_tb_or_non_tb_mycobacteria_medicines patient_has_condition_compromising_ability_to_take_oral_drugs_during_time_sputum_samples_are_provided) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_condition_compromising_ability_to_absorb_oral_drugs_during_time_sputum_samples_are_provided@@oral_drugs_are_anti_tb_or_non_tb_mycobacteria_medicines patient_has_condition_compromising_ability_to_absorb_oral_drugs_during_time_sputum_samples_are_provided) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_condition_compromising_ability_to_take_oral_drugs_during_time_sputum_samples_are_provided@@strong_clinical_support patient_has_condition_compromising_ability_to_take_oral_drugs_during_time_sputum_samples_are_provided) :named REQ1_AUXILIARY3))
(assert (! (=> patient_has_condition_compromising_ability_to_absorb_oral_drugs_during_time_sputum_samples_are_provided@@strong_clinical_support patient_has_condition_compromising_ability_to_absorb_oral_drugs_during_time_sputum_samples_are_provided) :named REQ1_AUXILIARY4))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_disease_of_liver_now@@acute@@strong_clinical_support patient_has_finding_of_disease_of_liver_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not (or patient_has_finding_of_disease_of_liver_now@@acute patient_has_finding_of_acute_nephropathy_now)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_condition_compromising_ability_to_take_oral_drugs_during_time_sputum_samples_are_provided) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_condition_compromising_ability_to_absorb_oral_drugs_during_time_sputum_samples_are_provided) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
