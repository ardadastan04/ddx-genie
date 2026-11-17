;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_sibling_of_birth_cohort_recruited_1997_1999 Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_diagnosis_of_asthma_now Bool)
(declare-const patient_has_diagnosis_of_asthma_now@@diagnosed_by_physician Bool)
(declare-const patient_has_finding_of_wheezing_inthepast12months Bool)
(declare-const patient_has_finding_of_persistent_cough_inthepast12months Bool)
(declare-const patient_has_finding_of_tight_chest_inthepast12months Bool)
(declare-const patient_has_finding_of_dyspnea_inthepast12months Bool)
(declare-const patient_has_medication_use_inthepast12months Bool)
(declare-const patient_has_medication_use_inthepast12months@@asthma_related Bool)
(declare-const patient_has_active_symptoms_inthepast12months Bool)
(declare-const patient_meets_inclusion_symptoms_or_medication_inthepast12months Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_asthma_now@@diagnosed_by_physician patient_has_diagnosis_of_asthma_now) :named REQ2_AUXILIARY0))
(assert (! (= patient_has_active_symptoms_inthepast12months (or patient_has_finding_of_wheezing_inthepast12months patient_has_finding_of_persistent_cough_inthepast12months patient_has_finding_of_tight_chest_inthepast12months patient_has_finding_of_dyspnea_inthepast12months)) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_medication_use_inthepast12months@@asthma_related patient_has_medication_use_inthepast12months) :named REQ3_AUXILIARY2))
(assert (! (= patient_meets_inclusion_symptoms_or_medication_inthepast12months (or patient_has_active_symptoms_inthepast12months patient_has_medication_use_inthepast12months@@asthma_related)) :named REQ3_AUXILIARY1))

;; Other kept assertions
(assert (! patient_is_sibling_of_birth_cohort_recruited_1997_1999 :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (< patient_age_value_recorded_now_in_years 11.0) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_diagnosis_of_asthma_now@@diagnosed_by_physician :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_meets_inclusion_symptoms_or_medication_inthepast12months :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
