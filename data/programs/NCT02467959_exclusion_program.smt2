;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_flank_pain_now Bool)
(declare-const patient_has_finding_of_flank_pain_now@@isolated Bool)
(declare-const patient_has_finding_of_flank_pain_now@@occurs_without_right_lower_abdominal_pain Bool)
(declare-const patient_has_finding_of_flank_pain_now@@isolated_without_right_lower_abdominal_pain Bool)
(declare-const patient_has_undergone_appendectomy_inthehistory Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_pregnant_now@@suspected_or_strong_clinical_support Bool)
(declare-const patient_has_finding_of_unstable_vital_signs_now Bool)
(declare-const patient_has_finding_of_peritonitis_now Bool)
(declare-const patient_has_finding_of_peritonitis_now@@frank Bool)
(declare-const patient_has_undergone_ultrasonography_inthehistory Bool)
(declare-const patient_has_undergone_ultrasonography_inthehistory@@performed_before_emergency_physician_examination Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_flank_pain_now@@isolated_without_right_lower_abdominal_pain (and patient_has_finding_of_flank_pain_now@@isolated patient_has_finding_of_flank_pain_now@@occurs_without_right_lower_abdominal_pain)) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_flank_pain_now@@isolated patient_has_finding_of_flank_pain_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_flank_pain_now@@occurs_without_right_lower_abdominal_pain patient_has_finding_of_flank_pain_now) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_finding_of_flank_pain_now@@isolated_without_right_lower_abdominal_pain patient_has_finding_of_flank_pain_now) :named REQ0_AUXILIARY3))
(assert (! (=> patient_has_finding_of_peritonitis_now@@frank patient_has_finding_of_peritonitis_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_undergone_ultrasonography_inthehistory@@performed_before_emergency_physician_examination patient_has_undergone_ultrasonography_inthehistory) :named REQ5_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_pregnant_now@@suspected_or_strong_clinical_support patient_is_pregnant_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_flank_pain_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_appendectomy_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now@@suspected_or_strong_clinical_support) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_unstable_vital_signs_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_peritonitis_now@@frank) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_ultrasonography_inthehistory@@performed_before_emergency_physician_examination) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
