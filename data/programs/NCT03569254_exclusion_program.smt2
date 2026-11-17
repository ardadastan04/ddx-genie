;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const parent_is_available_to_stay_in_kangaroo_mother_care_ambulatory_program Bool)
(declare-const parent_total_hours_available_to_stay_in_kangaroo_mother_care_ambulatory_program_per_day Real)
(declare-const patient_has_finding_of_skin_lesion_now Bool)
(declare-const patient_has_finding_of_skin_lesion_now@@caused_by_burns Bool)
(declare-const patient_has_finding_of_skin_lesion_now@@caused_by_sloughing Bool)
(declare-const patient_has_finding_of_skin_lesion_now@@extensive Bool)
(declare-const patient_has_finding_of_skin_lesion_now@@extensive@@caused_by_burns Bool)
(declare-const patient_has_finding_of_skin_lesion_now@@extensive@@caused_by_sloughing Bool)

;; Existing auxiliary assertions
(assert (! (= parent_is_available_to_stay_in_kangaroo_mother_care_ambulatory_program (>= parent_total_hours_available_to_stay_in_kangaroo_mother_care_ambulatory_program_per_day 6)) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_finding_of_skin_lesion_now@@extensive@@caused_by_burns (and patient_has_finding_of_skin_lesion_now@@extensive patient_has_finding_of_skin_lesion_now@@caused_by_burns)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_finding_of_skin_lesion_now@@extensive@@caused_by_sloughing (and patient_has_finding_of_skin_lesion_now@@extensive patient_has_finding_of_skin_lesion_now@@caused_by_sloughing)) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_skin_lesion_now@@extensive patient_has_finding_of_skin_lesion_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_finding_of_skin_lesion_now@@caused_by_burns patient_has_finding_of_skin_lesion_now) :named REQ1_AUXILIARY3))
(assert (! (=> patient_has_finding_of_skin_lesion_now@@caused_by_sloughing patient_has_finding_of_skin_lesion_now) :named REQ1_AUXILIARY4))
(assert (! (=> patient_has_finding_of_skin_lesion_now@@extensive@@caused_by_burns patient_has_finding_of_skin_lesion_now@@extensive) :named REQ1_AUXILIARY5))
(assert (! (=> patient_has_finding_of_skin_lesion_now@@extensive@@caused_by_sloughing patient_has_finding_of_skin_lesion_now@@extensive) :named REQ1_AUXILIARY6))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_skin_lesion_now@@extensive@@caused_by_burns patient_has_finding_of_skin_lesion_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_skin_lesion_now@@extensive@@caused_by_sloughing patient_has_finding_of_skin_lesion_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not parent_is_available_to_stay_in_kangaroo_mother_care_ambulatory_program) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_skin_lesion_now@@extensive@@caused_by_burns) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_skin_lesion_now@@extensive@@caused_by_sloughing) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
