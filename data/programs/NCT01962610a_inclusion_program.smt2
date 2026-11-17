;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_resident_physician_now Bool)
(declare-const patient_provides_care_to_adult_patients_now Bool)
(declare-const patient_provides_care_in_emergency_department_of_icahn_school_of_medicine_at_mount_sinai_now Bool)

;; Other kept assertions
(assert (! patient_is_resident_physician_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_provides_care_to_adult_patients_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_provides_care_in_emergency_department_of_icahn_school_of_medicine_at_mount_sinai_now :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
