;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_loop_electrosurgical_excision_procedure_inthehistory Bool)
(declare-const patient_has_undergone_laser_treatment_inthehistory Bool)
(declare-const patient_has_undergone_cone_biopsy_inthehistory Bool)
(declare-const patient_has_undergone_loop_electrosurgical_excision_procedure_inthehistory@@cervix Bool)
(declare-const patient_has_undergone_laser_treatment_inthehistory@@cervix Bool)
(declare-const patient_has_undergone_cone_biopsy_inthehistory@@cervix Bool)
(declare-const patient_has_history_of_cervical_cancer_treatment_inthehistory Bool)
(declare-const patient_has_undergone_microscopic_examination_of_cervical_papanicolaou_smear_inthepast10months Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_able_to_give_informed_consent_in_english Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_loop_electrosurgical_excision_procedure_inthehistory@@cervix patient_has_undergone_loop_electrosurgical_excision_procedure_inthehistory) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_laser_treatment_inthehistory@@cervix patient_has_undergone_laser_treatment_inthehistory) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_cone_biopsy_inthehistory@@cervix patient_has_undergone_cone_biopsy_inthehistory) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_undergone_loop_electrosurgical_excision_procedure_inthehistory@@cervix patient_has_history_of_cervical_cancer_treatment_inthehistory) :named REQ0_AUXILIARY3))
(assert (! (=> patient_has_undergone_laser_treatment_inthehistory@@cervix patient_has_history_of_cervical_cancer_treatment_inthehistory) :named REQ0_AUXILIARY4))
(assert (! (=> patient_has_undergone_cone_biopsy_inthehistory@@cervix patient_has_history_of_cervical_cancer_treatment_inthehistory) :named REQ0_AUXILIARY5))

;; Other kept assertions
(assert (! (not patient_has_undergone_loop_electrosurgical_excision_procedure_inthehistory@@cervix) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_laser_treatment_inthehistory@@cervix) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_cone_biopsy_inthehistory@@cervix) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_history_of_cervical_cancer_treatment_inthehistory) :named REQ0_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_microscopic_examination_of_cervical_papanicolaou_smear_inthepast10months) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_give_informed_consent_in_english :named REQ4_COMPONENT0_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
