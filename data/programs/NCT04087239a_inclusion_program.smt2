;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_consented_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_is_of_bantu_origin Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const gestational_age_value_recorded_at_enrolment_in_weeks Real)
(declare-const patient_is_planning_to_deliver_at_kuwadzana_study_site Bool)
(declare-const patient_is_planning_to_deliver_at_rujeko_study_site Bool)
(declare-const patient_is_planning_to_deliver_at_glenview_study_site Bool)
(declare-const patient_is_planning_to_deliver_at_budiriro_study_site Bool)

;; Other kept assertions
(assert (! (and patient_is_consented_now patient_is_pregnant_now patient_sex_is_female_now patient_is_of_bantu_origin) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 15) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= gestational_age_value_recorded_at_enrolment_in_weeks 20) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (or patient_is_planning_to_deliver_at_kuwadzana_study_site patient_is_planning_to_deliver_at_rujeko_study_site patient_is_planning_to_deliver_at_glenview_study_site patient_is_planning_to_deliver_at_budiriro_study_site) :named REQ0_COMPONENT3_OTHER_REQUIREMENTS))
