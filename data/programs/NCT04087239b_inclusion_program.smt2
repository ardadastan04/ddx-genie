;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_consented_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_is_of_bantu_origin Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const gestational_age_value_recorded_at_enrolment_in_weeks Real)
(declare-const patient_is_planning_to_deliver_at_study_site Bool)
(declare-const patient_is_planning_to_deliver_at_study_site@@site_is_kuwadzana_rujeko_glenview_or_budiriro Bool)
(declare-const patient_is_willing_to_provide_biological_specimens_in_follow_up_visits_for_two_years Bool)
(declare-const patient_is_exposed_to_biological_substance_now@@provided_in_follow_up_visits_for_two_years Bool)
(declare-const patient_is_exposed_to_biological_substance_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_planning_to_deliver_at_study_site patient_is_planning_to_deliver_at_study_site@@site_is_kuwadzana_rujeko_glenview_or_budiriro) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_willing_to_provide_biological_specimens_in_follow_up_visits_for_two_years patient_is_exposed_to_biological_substance_now@@provided_in_follow_up_visits_for_two_years) :named REQ1_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_exposed_to_biological_substance_now@@provided_in_follow_up_visits_for_two_years patient_is_exposed_to_biological_substance_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_is_planning_to_deliver_at_study_site@@site_is_kuwadzana_rujeko_glenview_or_budiriro patient_is_planning_to_deliver_at_study_site) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (and patient_is_consented_now patient_is_pregnant_now patient_sex_is_female_now patient_is_of_bantu_origin) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 15) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (>= gestational_age_value_recorded_at_enrolment_in_weeks 20) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_is_planning_to_deliver_at_study_site :named REQ0_COMPONENT3_OTHER_REQUIREMENTS))
