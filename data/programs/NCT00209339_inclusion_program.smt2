;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_moderate_mitral_valve_regurgitation_now Bool)
(declare-const patient_has_finding_of_severe_mitral_valve_regurgitation_now Bool)
(declare-const patient_has_finding_of_left_ventricular_cardiac_dysfunction_now Bool)
(declare-const patient_experiences_regurgitation_originating_from_central_two_thirds_of_valve_now Bool)
(declare-const patient_can_undergo_mitral_valve_operation_now Bool)
(declare-const patient_can_undergo_mitral_valve_operation_now@@including_cardiopulmonary_bypass Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_can_undergo_mitral_valve_operation_now@@including_cardiopulmonary_bypass patient_can_undergo_mitral_valve_operation_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (and (or patient_has_finding_of_moderate_mitral_valve_regurgitation_now patient_has_finding_of_severe_mitral_valve_regurgitation_now) patient_has_finding_of_left_ventricular_cardiac_dysfunction_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_experiences_regurgitation_originating_from_central_two_thirds_of_valve_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_can_undergo_mitral_valve_operation_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
