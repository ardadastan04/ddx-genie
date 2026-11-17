;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=2
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_loose_stool_value_recorded_inthepast24hours_withunit_count Real)
(declare-const patient_loose_stool_value_recorded_inthepast24hours_withunit_count@@prior_to_initiation_of_antibiotic_therapy Bool)
(declare-const patient_liquid_stool_value_recorded_inthepast24hours_withunit_count Real)
(declare-const patient_liquid_stool_value_recorded_inthepast24hours_withunit_count@@prior_to_initiation_of_antibiotic_therapy Bool)
(declare-const patient_is_hospitalized_now Bool)
(declare-const patient_is_undergoing_antibiotic_therapy_now@@for_clostridium_difficile_infection Bool)
(declare-const patient_is_undergoing_antibiotic_therapy_now@@for_recurrent_clostridium_difficile_infection Bool)
(declare-const patient_has_undergone_stool_culture_now_outcome_is_positive Bool)
(declare-const patient_is_undergoing_antibiotic_therapy_now Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_undergoing_antibiotic_therapy_now@@for_clostridium_difficile_infection patient_is_undergoing_antibiotic_therapy_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_is_undergoing_antibiotic_therapy_now@@for_recurrent_clostridium_difficile_infection patient_is_undergoing_antibiotic_therapy_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and patient_loose_stool_value_recorded_inthepast24hours_withunit_count@@prior_to_initiation_of_antibiotic_therapy (>= patient_loose_stool_value_recorded_inthepast24hours_withunit_count 2)) (and patient_liquid_stool_value_recorded_inthepast24hours_withunit_count@@prior_to_initiation_of_antibiotic_therapy (>= patient_liquid_stool_value_recorded_inthepast24hours_withunit_count 2))) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and patient_is_hospitalized_now patient_is_undergoing_antibiotic_therapy_now@@for_clostridium_difficile_infection) (and patient_is_hospitalized_now patient_is_undergoing_antibiotic_therapy_now@@for_recurrent_clostridium_difficile_infection patient_has_undergone_stool_culture_now_outcome_is_positive)) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
