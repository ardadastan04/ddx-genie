;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_has_finding_of_hemoglobin_ss_disease_with_crisis_now Bool)
(declare-const patient_has_finding_of_hemoglobin_ss_disease_with_crisis_now@@present_at_time_of_admission_from_emergency_department Bool)
(declare-const patient_has_finding_of_myocardial_infarction_now Bool)
(declare-const patient_has_finding_of_myocardial_infarction_now@@concomitant_at_time_of_presentation Bool)
(declare-const patient_has_finding_of_cerebrovascular_accident_now Bool)
(declare-const patient_has_finding_of_cerebrovascular_accident_now@@concomitant_at_time_of_presentation Bool)
(declare-const patient_has_finding_of_acute_chest_syndrome_now Bool)
(declare-const patient_has_finding_of_acute_chest_syndrome_now@@concomitant_at_time_of_presentation Bool)
(declare-const patient_has_finding_of_complicated_sickle_cell_crisis_now@@present_at_time_of_admission_from_emergency_department Bool)
(declare-const patient_has_finding_of_complicated_sickle_cell_crisis_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_hemoglobin_ss_disease_with_crisis_now@@present_at_time_of_admission_from_emergency_department patient_has_finding_of_hemoglobin_ss_disease_with_crisis_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_myocardial_infarction_now@@concomitant_at_time_of_presentation patient_has_finding_of_myocardial_infarction_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_finding_of_cerebrovascular_accident_now@@concomitant_at_time_of_presentation patient_has_finding_of_cerebrovascular_accident_now) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_finding_of_acute_chest_syndrome_now@@concomitant_at_time_of_presentation patient_has_finding_of_acute_chest_syndrome_now) :named REQ2_AUXILIARY3))
(assert (! (=> (or patient_has_finding_of_myocardial_infarction_now@@concomitant_at_time_of_presentation patient_has_finding_of_cerebrovascular_accident_now@@concomitant_at_time_of_presentation patient_has_finding_of_acute_chest_syndrome_now@@concomitant_at_time_of_presentation) patient_has_finding_of_complicated_sickle_cell_crisis_now@@present_at_time_of_admission_from_emergency_department) :named REQ2_AUXILIARY4))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_complicated_sickle_cell_crisis_now@@present_at_time_of_admission_from_emergency_department patient_has_finding_of_complicated_sickle_cell_crisis_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 19)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_pregnant_now patient_sex_is_female_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_complicated_sickle_cell_crisis_now@@present_at_time_of_admission_from_emergency_department) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
