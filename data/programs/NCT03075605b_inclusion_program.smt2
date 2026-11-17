;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_unrelated_family_member Bool)
(declare-const patient_is_friend_of_subject Bool)
(declare-const patient_is_undergoing_phlebotomy_now@@occurs_in_general_medicine_outpatient_clinic Bool)
(declare-const patient_has_diagnosis_of_pancreatitis_inthehistory Bool)
(declare-const patient_is_undergoing_phlebotomy_now Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_undergoing_phlebotomy_now@@occurs_in_general_medicine_outpatient_clinic patient_is_undergoing_phlebotomy_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (or patient_sex_is_male_now (and patient_sex_is_female_now (>= patient_age_value_recorded_now_in_years 18))) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_is_unrelated_family_member patient_is_friend_of_subject (and patient_is_undergoing_phlebotomy_now@@occurs_in_general_medicine_outpatient_clinic (not patient_has_diagnosis_of_pancreatitis_inthehistory))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
