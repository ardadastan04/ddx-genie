;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_alcohol_induced_acute_pancreatitis_now@@severe Bool)
(declare-const patient_has_finding_of_multiple_organ_failure_now@@early Bool)
(declare-const patient_has_finding_of_multiple_organ_failure_now Bool)
(declare-const sequential_organ_failure_assessment_score_value_recorded_now_withunit_points Real)
(declare-const patient_has_finding_of_alcohol_induced_acute_pancreatitis_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_multiple_organ_failure_now@@early patient_has_finding_of_multiple_organ_failure_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_finding_of_multiple_organ_failure_now@@early (and patient_has_finding_of_multiple_organ_failure_now (> sequential_organ_failure_assessment_score_value_recorded_now_withunit_points 2))) :named REQ0_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_alcohol_induced_acute_pancreatitis_now@@severe patient_has_finding_of_alcohol_induced_acute_pancreatitis_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! patient_has_finding_of_alcohol_induced_acute_pancreatitis_now@@severe :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_multiple_organ_failure_now@@early :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
