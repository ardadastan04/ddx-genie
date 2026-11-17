;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_co_morbid_conditions_now Bool)
(declare-const patient_has_finding_of_co_morbid_conditions_now@@medical_etiology Bool)
(declare-const patient_has_finding_of_co_morbid_conditions_now@@psychiatric_etiology Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_difficulty_with_follow_up_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_co_morbid_conditions_now@@medical_etiology patient_has_finding_of_co_morbid_conditions_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_co_morbid_conditions_now@@psychiatric_etiology patient_has_finding_of_co_morbid_conditions_now) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_co_morbid_conditions_now@@medical_etiology) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_co_morbid_conditions_now@@psychiatric_etiology) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_difficulty_with_follow_up_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
