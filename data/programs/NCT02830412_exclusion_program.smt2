;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_postoperative_admission_to_intensive_care_unit Bool)
(declare-const patient_has_postoperative_fast_track_to_phase_ii Bool)
(declare-const patient_has_finding_of_sedated_now Bool)
(declare-const patient_has_finding_of_sedated_now@@at_end_of_procedure Bool)
(declare-const patient_is_undergoing_intubation_now Bool)
(declare-const patient_is_undergoing_intubation_now@@at_end_of_procedure Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_sedated_now@@at_end_of_procedure patient_has_finding_of_sedated_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_is_undergoing_intubation_now@@at_end_of_procedure patient_is_undergoing_intubation_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_postoperative_admission_to_intensive_care_unit) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_postoperative_fast_track_to_phase_ii) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_sedated_now@@at_end_of_procedure) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_undergoing_intubation_now@@at_end_of_procedure) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
