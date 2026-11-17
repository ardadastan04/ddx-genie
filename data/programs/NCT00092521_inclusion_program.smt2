;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_has_intact_uterus_now Bool)
(declare-const sexual_partners_count_lifetime_value_recorded_in_persons Int)
(declare-const sexual_partners_count_lifetime_value_recorded_in_persons_is_known Bool)
(declare-const patient_sex_is_female_now_is_known Bool)
(declare-const patient_has_intact_uterus_now_is_known Bool)

;; Existing auxiliary assertions
(assert (! sexual_partners_count_lifetime_value_recorded_in_persons_is_known :named REQ0_AUXILIARY_KNOWN_LIFETIME_SEXUAL_PARTNERS_COUNT))
(assert (! patient_sex_is_female_now_is_known :named REQ0_AUXILIARY_KNOWN_PATIENT_SEX))
(assert (! patient_has_intact_uterus_now_is_known :named REQ0_AUXILIARY_KNOWN_INTACT_UTERUS))

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_intact_uterus_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= sexual_partners_count_lifetime_value_recorded_in_persons 0) (<= sexual_partners_count_lifetime_value_recorded_in_persons 4)) :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
