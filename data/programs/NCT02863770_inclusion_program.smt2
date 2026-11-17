;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_undergoing_endoscopic_ultrasonography_now Bool)
(declare-const patient_is_undergoing_endoscopic_ultrasonography_now@@for_standard_pancreatic_indications Bool)
(declare-const patient_has_finding_of_idiopathic_acute_pancreatitis_now Bool)
(declare-const patient_has_finding_of_mass_of_pancreas_now Bool)
(declare-const patient_has_finding_of_cyst_of_pancreas_now Bool)
(declare-const patient_has_finding_of_cyst_of_pancreas_now@@greater_than_1_cm Bool)
(declare-const patient_has_finding_of_cyst_of_pancreas_now@@worrisome_features_on_imaging Bool)
(declare-const patient_has_finding_of_pancreatic_cystic_lesion_with_criteria_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_endoscopic_ultrasonography_now@@for_standard_pancreatic_indications patient_is_undergoing_endoscopic_ultrasonography_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_finding_of_pancreatic_cystic_lesion_with_criteria_now (and patient_has_finding_of_cyst_of_pancreas_now (or patient_has_finding_of_cyst_of_pancreas_now@@greater_than_1_cm patient_has_finding_of_cyst_of_pancreas_now@@worrisome_features_on_imaging))) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_cyst_of_pancreas_now@@greater_than_1_cm patient_has_finding_of_cyst_of_pancreas_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_cyst_of_pancreas_now@@worrisome_features_on_imaging patient_has_finding_of_cyst_of_pancreas_now) :named REQ1_AUXILIARY2))

;; Other kept assertions
(assert (! patient_is_undergoing_endoscopic_ultrasonography_now@@for_standard_pancreatic_indications :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or patient_has_finding_of_idiopathic_acute_pancreatitis_now patient_has_finding_of_mass_of_pancreas_now patient_has_finding_of_pancreatic_cystic_lesion_with_criteria_now) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
