;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_her2_positive_carcinoma_of_breast_now Bool)
(declare-const patient_has_diagnosis_of_her2_positive_carcinoma_of_breast_now@@pathologically_confirmed Bool)
(declare-const patient_has_received_pyrotinib_in_metastatic_settings Bool)
(declare-const patient_has_undergone_pet_ct_of_whole_body_using_fluorodeoxyglucose_inthehistory Bool)
(declare-const whole_body_fluorodeoxyglucose_pet_ct_date Real)
(declare-const initiation_of_pyrotinib_and_capecitabine_date Real)
(declare-const patient_has_undergone_pet_ct_of_whole_body_using_fluorodeoxyglucose_within_4_weeks_before_initiation_of_pyrotinib_and_capecitabine Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_her2_positive_carcinoma_of_breast_now@@pathologically_confirmed patient_has_diagnosis_of_her2_positive_carcinoma_of_breast_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_undergone_pet_ct_of_whole_body_using_fluorodeoxyglucose_within_4_weeks_before_initiation_of_pyrotinib_and_capecitabine (and patient_has_undergone_pet_ct_of_whole_body_using_fluorodeoxyglucose_inthehistory (<= (- initiation_of_pyrotinib_and_capecitabine_date whole_body_fluorodeoxyglucose_pet_ct_date) 28) (> initiation_of_pyrotinib_and_capecitabine_date whole_body_fluorodeoxyglucose_pet_ct_date))) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_her2_positive_carcinoma_of_breast_now@@pathologically_confirmed :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_received_pyrotinib_in_metastatic_settings :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_pet_ct_of_whole_body_using_fluorodeoxyglucose_within_4_weeks_before_initiation_of_pyrotinib_and_capecitabine :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
