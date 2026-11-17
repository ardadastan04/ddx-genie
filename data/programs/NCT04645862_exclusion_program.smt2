;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_pregnant_now_by_point_of_care_urine_pregnancy_test Bool)
(declare-const patient_glomerular_filtration_rate_value_recorded_now_withunit_milliliters_per_minute_per_1_73_square_meters Real)
(declare-const patient_has_finding_of_renal_failure_syndrome_now Bool)
(declare-const patient_has_contraindication_to_intravenous_contrast_now Bool)
(declare-const patient_has_finding_of_allergy_to_contrast_media_inthehistory Bool)
(declare-const patient_has_finding_of_allergy_to_contrast_media_inthehistory@@is_documented Bool)
(declare-const patient_is_undergoing_computed_tomography_now Bool)
(declare-const patient_is_undergoing_computed_tomography_now@@with_steroid_preparation Bool)
(declare-const patient_is_undergoing_computed_tomography_now@@as_part_of_routine_clinical_care Bool)
(declare-const patient_has_undergone_replacement_of_aortic_valve_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_pregnant_now_by_point_of_care_urine_pregnancy_test patient_is_pregnant_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_finding_of_renal_failure_syndrome_now (< patient_glomerular_filtration_rate_value_recorded_now_withunit_milliliters_per_minute_per_1_73_square_meters 30)) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_allergy_to_contrast_media_inthehistory@@is_documented patient_has_finding_of_allergy_to_contrast_media_inthehistory) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_undergoing_computed_tomography_now@@with_steroid_preparation patient_is_undergoing_computed_tomography_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_is_undergoing_computed_tomography_now@@as_part_of_routine_clinical_care patient_is_undergoing_computed_tomography_now) :named REQ2_AUXILIARY2))

;; Other kept assertions
(assert (! (not patient_is_pregnant_now_by_point_of_care_urine_pregnancy_test) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_renal_failure_syndrome_now patient_has_contraindication_to_intravenous_contrast_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_allergy_to_contrast_media_inthehistory@@is_documented (not (and patient_is_undergoing_computed_tomography_now@@with_steroid_preparation patient_is_undergoing_computed_tomography_now@@as_part_of_routine_clinical_care)))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_replacement_of_aortic_valve_inthehistory) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
