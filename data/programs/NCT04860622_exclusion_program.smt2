;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_history_of_adolescent_pregnancy Bool)
(declare-const patient_has_diagnosis_of_disorder_of_thyroid_gland_inthehistory Bool)
(declare-const patient_is_exposed_to_antithyroperoxidase_antibody_now Bool)
(declare-const patient_is_using_thyroid_interfering_medication_now Bool)
(declare-const patient_has_undergone_in_vitro_fertilization_inthehistory Bool)

;; Other kept assertions
(assert (! (not patient_has_history_of_adolescent_pregnancy) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_disorder_of_thyroid_gland_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_antithyroperoxidase_antibody_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_using_thyroid_interfering_medication_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_in_vitro_fertilization_inthehistory) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
