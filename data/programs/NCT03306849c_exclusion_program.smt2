;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=6 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_weight_finding_value_recorded_now_withunit_kilograms Real)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_breastfeeding_now Bool)
(declare-const patient_has_undergone_operation_on_ovary_inthehistory Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast3months@@known_to_interfere_with_reproductive_function Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast3months@@known_to_interfere_with_glucose_metabolism Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast3months@@known_to_interfere_with_lipid_metabolism Bool)
(declare-const patient_is_exposed_to_nutritional_supplement_inthepast3months@@known_to_interfere_with_reproductive_function Bool)
(declare-const patient_is_exposed_to_nutritional_supplement_inthepast3months@@known_to_interfere_with_glucose_metabolism Bool)
(declare-const patient_is_exposed_to_nutritional_supplement_inthepast3months@@known_to_interfere_with_lipid_metabolism Bool)
(declare-const patient_has_evidence_of_reproductive_aging_now Bool)
(declare-const patient_has_evidence_of_reproductive_aging_now@@as_assessed_by_principal_criteria_of_stages_of_reproductive_aging_workshop_plus_10_stages Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast3months Bool)
(declare-const patient_is_exposed_to_nutritional_supplement_inthepast3months Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_evidence_of_reproductive_aging_now@@as_assessed_by_principal_criteria_of_stages_of_reproductive_aging_workshop_plus_10_stages patient_has_evidence_of_reproductive_aging_now) :named REQ4_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_exposed_to_drug_or_medicament_inthepast3months@@known_to_interfere_with_glucose_metabolism patient_is_exposed_to_drug_or_medicament_inthepast3months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_inthepast3months@@known_to_interfere_with_lipid_metabolism patient_is_exposed_to_drug_or_medicament_inthepast3months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_inthepast3months@@known_to_interfere_with_reproductive_function patient_is_exposed_to_drug_or_medicament_inthepast3months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_is_exposed_to_nutritional_supplement_inthepast3months@@known_to_interfere_with_glucose_metabolism patient_is_exposed_to_nutritional_supplement_inthepast3months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_is_exposed_to_nutritional_supplement_inthepast3months@@known_to_interfere_with_lipid_metabolism patient_is_exposed_to_nutritional_supplement_inthepast3months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))
(assert (! (=> patient_is_exposed_to_nutritional_supplement_inthepast3months@@known_to_interfere_with_reproductive_function patient_is_exposed_to_nutritional_supplement_inthepast3months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_5))

;; Other kept assertions
(assert (! (not (> patient_weight_finding_value_recorded_now_withunit_kilograms 300)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_breastfeeding_now) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_operation_on_ovary_inthehistory) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_drug_or_medicament_inthepast3months@@known_to_interfere_with_reproductive_function) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_drug_or_medicament_inthepast3months@@known_to_interfere_with_glucose_metabolism) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_drug_or_medicament_inthepast3months@@known_to_interfere_with_lipid_metabolism) :named REQ3_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_nutritional_supplement_inthepast3months@@known_to_interfere_with_reproductive_function) :named REQ3_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_nutritional_supplement_inthepast3months@@known_to_interfere_with_glucose_metabolism) :named REQ3_COMPONENT4_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_nutritional_supplement_inthepast3months@@known_to_interfere_with_lipid_metabolism) :named REQ3_COMPONENT5_OTHER_REQUIREMENTS))
(assert (! (not patient_has_evidence_of_reproductive_aging_now@@as_assessed_by_principal_criteria_of_stages_of_reproductive_aging_workshop_plus_10_stages) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
