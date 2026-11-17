;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_classified_as_asa_physical_status_class_iii_now Bool)
(declare-const patient_is_classified_as_asa_physical_status_class_iv_now Bool)
(declare-const patient_has_undergone_operation_on_abdominal_region_inthehistory Bool)
(declare-const patient_has_undergone_cholecystectomy_inthehistory Bool)

;; Other kept assertions
(assert (! (not patient_has_finding_of_cirrhosis_of_liver_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_classified_as_asa_physical_status_class_iii_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_classified_as_asa_physical_status_class_iv_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_operation_on_abdominal_region_inthehistory) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_cholecystectomy_inthehistory) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
