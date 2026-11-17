;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_myasthenia_gravis_now Bool)
(declare-const patient_has_finding_of_myasthenia_gravis_now@@foundation_of_america_grade_v Bool)
(declare-const patient_has_finding_of_disease_now Bool)
(declare-const patient_has_finding_of_disease_now@@not_related_to_myasthenia_gravis Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_now Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_now@@interferes_with_muscle_strength Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_now@@interferes_with_balance Bool)
(declare-const patient_is_exposed_to_drug_or_medicament_now@@interferes_with_fatigue Bool)
(declare-const patient_has_finding_of_serious_physical_health_problem_now Bool)
(declare-const patient_has_finding_of_uncontrolled_insulin_dependent_diabetes_mellitus_now Bool)
(declare-const patient_has_finding_of_symptomatic_coronary_artery_disease_now Bool)
(declare-const patient_has_finding_of_cancer_now Bool)
(declare-const patient_has_diagnosis_of_dementia_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_excluded_due_to_unspecified_reason_judged_by_investigator Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_myasthenia_gravis_now@@foundation_of_america_grade_v patient_has_finding_of_myasthenia_gravis_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_disease_now@@not_related_to_myasthenia_gravis patient_has_finding_of_disease_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_now@@interferes_with_muscle_strength patient_is_exposed_to_drug_or_medicament_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_now@@interferes_with_balance patient_is_exposed_to_drug_or_medicament_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_is_exposed_to_drug_or_medicament_now@@interferes_with_fatigue patient_is_exposed_to_drug_or_medicament_now) :named REQ1_AUXILIARY3))
(assert (! (=> (or patient_has_finding_of_uncontrolled_insulin_dependent_diabetes_mellitus_now patient_has_finding_of_symptomatic_coronary_artery_disease_now patient_has_finding_of_cancer_now) patient_has_finding_of_serious_physical_health_problem_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_myasthenia_gravis_now@@foundation_of_america_grade_v) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disease_now@@not_related_to_myasthenia_gravis) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_exposed_to_drug_or_medicament_now@@interferes_with_muscle_strength) :named REQ1_COMPONENT1_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
(assert (! (not patient_is_exposed_to_drug_or_medicament_now@@interferes_with_balance) :named REQ1_COMPONENT2_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
(assert (! (not patient_is_exposed_to_drug_or_medicament_now@@interferes_with_fatigue) :named REQ1_COMPONENT3_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
(assert (! (not patient_has_finding_of_serious_physical_health_problem_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_dementia_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_excluded_due_to_unspecified_reason_judged_by_investigator) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
