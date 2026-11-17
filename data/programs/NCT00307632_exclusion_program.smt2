;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_received_depot_hormone_injection_within_6_months_before_screening_visit Bool)
(declare-const patient_has_received_depoprovera_within_6_months_before_screening_visit Bool)
(declare-const patient_is_exposed_to_medroxyprogesterone_acetate_inthepast6months Bool)
(declare-const patient_is_exposed_to_medroxyprogesterone_acetate_inthepast6months@@temporalcontext_within6months_before_screening_visit Bool)
(declare-const patient_has_taken_barbiturate_containing_product_inthepast30days Bool)
(declare-const patient_is_taking_barbiturate_containing_product_inthepast30days Bool)
(declare-const patient_is_exposed_to_anticonvulsant_inthepast30days Bool)
(declare-const patient_has_taken_rifampin_containing_product_inthepast30days Bool)
(declare-const patient_is_taking_rifampin_containing_product_inthepast30days Bool)
(declare-const patient_has_taken_griseofulvin_containing_product_inthepast30days Bool)
(declare-const patient_is_taking_griseofulvin_containing_product_inthepast30days Bool)
(declare-const patient_has_taken_hypericum_perforatum_inthepast30days Bool)
(declare-const patient_is_taking_hypericum_perforatum_inthepast30days Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast30days@@hepatic_enzyme_inducing Bool)
(declare-const patient_has_finding_of_disease_condition_determination_uncontrolled_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_tobacco_smoking_behavior_finding_now Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_inthepast30days Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_received_depoprovera_within_6_months_before_screening_visit patient_has_received_depot_hormone_injection_within_6_months_before_screening_visit) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_medroxyprogesterone_acetate_inthepast6months@@temporalcontext_within6months_before_screening_visit patient_has_received_depoprovera_within_6_months_before_screening_visit) :named REQ0_AUXILIARY1))
(assert (! (=> patient_is_exposed_to_medroxyprogesterone_acetate_inthepast6months@@temporalcontext_within6months_before_screening_visit patient_is_exposed_to_medroxyprogesterone_acetate_inthepast6months) :named REQ0_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_exposed_to_drug_or_medicament_inthepast30days@@hepatic_enzyme_inducing patient_is_exposed_to_drug_or_medicament_inthepast30days) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not patient_has_received_depot_hormone_injection_within_6_months_before_screening_visit) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_taken_barbiturate_containing_product_inthepast30days) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_anticonvulsant_inthepast30days) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_taken_rifampin_containing_product_inthepast30days) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_taken_griseofulvin_containing_product_inthepast30days) :named REQ1_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_taken_hypericum_perforatum_inthepast30days) :named REQ1_COMPONENT4_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_drug_or_medicament_inthepast30days@@hepatic_enzyme_inducing) :named REQ1_COMPONENT5_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_barbiturate_containing_product_inthepast30days) :named REQ1_COMPONENT6_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_anticonvulsant_inthepast30days) :named REQ1_COMPONENT7_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_rifampin_containing_product_inthepast30days) :named REQ1_COMPONENT8_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_griseofulvin_containing_product_inthepast30days) :named REQ1_COMPONENT9_OTHER_REQUIREMENTS))
(assert (! (not patient_is_taking_hypericum_perforatum_inthepast30days) :named REQ1_COMPONENT10_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_drug_or_medicament_inthepast30days@@hepatic_enzyme_inducing) :named REQ1_COMPONENT11_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disease_condition_determination_uncontrolled_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_sex_is_female_now (> patient_age_value_recorded_now_in_years 35) patient_has_finding_of_tobacco_smoking_behavior_finding_now)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
