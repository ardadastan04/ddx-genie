;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_benign_prostatic_hyperplasia_now Bool)
(declare-const patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_digital_rectal_examination Bool)
(declare-const patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_ultrasonography Bool)
(declare-const patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_computed_tomography Bool)
(declare-const patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_magnetic_resonance_imaging Bool)
(declare-const patient_assessment_using_i_pss_value_recorded_now_withunit_score Real)
(declare-const patient_maximal_urinary_flow_rate_value_recorded_now_withunit_ml_per_s Real)
(declare-const patient_urinary_bladder_volume_value_recorded_now_withunit_ml Real)
(declare-const prostate_weight_value_recorded_withunit_grams Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_digital_rectal_examination patient_has_diagnosis_of_benign_prostatic_hyperplasia_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_ultrasonography patient_has_diagnosis_of_benign_prostatic_hyperplasia_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_computed_tomography patient_has_diagnosis_of_benign_prostatic_hyperplasia_now) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_magnetic_resonance_imaging patient_has_diagnosis_of_benign_prostatic_hyperplasia_now) :named REQ0_AUXILIARY3))

;; Other kept assertions
(assert (! (or patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_digital_rectal_examination patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_ultrasonography patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_computed_tomography patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@diagnosed_by_magnetic_resonance_imaging) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_assessment_using_i_pss_value_recorded_now_withunit_score 15) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_maximal_urinary_flow_rate_value_recorded_now_withunit_ml_per_s 10.0) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (> patient_urinary_bladder_volume_value_recorded_now_withunit_ml 200.0) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (> prostate_weight_value_recorded_withunit_grams 45.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
