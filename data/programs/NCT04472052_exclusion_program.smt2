;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_acute_appendicitis_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const appendectomy_performed_date_value_recorded_in_history_withunit_date Real)
(declare-const patient_has_undergone_appendectomy_inthehistory Bool)

;; Other kept assertions
(assert (! (not (and patient_has_finding_of_acute_appendicitis_now (< patient_age_value_recorded_now_in_years 16))) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_undergone_appendectomy_inthehistory (not (or (and (>= appendectomy_performed_date_value_recorded_in_history_withunit_date 20180316) (<= appendectomy_performed_date_value_recorded_in_history_withunit_date 20180530)) (and (>= appendectomy_performed_date_value_recorded_in_history_withunit_date 20190316) (<= appendectomy_performed_date_value_recorded_in_history_withunit_date 20190530)) (and (>= appendectomy_performed_date_value_recorded_in_history_withunit_date 20200316) (<= appendectomy_performed_date_value_recorded_in_history_withunit_date 20200530)))))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
