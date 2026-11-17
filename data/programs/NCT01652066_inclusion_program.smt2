;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_fit_and_well_now Bool)
(declare-const patient_is_adult_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_uses_contraception_now Bool)
(declare-const patient_has_finding_of_uses_contraception_now@@contraception_is_effective Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_capable_to_respect_protocol Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_uses_contraception_now@@contraception_is_effective patient_has_finding_of_uses_contraception_now) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! (or (and patient_has_finding_of_fit_and_well_now patient_is_adult_now patient_sex_is_male_now) (and patient_has_finding_of_fit_and_well_now patient_is_adult_now patient_sex_is_female_now)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 60.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_sex_is_female_now :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_is_capable_to_respect_protocol :named REQ2_COMPONENT3_OTHER_REQUIREMENTS))
