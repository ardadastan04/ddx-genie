;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_intolerance_to_lactose_now Bool)
(declare-const patient_has_finding_of_intolerance_to_protein_now Bool)
(declare-const patient_has_finding_of_hypothyroidism_now Bool)
(declare-const patient_has_finding_of_hyperthyroidism_now Bool)
(declare-const patient_is_receiving_pharmacological_treatment_of_diabetes_mellitus_now Bool)
(declare-const patient_is_taking_vitamin_supplement_now Bool)
(declare-const patient_is_taking_mineral_supplement_now Bool)
(declare-const patient_is_taking_anticoagulant_now Bool)
(declare-const patient_has_cardiac_pacemaker_now Bool)
(declare-const patient_has_contraindication_to_exercise_now Bool)

;; Other kept assertions
(assert (! (not patient_has_finding_of_intolerance_to_lactose_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_intolerance_to_protein_now) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hypothyroidism_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hyperthyroidism_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_receiving_pharmacological_treatment_of_diabetes_mellitus_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_vitamin_supplement_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_mineral_supplement_now) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_anticoagulant_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_cardiac_pacemaker_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_exercise_now) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
