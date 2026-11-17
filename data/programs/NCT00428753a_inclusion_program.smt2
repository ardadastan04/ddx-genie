;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_adult_now Bool)
(declare-const patient_is_child_now Bool)
(declare-const patient_is_child_older_than_1_year_now Bool)
(declare-const patient_has_finding_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_inthehistory Bool)
(declare-const patient_has_finding_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_inthehistory@@detected_in_a_previous_surveillance_program Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_child_older_than_1_year_now (and patient_is_child_now (> patient_age_value_recorded_now_in_years 1.0))) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_inthehistory@@detected_in_a_previous_surveillance_program patient_has_finding_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_inthehistory) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (or patient_is_adult_now patient_is_child_older_than_1_year_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_finding_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_inthehistory patient_has_finding_of_influenza_caused_by_influenza_a_virus_subtype_h5n1_inthehistory@@detected_in_a_previous_surveillance_program) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
