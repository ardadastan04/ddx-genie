;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory Bool)
(declare-const patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory@@duration_in_years Real)
(declare-const patient_has_finding_of_hypoglycemia_inthepast12months Bool)
(declare-const patient_has_finding_of_hypoglycemia_inthepast12months@@documented Bool)
(declare-const patient_has_finding_of_hypoglycemia_inthepast12months@@severe Bool)
(declare-const patient_has_finding_of_hypoglycemia_inthepast12months@@episode_count Real)
(declare-const patient_has_stable_diabetic_treatment_now Bool)
(declare-const duration_of_continuous_glucose_monitor_use_before_screening_in_months Real)
(declare-const patient_has_used_continuous_glucose_monitor_consistently_for_at_least_3_months_before_screening Bool)

;; Existing auxiliary assertions
(assert (! (=> (>= patient_has_finding_of_hypoglycemia_inthepast12months@@episode_count 1) patient_has_finding_of_hypoglycemia_inthepast12months) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_used_continuous_glucose_monitor_consistently_for_at_least_3_months_before_screening (>= duration_of_continuous_glucose_monitor_use_before_screening_in_months 3.0)) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_hypoglycemia_inthepast12months@@documented patient_has_finding_of_hypoglycemia_inthepast12months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_hypoglycemia_inthepast12months@@severe patient_has_finding_of_hypoglycemia_inthepast12months) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (> patient_has_diagnosis_of_type_1_diabetes_mellitus_inthehistory@@duration_in_years 5) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and (>= patient_has_finding_of_hypoglycemia_inthepast12months@@episode_count 2) patient_has_finding_of_hypoglycemia_inthepast12months@@documented patient_has_finding_of_hypoglycemia_inthepast12months@@severe) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_stable_diabetic_treatment_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_used_continuous_glucose_monitor_consistently_for_at_least_3_months_before_screening :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
