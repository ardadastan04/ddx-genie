;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_difficulty_complying_with_treatment_now Bool)
(declare-const patient_is_currently_participating_in_other_research_studies Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_has_finding_of_finding_of_lesion_now Bool)
(declare-const patient_has_finding_of_finding_of_lesion_now@@not_due_to_stroke Bool)
(declare-const patient_has_finding_of_finding_of_lesion_now@@could_affect_the_proposed_therapy Bool)
(declare-const patient_has_finding_of_joint_pain_now Bool)
(declare-const patient_has_finding_of_joint_pain_now@@could_forbid_the_therapy Bool)
(declare-const patient_has_finding_of_muscle_pain_now Bool)
(declare-const patient_has_finding_of_muscle_pain_now@@could_forbid_the_therapy Bool)
(declare-const patient_has_finding_of_co_morbid_conditions_now Bool)
(declare-const patient_has_finding_of_co_morbid_conditions_now@@destabilized Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_finding_of_lesion_now@@not_due_to_stroke patient_has_finding_of_finding_of_lesion_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_finding_of_lesion_now@@could_affect_the_proposed_therapy patient_has_finding_of_finding_of_lesion_now) :named REQ3_AUXILIARY1))
(assert (! (=> (and patient_has_finding_of_finding_of_lesion_now@@could_affect_the_proposed_therapy patient_has_finding_of_finding_of_lesion_now@@not_due_to_stroke) true) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_finding_of_muscle_pain_now@@could_forbid_the_therapy patient_has_finding_of_muscle_pain_now) :named REQ4_AUXILIARY1))
(assert (! (=> patient_has_finding_of_joint_pain_now@@could_forbid_the_therapy patient_has_finding_of_joint_pain_now) :named REQ4_AUXILIARY2))
(assert (! (=> patient_has_finding_of_co_morbid_conditions_now@@destabilized patient_has_finding_of_co_morbid_conditions_now) :named REQ5_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_difficulty_complying_with_treatment_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_currently_participating_in_other_research_studies) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_finding_of_lesion_now@@not_due_to_stroke patient_has_finding_of_finding_of_lesion_now@@could_affect_the_proposed_therapy)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or (and patient_has_finding_of_finding_of_lesion_now@@could_affect_the_proposed_therapy patient_has_finding_of_finding_of_lesion_now@@not_due_to_stroke) patient_has_finding_of_muscle_pain_now@@could_forbid_the_therapy patient_has_finding_of_joint_pain_now@@could_forbid_the_therapy)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_co_morbid_conditions_now@@destabilized) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
