;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_bicuspid_aortic_valve_now Bool)
(declare-const patient_has_finding_of_bicuspid_aortic_valve_now@@documented Bool)
(declare-const patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_clinical_imaging Bool)
(declare-const patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_computed_tomography Bool)
(declare-const patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_magnetic_resonance_imaging Bool)
(declare-const patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_echocardiogram Bool)
(declare-const patient_has_finding_of_individual_calcification_now Bool)
(declare-const patient_has_finding_of_individual_calcification_now@@minimal Bool)
(declare-const patient_has_finding_of_individual_calcification_now@@present_at_time_of_enrollment Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_bicuspid_aortic_valve_now@@documented patient_has_finding_of_bicuspid_aortic_valve_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_clinical_imaging patient_has_finding_of_bicuspid_aortic_valve_now) :named REQ1_AUXILIARY1))
(assert (! (=> (or patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_computed_tomography patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_magnetic_resonance_imaging patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_echocardiogram) patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_clinical_imaging) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_finding_of_individual_calcification_now@@minimal patient_has_finding_of_individual_calcification_now) :named REQ1_AUXILIARY3))
(assert (! (=> patient_has_finding_of_individual_calcification_now@@present_at_time_of_enrollment patient_has_finding_of_individual_calcification_now) :named REQ1_AUXILIARY4))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_computed_tomography patient_has_finding_of_bicuspid_aortic_valve_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_echocardiogram patient_has_finding_of_bicuspid_aortic_valve_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_magnetic_resonance_imaging patient_has_finding_of_bicuspid_aortic_valve_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_finding_of_bicuspid_aortic_valve_now@@documented patient_has_finding_of_bicuspid_aortic_valve_now@@identified_via_clinical_imaging) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (and patient_has_finding_of_individual_calcification_now@@minimal patient_has_finding_of_individual_calcification_now@@present_at_time_of_enrollment) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
