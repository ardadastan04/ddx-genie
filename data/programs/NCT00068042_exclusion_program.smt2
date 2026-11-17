;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_other_condition_now Bool)
(declare-const patient_has_other_condition_now@@may_result_in_abnormal_growth_hormone_concentration Bool)
(declare-const patient_has_other_condition_now@@may_result_in_abnormal_insulin_like_growth_factor_i_concentration Bool)
(declare-const aspartate_aminotransferase_value_recorded_now_withunit_u_per_l Real)
(declare-const upper_limit_of_normal_for_aspartate_aminotransferase_value_withunit_u_per_l Real)
(declare-const alanine_aminotransferase_value_recorded_now_withunit_u_per_l Real)
(declare-const upper_limit_of_normal_for_alanine_aminotransferase_value_withunit_u_per_l Real)
(declare-const distance_between_pituitary_adenoma_and_optic_chiasm_value_recorded_recently_in_millimeters Real)
(declare-const patient_has_finding_of_pituitary_adenoma_now Bool)
(declare-const patient_has_finding_of_pituitary_adenoma_now@@within_three_millimeters_of_optic_chiasm Bool)
(declare-const patient_has_finding_of_pituitary_adenoma_now@@confirmed_by_recent_magnetic_resonance_imaging Bool)
(declare-const patient_has_finding_of_visual_field_defect_now Bool)
(declare-const patient_has_finding_of_visual_field_defect_now@@post_surgical Bool)
(declare-const patient_has_finding_of_visual_field_defect_now@@residual Bool)
(declare-const patient_has_finding_of_visual_field_defect_now@@stable Bool)
(declare-const patient_has_finding_of_visual_field_defect_now@@post_surgical@@residual@@stable Bool)
(declare-const patient_is_able_to_self_administer_drug_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_other_condition_now@@may_result_in_abnormal_growth_hormone_concentration patient_has_other_condition_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_other_condition_now@@may_result_in_abnormal_insulin_like_growth_factor_i_concentration patient_has_other_condition_now) :named REQ0_AUXILIARY1))
(assert (! (= patient_has_finding_of_pituitary_adenoma_now@@within_three_millimeters_of_optic_chiasm (and patient_has_finding_of_pituitary_adenoma_now (<= distance_between_pituitary_adenoma_and_optic_chiasm_value_recorded_recently_in_millimeters 3))) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_pituitary_adenoma_now@@within_three_millimeters_of_optic_chiasm patient_has_finding_of_pituitary_adenoma_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_finding_of_pituitary_adenoma_now@@confirmed_by_recent_magnetic_resonance_imaging patient_has_finding_of_pituitary_adenoma_now) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_finding_of_visual_field_defect_now@@post_surgical@@residual@@stable (and patient_has_finding_of_visual_field_defect_now@@post_surgical patient_has_finding_of_visual_field_defect_now@@residual patient_has_finding_of_visual_field_defect_now@@stable)) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_visual_field_defect_now@@post_surgical@@residual@@stable patient_has_finding_of_visual_field_defect_now) :named REQ3_AUXILIARY1))
(assert (! (=> patient_has_finding_of_visual_field_defect_now@@post_surgical patient_has_finding_of_visual_field_defect_now) :named REQ3_AUXILIARY2))
(assert (! (=> patient_has_finding_of_visual_field_defect_now@@residual patient_has_finding_of_visual_field_defect_now) :named REQ3_AUXILIARY3))
(assert (! (=> patient_has_finding_of_visual_field_defect_now@@stable patient_has_finding_of_visual_field_defect_now) :named REQ3_AUXILIARY4))

;; Other kept assertions
(assert (! (not patient_has_other_condition_now@@may_result_in_abnormal_growth_hormone_concentration) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_other_condition_now@@may_result_in_abnormal_insulin_like_growth_factor_i_concentration) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (>= aspartate_aminotransferase_value_recorded_now_withunit_u_per_l (* 3 upper_limit_of_normal_for_aspartate_aminotransferase_value_withunit_u_per_l))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (>= alanine_aminotransferase_value_recorded_now_withunit_u_per_l (* 3 upper_limit_of_normal_for_alanine_aminotransferase_value_withunit_u_per_l))) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_pituitary_adenoma_now@@within_three_millimeters_of_optic_chiasm patient_has_finding_of_pituitary_adenoma_now@@confirmed_by_recent_magnetic_resonance_imaging)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_visual_field_defect_now (not patient_has_finding_of_visual_field_defect_now@@post_surgical@@residual@@stable))) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_able_to_self_administer_drug_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
