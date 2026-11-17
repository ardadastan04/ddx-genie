;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_exposed_to_antithyroperoxidase_antibody_now Bool)
(declare-const patient_is_exposed_to_anti_thyroglobulin_antibody_now Bool)
(declare-const mother_of_patient_is_exposed_to_antithyroperoxidase_antibody_now Bool)
(declare-const mother_of_patient_is_exposed_to_anti_thyroglobulin_antibody_now Bool)
(declare-const patient_has_finding_of_pregoiter_now Bool)
(declare-const patient_has_finding_of_pregoiter_now@@detected_by_palpation Bool)
(declare-const patient_has_finding_of_pregoiter_now@@detected_by_thyroid_ultrasound Bool)
(declare-const patient_has_finding_of_neonatal_goiter_now Bool)
(declare-const patient_has_finding_of_neonatal_goiter_now@@detected_by_palpation Bool)
(declare-const patient_has_finding_of_neonatal_goiter_now@@detected_by_thyroid_ultrasound Bool)
(declare-const patient_has_finding_of_pregoiter_in_prenatal_period Bool)
(declare-const patient_has_finding_of_pregoiter_in_prenatal_period@@detected_by_palpation Bool)
(declare-const patient_has_finding_of_pregoiter_in_prenatal_period@@detected_by_thyroid_ultrasound Bool)
(declare-const patient_has_finding_of_neonatal_goiter_in_neonatal_period Bool)
(declare-const patient_has_finding_of_neonatal_goiter_in_neonatal_period@@detected_by_palpation Bool)
(declare-const patient_has_finding_of_neonatal_goiter_in_neonatal_period@@detected_by_thyroid_ultrasound Bool)
(declare-const patient_has_positive_perchlorate_test_now Bool)
(declare-const salting_rate_of_iodine_value_recorded_2_hours_after_perchlorate_injection_withunit_percent Real)
(declare-const patient_is_of_foreign_origin Bool)
(declare-const patient_has_returned_to_country_of_origin Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_pregoiter_now@@detected_by_palpation patient_has_finding_of_pregoiter_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_pregoiter_now@@detected_by_thyroid_ultrasound patient_has_finding_of_pregoiter_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_neonatal_goiter_now@@detected_by_palpation patient_has_finding_of_neonatal_goiter_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_finding_of_neonatal_goiter_now@@detected_by_thyroid_ultrasound patient_has_finding_of_neonatal_goiter_now) :named REQ1_AUXILIARY3))
(assert (! (=> patient_has_finding_of_pregoiter_in_prenatal_period@@detected_by_palpation patient_has_finding_of_pregoiter_in_prenatal_period) :named REQ1_AUXILIARY4))
(assert (! (=> patient_has_finding_of_pregoiter_in_prenatal_period@@detected_by_thyroid_ultrasound patient_has_finding_of_pregoiter_in_prenatal_period) :named REQ1_AUXILIARY5))
(assert (! (=> patient_has_finding_of_neonatal_goiter_in_neonatal_period@@detected_by_palpation patient_has_finding_of_neonatal_goiter_in_neonatal_period) :named REQ1_AUXILIARY6))
(assert (! (=> patient_has_finding_of_neonatal_goiter_in_neonatal_period@@detected_by_thyroid_ultrasound patient_has_finding_of_neonatal_goiter_in_neonatal_period) :named REQ1_AUXILIARY7))
(assert (! (= patient_has_positive_perchlorate_test_now (> salting_rate_of_iodine_value_recorded_2_hours_after_perchlorate_injection_withunit_percent 10)) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not (or patient_is_exposed_to_antithyroperoxidase_antibody_now patient_is_exposed_to_anti_thyroglobulin_antibody_now)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or mother_of_patient_is_exposed_to_antithyroperoxidase_antibody_now mother_of_patient_is_exposed_to_anti_thyroglobulin_antibody_now)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_pregoiter_in_prenatal_period@@detected_by_palpation) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_neonatal_goiter_in_neonatal_period@@detected_by_palpation) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_pregoiter_in_prenatal_period@@detected_by_thyroid_ultrasound) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_neonatal_goiter_in_neonatal_period@@detected_by_thyroid_ultrasound) :named REQ1_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_positive_perchlorate_test_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_of_foreign_origin patient_has_returned_to_country_of_origin)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
