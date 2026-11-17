;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const family_is_currently_involved_in_asthma_management_intervention_above_and_beyond_usual_care Bool)
(declare-const patient_is_able_to_complete_study_procedures_independently Bool)

;; Other kept assertions
(assert (! (not family_is_currently_involved_in_asthma_management_intervention_above_and_beyond_usual_care) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_able_to_complete_study_procedures_independently) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
