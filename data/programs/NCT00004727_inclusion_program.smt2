;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=6 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_african_american Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_cerebral_infarction_now Bool)
(declare-const patient_has_finding_of_cerebral_infarction_now@@non_cardioembolic Bool)
(declare-const patient_entry_stroke_is_cerebral_infarction Bool)
(declare-const patient_entry_stroke_is_cerebral_infarction@@non_cardioembolic Bool)
(declare-const patient_cerebrovascular_accident_onset_time_value_recorded_inthehistory_withunit_days Real)
(declare-const patient_has_undergone_computerized_axial_tomography_inthehistory@@performed_following_entry_stroke Bool)
(declare-const patient_has_undergone_computerized_axial_tomography_inthehistory@@results_consistent_with_occurrence_of_entry_stroke Bool)
(declare-const patient_has_undergone_computerized_axial_tomography_inthehistory@@results_show_entry_cerebral_infarction_or_old_cerebral_infarction_or_no_cerebral_infarction Bool)
(declare-const patient_has_undergone_magnetic_resonance_imaging_inthehistory@@performed_following_entry_stroke Bool)
(declare-const patient_has_undergone_magnetic_resonance_imaging_inthehistory@@results_consistent_with_occurrence_of_entry_stroke Bool)
(declare-const patient_has_undergone_magnetic_resonance_imaging_inthehistory@@results_show_entry_cerebral_infarction_or_old_cerebral_infarction_or_no_cerebral_infarction Bool)
(declare-const patient_has_measurable_neurologic_deficit_now Bool)
(declare-const patient_has_measurable_neurologic_deficit_now@@correlates_with_onset_of_entry_stroke Bool)
(declare-const patient_has_undergone_computerized_axial_tomography_inthehistory Bool)
(declare-const patient_has_undergone_magnetic_resonance_imaging_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_cerebral_infarction_now@@non_cardioembolic patient_has_finding_of_cerebral_infarction_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_entry_stroke_is_cerebral_infarction@@non_cardioembolic patient_entry_stroke_is_cerebral_infarction) :named REQ2_AUXILIARY1))
(assert (! (= patient_has_undergone_computerized_axial_tomography_inthehistory@@results_consistent_with_occurrence_of_entry_stroke patient_has_undergone_computerized_axial_tomography_inthehistory@@results_show_entry_cerebral_infarction_or_old_cerebral_infarction_or_no_cerebral_infarction) :named REQ4_AUXILIARY0))
(assert (! (= patient_has_undergone_magnetic_resonance_imaging_inthehistory@@results_consistent_with_occurrence_of_entry_stroke patient_has_undergone_magnetic_resonance_imaging_inthehistory@@results_show_entry_cerebral_infarction_or_old_cerebral_infarction_or_no_cerebral_infarction) :named REQ4_AUXILIARY1))
(assert (! (=> patient_has_measurable_neurologic_deficit_now@@correlates_with_onset_of_entry_stroke patient_has_measurable_neurologic_deficit_now) :named REQ5_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_computerized_axial_tomography_inthehistory@@performed_following_entry_stroke patient_has_undergone_computerized_axial_tomography_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_undergone_computerized_axial_tomography_inthehistory@@results_consistent_with_occurrence_of_entry_stroke patient_has_undergone_computerized_axial_tomography_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_undergone_computerized_axial_tomography_inthehistory@@results_show_entry_cerebral_infarction_or_old_cerebral_infarction_or_no_cerebral_infarction patient_has_undergone_computerized_axial_tomography_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_undergone_magnetic_resonance_imaging_inthehistory@@performed_following_entry_stroke patient_has_undergone_magnetic_resonance_imaging_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_has_undergone_magnetic_resonance_imaging_inthehistory@@results_consistent_with_occurrence_of_entry_stroke patient_has_undergone_magnetic_resonance_imaging_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))
(assert (! (=> patient_has_undergone_magnetic_resonance_imaging_inthehistory@@results_show_entry_cerebral_infarction_or_old_cerebral_infarction_or_no_cerebral_infarction patient_has_undergone_magnetic_resonance_imaging_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_5))

;; Other kept assertions
(assert (! patient_is_african_american :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 29) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 85) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_entry_stroke_is_cerebral_infarction@@non_cardioembolic :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_cerebrovascular_accident_onset_time_value_recorded_inthehistory_withunit_days 7.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_cerebrovascular_accident_onset_time_value_recorded_inthehistory_withunit_days 90.0) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or (and patient_has_undergone_computerized_axial_tomography_inthehistory@@performed_following_entry_stroke patient_has_undergone_computerized_axial_tomography_inthehistory@@results_consistent_with_occurrence_of_entry_stroke) (and patient_has_undergone_magnetic_resonance_imaging_inthehistory@@performed_following_entry_stroke patient_has_undergone_magnetic_resonance_imaging_inthehistory@@results_consistent_with_occurrence_of_entry_stroke)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_measurable_neurologic_deficit_now@@correlates_with_onset_of_entry_stroke :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
