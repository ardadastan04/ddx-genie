;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_autosomal_dominant_late_onset_parkinson_disease_now Bool)
(declare-const patient_has_finding_of_autosomal_dominant_late_onset_parkinson_disease_now@@apparently_being_inherited_in_the_family Bool)
(declare-const patient_is_unaffected_member_of_family Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_autosomal_dominant_late_onset_parkinson_disease_now@@apparently_being_inherited_in_the_family patient_has_finding_of_autosomal_dominant_late_onset_parkinson_disease_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_autosomal_dominant_late_onset_parkinson_disease_now@@apparently_being_inherited_in_the_family :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_unaffected_member_of_family :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
