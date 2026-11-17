;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_been_admitted_to_hospital_unit_5_central_at_university_of_virginia Bool)
(declare-const patient_has_been_admitted_to_hospital_unit_6_west_at_university_of_virginia Bool)
(declare-const patient_has_been_admitted_to_hospital_unit_short_stay_unit_at_university_of_virginia Bool)
(declare-const patient_has_foley_urethral_catheter_in_place_now Bool)
(declare-const patient_has_undergone_removal_of_urethral_catheter_inthehistory Bool)
(declare-const patient_has_undergone_removal_of_urethral_catheter_inthehistory@@ordered_by_physician Bool)
(declare-const patient_age_value_recorded_now_in_years Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_removal_of_urethral_catheter_inthehistory@@ordered_by_physician patient_has_undergone_removal_of_urethral_catheter_inthehistory) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (or patient_has_been_admitted_to_hospital_unit_5_central_at_university_of_virginia patient_has_been_admitted_to_hospital_unit_6_west_at_university_of_virginia patient_has_been_admitted_to_hospital_unit_short_stay_unit_at_university_of_virginia) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_foley_urethral_catheter_in_place_now :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
