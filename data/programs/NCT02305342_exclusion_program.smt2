;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_specialized_patient_not_attending_primary_care_clinic_now Bool)
(declare-const patient_has_finding_of_hospital_patient_now Bool)
(declare-const patient_has_finding_of_catheterized_patient_now Bool)

;; Other kept assertions
(assert (! (not patient_is_specialized_patient_not_attending_primary_care_clinic_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hospital_patient_now) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_catheterized_patient_now) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
