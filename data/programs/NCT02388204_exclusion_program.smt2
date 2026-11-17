;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_dementia_now Bool)
(declare-const patient_hoehn_and_yahr_scale_score_value_recorded_now_withunit_score Real)
(declare-const patient_duration_of_parkinsons_disease_symptoms_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_parkinsonian_features_now Bool)
(declare-const patient_has_general_contraindications_of_surgery_now Bool)

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_dementia_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (> patient_hoehn_and_yahr_scale_score_value_recorded_now_withunit_score 4)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_parkinsonian_features_now (< patient_duration_of_parkinsons_disease_symptoms_value_recorded_now_in_years 5))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_general_contraindications_of_surgery_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
