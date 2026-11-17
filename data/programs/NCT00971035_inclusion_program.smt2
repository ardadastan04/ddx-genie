;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_body_weight_value_recorded_now_withunit_kilograms Real)
(declare-const patient_has_undergone_plain_x_ray_of_chest_inthehistory Bool)
(declare-const patient_has_undergone_plain_x_ray_of_chest_inthehistory@@outcome_is_no_evidence_of_clinically_significant_abnormality Bool)
(declare-const patient_has_undergone_plain_x_ray_of_chest_inthepast12months Bool)
(declare-const patient_has_undergone_plain_x_ray_of_chest_inthepast12months@@temporalcontext_within12months_of_visit_1 Bool)
(declare-const patient_has_finding_of_uncomplicated_asthma_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_plain_x_ray_of_chest_inthehistory@@outcome_is_no_evidence_of_clinically_significant_abnormality patient_has_undergone_plain_x_ray_of_chest_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_undergone_plain_x_ray_of_chest_inthepast12months@@temporalcontext_within12months_of_visit_1 patient_has_undergone_plain_x_ray_of_chest_inthepast12months) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! (>= patient_body_weight_value_recorded_now_withunit_kilograms 50.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_body_weight_value_recorded_now_withunit_kilograms 150.0) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_plain_x_ray_of_chest_inthehistory@@outcome_is_no_evidence_of_clinically_significant_abnormality :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_uncomplicated_asthma_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
