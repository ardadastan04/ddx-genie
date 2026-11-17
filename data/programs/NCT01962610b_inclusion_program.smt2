;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_seen_in_emergency_department_at_icahn_school_of_medicine_at_mount_sinai_now Bool)
(declare-const patient_has_finding_of_severe_pain_now Bool)
(declare-const patient_pain_score_value_recorded_now_withunit_none Real)
(declare-const patient_pain_score_value_recorded_now_withunit_none@@measured_on_verbal_pain_scale_0_to_10 Bool)
(declare-const patient_verbal_rating_scale_pain_intensity_score_value_recorded_now_withunit_none Real)
(declare-const patient_verbal_rating_scale_pain_intensity_score_value_recorded_now_withunit_none@@scale_range_0_to_10 Bool)
(declare-const patient_has_finding_of_abdominal_pain_now Bool)
(declare-const patient_has_finding_of_abdominal_pain_now@@is_chief_complaint Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_severe_pain_now (or (and patient_pain_score_value_recorded_now_withunit_none@@measured_on_verbal_pain_scale_0_to_10 (>= patient_pain_score_value_recorded_now_withunit_none 10)) (and patient_verbal_rating_scale_pain_intensity_score_value_recorded_now_withunit_none@@scale_range_0_to_10 (>= patient_verbal_rating_scale_pain_intensity_score_value_recorded_now_withunit_none 10)))) :named REQ1_AUXILIARY0))
(assert (! (=> patient_pain_score_value_recorded_now_withunit_none@@measured_on_verbal_pain_scale_0_to_10 (>= patient_pain_score_value_recorded_now_withunit_none 0)) :named REQ1_AUXILIARY1))
(assert (! (=> patient_verbal_rating_scale_pain_intensity_score_value_recorded_now_withunit_none@@scale_range_0_to_10 (>= patient_verbal_rating_scale_pain_intensity_score_value_recorded_now_withunit_none 0)) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_finding_of_abdominal_pain_now@@is_chief_complaint patient_has_finding_of_abdominal_pain_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 20.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_seen_in_emergency_department_at_icahn_school_of_medicine_at_mount_sinai_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_severe_pain_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_abdominal_pain_now@@is_chief_complaint :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
