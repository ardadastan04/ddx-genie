;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_neonate_now Bool)
(declare-const patient_is_neonate_now@@at_pediatric_ward Bool)
(declare-const patient_is_neonate_now@@at_maternity_ward Bool)
(declare-const patient_has_finding_of_jaundice_now Bool)
(declare-const patient_has_finding_of_jaundice_now@@visible Bool)
(declare-const gestational_age_value_recorded_now_in_weeks Real)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_age_value_recorded_now_in_days Real)

;; Existing auxiliary assertions
(assert (! (=> patient_is_neonate_now@@at_pediatric_ward patient_is_neonate_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_neonate_now@@at_maternity_ward patient_is_neonate_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_jaundice_now@@visible patient_has_finding_of_jaundice_now) :named REQ0_AUXILIARY2))

;; Other kept assertions
(assert (! (or (and patient_is_neonate_now@@at_pediatric_ward patient_has_finding_of_jaundice_now@@visible) (and patient_is_neonate_now@@at_maternity_ward patient_has_finding_of_jaundice_now@@visible)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_is_pregnant_now (>= gestational_age_value_recorded_now_in_weeks 32.0)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_age_value_recorded_now_in_days (/ 24.0 24.0)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< patient_age_value_recorded_now_in_days 8) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
