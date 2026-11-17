;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_exacerbation_necessitating_alteration_in_medication_within_past_4_weeks Bool)
(declare-const patient_has_undergone_emergency_department_patient_visit_inthepast4weeks Bool)
(declare-const patient_has_hospitalization_within_past_4_weeks Bool)
(declare-const patient_can_undergo_spirometry_now Bool)
(declare-const patient_can_undergo_spirometry_now@@acceptable_quality Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_can_undergo_spirometry_now@@acceptable_quality patient_can_undergo_spirometry_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_exacerbation_necessitating_alteration_in_medication_within_past_4_weeks) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_emergency_department_patient_visit_inthepast4weeks) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_hospitalization_within_past_4_weeks) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_can_undergo_spirometry_now@@acceptable_quality) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
