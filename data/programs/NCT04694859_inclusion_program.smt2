;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_severe_aortic_valve_stenosis_now Bool)
(declare-const patient_has_finding_of_symptomatic_aortic_valve_stenosis_now Bool)
(declare-const patient_has_finding_of_finding_of_increased_risk_level_now Bool)
(declare-const patient_is_undergoing_transcatheter_aortic_valve_implantation_now@@deemed_amenable_by_multidisciplinary_team Bool)
(declare-const patient_is_undergoing_transcatheter_aortic_valve_implantation_now Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_undergoing_transcatheter_aortic_valve_implantation_now@@deemed_amenable_by_multidisciplinary_team patient_is_undergoing_transcatheter_aortic_valve_implantation_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! patient_has_finding_of_severe_aortic_valve_stenosis_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_symptomatic_aortic_valve_stenosis_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_finding_of_finding_of_increased_risk_level_now patient_is_undergoing_transcatheter_aortic_valve_implantation_now@@deemed_amenable_by_multidisciplinary_team) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
