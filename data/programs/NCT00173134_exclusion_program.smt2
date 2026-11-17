;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_undergoing_administration_of_medication_now Bool)
(declare-const patient_is_undergoing_surgical_procedure_now Bool)
(declare-const patient_is_using_mechanical_device_for_erectile_dysfunction_now Bool)
(declare-const patient_is_using_erectile_dysfunction_treatment_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_is_undergoing_administration_of_medication_now patient_is_using_mechanical_device_for_erectile_dysfunction_now patient_is_undergoing_surgical_procedure_now) patient_is_using_erectile_dysfunction_treatment_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_is_using_erectile_dysfunction_treatment_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
