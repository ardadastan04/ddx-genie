;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_antithyroperoxidase_antibody_value_recorded_now_withunit_iu_per_ml Real)
(declare-const patient_anti_thyroglobulin_antibody_value_recorded_now_withunit_iu_per_ml Real)
(declare-const patient_has_positive_titer_of_antithyroperoxidase_antibodies_now Bool)
(declare-const patient_has_positive_titer_of_antithyroglobulin_antibodies_now Bool)
(declare-const patient_has_finding_of_imaging_of_thyroid_gland_abnormal_now Bool)
(declare-const patient_has_finding_of_imaging_of_thyroid_gland_abnormal_now@@detected_by_ultrasound Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_positive_titer_of_antithyroperoxidase_antibodies_now (> patient_antithyroperoxidase_antibody_value_recorded_now_withunit_iu_per_ml 60.0)) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_positive_titer_of_antithyroglobulin_antibodies_now (> patient_anti_thyroglobulin_antibody_value_recorded_now_withunit_iu_per_ml 60.0)) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_imaging_of_thyroid_gland_abnormal_now@@detected_by_ultrasound patient_has_finding_of_imaging_of_thyroid_gland_abnormal_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (or patient_has_positive_titer_of_antithyroperoxidase_antibodies_now patient_has_positive_titer_of_antithyroglobulin_antibodies_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_imaging_of_thyroid_gland_abnormal_now@@detected_by_ultrasound :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
