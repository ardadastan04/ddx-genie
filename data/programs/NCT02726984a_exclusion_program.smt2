;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_modified_rankin_scale_score_value_recorded_now_withunit_none Real)
(declare-const patient_can_undergo_magnetic_resonance_imaging_now Bool)
(declare-const patient_has_contraindication_to_magnetic_resonance_imaging_now Bool)
(declare-const patient_has_diagnosis_of_renal_failure_syndrome_now Bool)
(declare-const patient_has_undergone_measurement_of_renal_clearance_of_creatinine_now Bool)
(declare-const patient_has_undergone_measurement_of_renal_clearance_of_creatinine_now@@measured_by_cockcroft Bool)
(declare-const creatinine_clearance_value_recorded_now_withunit_ml_per_min Real)
(declare-const patient_has_finding_of_breastfed_now Bool)
(declare-const patient_is_breastfeeding_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_finding_of_adverse_reaction_to_active_substance_now Bool)
(declare-const patient_has_finding_of_adverse_reaction_to_pharmaceutical_excipient_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_contraindication_to_magnetic_resonance_imaging_now (not patient_can_undergo_magnetic_resonance_imaging_now)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_diagnosis_of_renal_failure_syndrome_now (and patient_has_undergone_measurement_of_renal_clearance_of_creatinine_now@@measured_by_cockcroft (< creatinine_clearance_value_recorded_now_withunit_ml_per_min 50))) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_undergone_measurement_of_renal_clearance_of_creatinine_now@@measured_by_cockcroft patient_has_undergone_measurement_of_renal_clearance_of_creatinine_now) :named REQ2_AUXILIARY1))
(assert (! (= patient_has_finding_of_breastfed_now patient_is_breastfeeding_now) :named REQ3_AUXILIARY0))

;; Other kept assertions
(assert (! (not (> patient_modified_rankin_scale_score_value_recorded_now_withunit_none 3)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_magnetic_resonance_imaging_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_renal_failure_syndrome_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_breastfeeding_now) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_adverse_reaction_to_active_substance_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_adverse_reaction_to_pharmaceutical_excipient_now) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
