;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_disorder_of_cardiovascular_system_now Bool)
(declare-const patient_has_finding_of_physical_inactivity_now Bool)
(declare-const patient_has_finding_of_tobacco_smoking_behavior_finding_now Bool)
(declare-const patient_has_finding_of_alcohol_intake_above_recommended_sensible_limits_now Bool)
(declare-const patient_has_finding_of_inappropriate_diet_and_eating_habits_now Bool)
(declare-const patient_has_finding_of_stress_now Bool)
(declare-const patient_has_finding_of_overweight_now Bool)
(declare-const patient_has_finding_of_android_obesity_now Bool)
(declare-const patient_has_finding_of_serum_lipids_high_now Bool)
(declare-const patient_has_finding_of_hypercholesterolemia_now Bool)
(declare-const patient_has_finding_of_raised_low_density_lipoprotein_cholesterol_now Bool)
(declare-const patient_has_finding_of_hypertensive_disorder_now Bool)
(declare-const patient_has_finding_of_diabetes_mellitus_now Bool)
(declare-const patient_has_finding_of_insulin_resistance_now Bool)
(declare-const patient_risk_factor_value_recorded_now_withunit_count Real)
(define-fun risk_factor_count () Int (+ (ite patient_has_diagnosis_of_disorder_of_cardiovascular_system_now 1 0) (ite patient_has_finding_of_physical_inactivity_now 1 0) (ite patient_has_finding_of_tobacco_smoking_behavior_finding_now 1 0) (ite patient_has_finding_of_alcohol_intake_above_recommended_sensible_limits_now 1 0) (ite patient_has_finding_of_inappropriate_diet_and_eating_habits_now 1 0) (ite patient_has_finding_of_stress_now 1 0) (ite patient_has_finding_of_overweight_now 1 0) (ite patient_has_finding_of_android_obesity_now 1 0) (ite patient_has_finding_of_serum_lipids_high_now 1 0) (ite patient_has_finding_of_hypertensive_disorder_now 1 0) (ite patient_has_finding_of_diabetes_mellitus_now 1 0) (ite patient_has_finding_of_insulin_resistance_now 1 0)))

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_hypercholesterolemia_now patient_has_finding_of_raised_low_density_lipoprotein_cholesterol_now) patient_has_finding_of_serum_lipids_high_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_risk_factor_value_recorded_now_withunit_count risk_factor_count) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (>= patient_risk_factor_value_recorded_now_withunit_count 3) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
