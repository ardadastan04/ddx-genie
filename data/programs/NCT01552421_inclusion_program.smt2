;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_undergoing_cholecystectomy_now Bool)
(declare-const patient_is_undergoing_cholecystectomy_now@@due_to_symptomatic_gallstones Bool)
(declare-const patient_is_undergoing_cholecystectomy_now@@due_to_gallstone_induced_mild_pancreatitis Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_asa_classification_i_now Bool)
(declare-const patient_has_asa_classification_ii_now Bool)
(declare-const patient_has_asa_classification_iii_now Bool)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_cholecystectomy_now@@due_to_symptomatic_gallstones patient_is_undergoing_cholecystectomy_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_undergoing_cholecystectomy_now@@due_to_gallstone_induced_mild_pancreatitis patient_is_undergoing_cholecystectomy_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (or patient_is_undergoing_cholecystectomy_now@@due_to_symptomatic_gallstones patient_is_undergoing_cholecystectomy_now@@due_to_gallstone_induced_mild_pancreatitis) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_sex_is_female_now :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 70) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or patient_has_asa_classification_i_now patient_has_asa_classification_ii_now patient_has_asa_classification_iii_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (< patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 30) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
