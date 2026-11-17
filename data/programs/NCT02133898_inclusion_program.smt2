;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_now Bool)
(declare-const patient_has_diagnosis_of_major_depressive_disorder_now@@diagnosed_by_structured_clinical_interview_for_dsm_iv Bool)
(declare-const patient_ham_d_hamilton_rating_scale_for_depression_score_value_recorded_now_withunit_score Real)
(declare-const patient_has_taken_antidepressant_inthepast3months Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_major_depressive_disorder_now@@diagnosed_by_structured_clinical_interview_for_dsm_iv patient_has_diagnosis_of_major_depressive_disorder_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_major_depressive_disorder_now@@diagnosed_by_structured_clinical_interview_for_dsm_iv :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_ham_d_hamilton_rating_scale_for_depression_score_value_recorded_now_withunit_score 8) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_ham_d_hamilton_rating_scale_for_depression_score_value_recorded_now_withunit_score 24) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_taken_antidepressant_inthepast3months) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
