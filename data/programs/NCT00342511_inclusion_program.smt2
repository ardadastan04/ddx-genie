;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_undergone_hysterectomy_inthehistory Bool)
(declare-const patient_is_able_to_be_pregnant_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_hysterectomy_inthehistory (not patient_is_able_to_be_pregnant_now)) :named REQ1_AUXILIARY0))

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 21) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (not patient_is_pregnant_now) (not patient_has_undergone_hysterectomy_inthehistory)) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
