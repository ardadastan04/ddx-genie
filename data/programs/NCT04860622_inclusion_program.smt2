;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_singleton_pregnancy_now Bool)
(declare-const patient_has_diagnosis_of_disorder_of_thyroid_gland_inthehistory Bool)
(declare-const patient_has_diagnosis_of_disorder_of_thyroid_gland_inthehistory@@pre_existing Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_now@@interferes_with_thyroid_function Bool)
(declare-const patient_has_undergone_in_vitro_fertilization_inthehistory Bool)
(declare-const patient_is_exposed_to_antithyroperoxidase_antibody_now Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_disorder_of_thyroid_gland_inthehistory@@pre_existing patient_has_diagnosis_of_disorder_of_thyroid_gland_inthehistory) :named REQ1_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_exposed_to_drug_or_medicament_now@@interferes_with_thyroid_function patient_is_exposed_to_drug_or_medicament_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! patient_has_singleton_pregnancy_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_has_diagnosis_of_disorder_of_thyroid_gland_inthehistory@@pre_existing) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_drug_or_medicament_now@@interferes_with_thyroid_function) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_in_vitro_fertilization_inthehistory) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_antithyroperoxidase_antibody_now) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
