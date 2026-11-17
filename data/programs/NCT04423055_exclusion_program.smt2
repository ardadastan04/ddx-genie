;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_contraindication_to_using_combined_oral_contraceptive_now_cdc_category_3_or_4 Bool)
(declare-const patient_has_contraindication_to_using_contraceptive_implant_now_cdc_category_3_or_4 Bool)
(declare-const patient_is_undergoing_clinical_trial_now Bool)
(declare-const patient_has_undergone_clinical_trial_inthepast30days Bool)
(declare-const patient_is_postpartum_foradurationof2weeks Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const pregnancy_time_from_end_in_days Real)

;; Existing auxiliary assertions
(assert (! (= patient_is_postpartum_foradurationof2weeks (or patient_is_pregnant_now (and (not patient_is_pregnant_now) (<= pregnancy_time_from_end_in_days 14) (>= pregnancy_time_from_end_in_days 0)))) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_contraindication_to_using_combined_oral_contraceptive_now_cdc_category_3_or_4) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_using_contraceptive_implant_now_cdc_category_3_or_4) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_clinical_trial_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_clinical_trial_inthepast30days) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_postpartum_foradurationof2weeks) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
