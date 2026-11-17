;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_sex_is_male_now Bool)
(declare-const patient_asa_physical_status_classification_value_now Int)
(declare-const patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 Real)
(declare-const patient_will_undergo_laparoscopic_cholecystectomy_inthefuture Bool)
(declare-const patient_will_undergo_laparoscopic_cholecystectomy_inthefuture@@is_elective Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_will_undergo_laparoscopic_cholecystectomy_inthefuture@@is_elective patient_will_undergo_laparoscopic_cholecystectomy_inthefuture) :named REQ5_AUXILIARY0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 21) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 45) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or patient_sex_is_female_now patient_sex_is_male_now) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (= patient_asa_physical_status_classification_value_now 1) (= patient_asa_physical_status_classification_value_now 2)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 25.0) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_finding_of_body_mass_index_value_recorded_now_withunit_kg_per_m2 35.0) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_will_undergo_laparoscopic_cholecystectomy_inthefuture@@is_elective :named REQ5_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
