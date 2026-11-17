;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now Bool)
(declare-const patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@recently_received Bool)
(declare-const patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@indicative_of_oncogenic_human_papillomavirus_infection Bool)
(declare-const patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@recently_received@@indicative_of_oncogenic_human_papillomavirus_infection Bool)
(declare-const patient_has_undergone_colposcopy_inthehistory Bool)
(declare-const patient_has_undergone_colposcopy_inthehistory@@is_initial_evaluation Bool)
(declare-const patient_has_undergone_colposcopy_inthehistory@@was_referred_for_procedure Bool)
(declare-const patient_has_undergone_colposcopy_inthehistory@@performed_at_womens_care_center_temple_university_hospital Bool)
(declare-const patient_is_able_to_communicate_with_ease_in_english_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@recently_received@@indicative_of_oncogenic_human_papillomavirus_infection patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@recently_received) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@recently_received@@indicative_of_oncogenic_human_papillomavirus_infection patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@indicative_of_oncogenic_human_papillomavirus_infection) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@recently_received@@indicative_of_oncogenic_human_papillomavirus_infection patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@recently_received patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now) :named REQ1_AUXILIARY3))
(assert (! (=> patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@indicative_of_oncogenic_human_papillomavirus_infection patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now) :named REQ1_AUXILIARY4))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_colposcopy_inthehistory@@is_initial_evaluation patient_has_undergone_colposcopy_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_undergone_colposcopy_inthehistory@@performed_at_womens_care_center_temple_university_hospital patient_has_undergone_colposcopy_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_undergone_colposcopy_inthehistory@@was_referred_for_procedure patient_has_undergone_colposcopy_inthehistory) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_abnormal_cervical_papanicolaou_smear_now@@recently_received@@indicative_of_oncogenic_human_papillomavirus_infection :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_undergone_colposcopy_inthehistory patient_has_undergone_colposcopy_inthehistory@@is_initial_evaluation patient_has_undergone_colposcopy_inthehistory@@was_referred_for_procedure patient_has_undergone_colposcopy_inthehistory@@performed_at_womens_care_center_temple_university_hospital) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_able_to_communicate_with_ease_in_english_now :named REQ3_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
