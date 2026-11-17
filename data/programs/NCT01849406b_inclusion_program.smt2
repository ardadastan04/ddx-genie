;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_habitual_snoring_now Bool)
(declare-const patient_is_taking_medication_known_to_influence_nasal_resistance_now Bool)
(declare-const patient_is_taking_histamine_receptor_antagonist_containing_product_now Bool)
(declare-const patient_is_taking_vasoconstrictor_medication_now Bool)
(declare-const patient_is_taking_steroid_containing_product_now Bool)
(declare-const patient_is_exposed_to_steroid_hormone_now Bool)
(declare-const patient_is_exposed_to_steroid_hormone_now@@due_to_systemic_steroid_medication Bool)
(declare-const patient_has_finding_of_tobacco_smoking_behavior_finding_inthepast6months Bool)
(declare-const patient_has_finding_of_upper_respiratory_tract_disease_now Bool)
(declare-const patient_has_finding_of_upper_respiratory_infection_now Bool)
(declare-const patient_has_finding_of_rhinitis_now Bool)
(declare-const patient_has_finding_of_sinusitis_now Bool)
(declare-const patient_has_finding_of_lower_respiratory_tract_disease_now Bool)
(declare-const patient_has_finding_of_chronic_obstructive_lung_disease_now Bool)
(declare-const patient_has_finding_of_allergic_rhinitis_inthehistory Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_taking_histamine_receptor_antagonist_containing_product_now patient_is_taking_medication_known_to_influence_nasal_resistance_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_taking_vasoconstrictor_medication_now patient_is_taking_medication_known_to_influence_nasal_resistance_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_is_taking_steroid_containing_product_now patient_is_taking_medication_known_to_influence_nasal_resistance_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_is_exposed_to_steroid_hormone_now@@due_to_systemic_steroid_medication patient_is_exposed_to_steroid_hormone_now) :named REQ1_AUXILIARY3_SUBSET))
(assert (! (=> patient_is_exposed_to_steroid_hormone_now@@due_to_systemic_steroid_medication patient_is_taking_medication_known_to_influence_nasal_resistance_now) :named REQ1_AUXILIARY3))
(assert (! (=> (or patient_has_finding_of_upper_respiratory_infection_now patient_has_finding_of_rhinitis_now patient_has_finding_of_sinusitis_now) patient_has_finding_of_upper_respiratory_tract_disease_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_chronic_obstructive_lung_disease_now patient_has_finding_of_lower_respiratory_tract_disease_now) :named REQ3_AUXILIARY1))

;; Other kept assertions
(assert (! patient_has_finding_of_habitual_snoring_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not patient_is_taking_medication_known_to_influence_nasal_resistance_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_tobacco_smoking_behavior_finding_inthepast6months) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (not (or patient_has_finding_of_upper_respiratory_tract_disease_now patient_has_finding_of_lower_respiratory_tract_disease_now patient_has_finding_of_allergic_rhinitis_inthehistory)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
