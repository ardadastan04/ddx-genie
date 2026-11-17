;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_currently_using_compliance_aid Bool)
(declare-const patient_has_finding_of_medication_compliance_now@@study_participation_would_be_detrimental_to_adherence Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_breastfeeding_now Bool)
(declare-const patient_has_finding_of_breast_fed_now Bool)
(declare-const patient_alcohol_containing_product_value_recorded_now_withunit_unit_per_week Real)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_assessment_using_mini_mental_state_examination_value_recorded_now_withunit_score Real)
(declare-const patient_geriatric_depression_score_value_recorded_now_withunit_none Real)
(declare-const patient_has_finding_of_severe_depression_now Bool)
(declare-const patient_has_finding_of_medication_compliance_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_breastfeeding_now patient_has_finding_of_breast_fed_now) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_finding_of_severe_depression_now (> patient_geriatric_depression_score_value_recorded_now_withunit_none 20)) :named REQ4_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_medication_compliance_now@@study_participation_would_be_detrimental_to_adherence patient_has_finding_of_medication_compliance_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not (and patient_is_currently_using_compliance_aid patient_has_finding_of_medication_compliance_now@@study_participation_would_be_detrimental_to_adherence)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_breastfeeding_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_sex_is_female_now (> patient_alcohol_containing_product_value_recorded_now_withunit_unit_per_week 21))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_sex_is_male_now (> patient_alcohol_containing_product_value_recorded_now_withunit_unit_per_week 28))) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (< patient_assessment_using_mini_mental_state_examination_value_recorded_now_withunit_score 26)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_severe_depression_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
