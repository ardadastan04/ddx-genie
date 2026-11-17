;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_short_stature_by_small_for_gestational_age_now Bool)
(declare-const patient_has_finding_of_short_stature_now Bool)
(declare-const patient_body_height_measure_value_recorded_inthehistory_withunit_cm Real)
(declare-const patient_body_height_measure_value_recorded_inthehistory_withunit_cm@@official_record Bool)
(declare-const patient_body_height_measure_value_recorded_inthehistory_withunit_cm@@temporalcontext_at_least_6_months_prior_to_screening Bool)
(declare-const patient_has_official_height_record_at_least_6_months_prior_to_screening Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_short_stature_by_small_for_gestational_age_now patient_has_finding_of_short_stature_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_official_height_record_at_least_6_months_prior_to_screening (and patient_body_height_measure_value_recorded_inthehistory_withunit_cm@@official_record patient_body_height_measure_value_recorded_inthehistory_withunit_cm@@temporalcontext_at_least_6_months_prior_to_screening)) :named REQ1_AUXILIARY0))
(assert (! (=> patient_body_height_measure_value_recorded_inthehistory_withunit_cm@@official_record (exists ((h Real)) (= h patient_body_height_measure_value_recorded_inthehistory_withunit_cm))) :named REQ1_AUXILIARY1))
(assert (! (=> patient_body_height_measure_value_recorded_inthehistory_withunit_cm@@temporalcontext_at_least_6_months_prior_to_screening (exists ((h Real)) (= h patient_body_height_measure_value_recorded_inthehistory_withunit_cm))) :named REQ1_AUXILIARY2))

;; Other kept assertions
(assert (! patient_has_finding_of_short_stature_by_small_for_gestational_age_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
