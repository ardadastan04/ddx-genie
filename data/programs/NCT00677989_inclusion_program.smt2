;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_provided_informed_consent_now Bool)
(declare-const patient_has_provided_informed_consent_now@@provided_by_patient Bool)
(declare-const patient_has_undergone_physical_examination_now Bool)
(declare-const patient_has_undergone_physical_examination_now@@result_favors_diagnosis_of_perforated_acute_appendicitis Bool)
(declare-const patient_has_undergone_ct_of_abdomen_now Bool)
(declare-const patient_has_undergone_ct_of_abdomen_now@@result_reveals_signs_of_acute_appendicitis Bool)
(declare-const patient_has_undergone_ct_of_abdomen_now@@result_reveals_intra_abdominal_fluid_accumulation Bool)
(declare-const patient_has_undergone_physical_examination_now@@result_favors_diagnosis_of_perforated_acute_appendicitis@@remains_most_likely_diagnosis Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_provided_informed_consent_now@@provided_by_patient patient_has_provided_informed_consent_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_physical_examination_now@@result_favors_diagnosis_of_perforated_acute_appendicitis patient_has_undergone_physical_examination_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_undergone_ct_of_abdomen_now@@result_reveals_signs_of_acute_appendicitis patient_has_undergone_ct_of_abdomen_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_undergone_ct_of_abdomen_now@@result_reveals_intra_abdominal_fluid_accumulation patient_has_undergone_ct_of_abdomen_now) :named REQ1_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_undergone_physical_examination_now@@result_favors_diagnosis_of_perforated_acute_appendicitis@@remains_most_likely_diagnosis patient_has_undergone_physical_examination_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 12.0) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (<= patient_age_value_recorded_now_in_years 80.0) :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_undergone_physical_examination_now@@result_favors_diagnosis_of_perforated_acute_appendicitis :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_ct_of_abdomen_now@@result_reveals_signs_of_acute_appendicitis :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_ct_of_abdomen_now@@result_reveals_intra_abdominal_fluid_accumulation :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_physical_examination_now@@result_favors_diagnosis_of_perforated_acute_appendicitis@@remains_most_likely_diagnosis :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
