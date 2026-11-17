;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_asthma_now Bool)
(declare-const patient_has_diagnosis_of_asthma_now@@diagnosed_by_lung_function_tests Bool)
(declare-const patient_has_diagnosis_of_asthma_now@@diagnosed_by_typical_symptoms Bool)
(declare-const patient_inhaled_steroid_therapy_value_recorded_inthehistory_withunit_months Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_asthma_now@@diagnosed_by_lung_function_tests patient_has_diagnosis_of_asthma_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_asthma_now@@diagnosed_by_typical_symptoms patient_has_diagnosis_of_asthma_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (or patient_has_diagnosis_of_asthma_now@@diagnosed_by_lung_function_tests patient_has_diagnosis_of_asthma_now@@diagnosed_by_typical_symptoms) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_inhaled_steroid_therapy_value_recorded_inthehistory_withunit_months 3) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
