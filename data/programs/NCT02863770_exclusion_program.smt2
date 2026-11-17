;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_is_lactating_now Bool)
(declare-const patient_has_finding_of_preinfarction_syndrome_now Bool)
(declare-const patient_has_finding_of_right_to_left_cardiac_shunt_now Bool)
(declare-const patient_has_finding_of_right_to_left_cardiac_shunt_now@@known Bool)
(declare-const patient_has_finding_of_right_to_left_cardiac_shunt_now@@suspected Bool)
(declare-const patient_has_finding_of_right_to_left_cardiac_shunt_now@@transient Bool)
(declare-const patient_has_finding_of_right_to_left_cardiac_shunt_now@@known@@transient Bool)
(declare-const patient_has_finding_of_right_to_left_cardiac_shunt_now@@suspected@@transient Bool)
(declare-const patient_has_finding_of_bidirectional_cardiac_shunt_now Bool)
(declare-const patient_has_finding_of_bidirectional_cardiac_shunt_now@@known Bool)
(declare-const patient_has_finding_of_bidirectional_cardiac_shunt_now@@suspected Bool)
(declare-const patient_has_allergy_to_definity_ever Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_right_to_left_cardiac_shunt_now@@known patient_has_finding_of_right_to_left_cardiac_shunt_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_right_to_left_cardiac_shunt_now@@suspected patient_has_finding_of_right_to_left_cardiac_shunt_now) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_finding_of_right_to_left_cardiac_shunt_now@@transient patient_has_finding_of_right_to_left_cardiac_shunt_now) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_finding_of_right_to_left_cardiac_shunt_now@@known@@transient (and patient_has_finding_of_right_to_left_cardiac_shunt_now@@known patient_has_finding_of_right_to_left_cardiac_shunt_now@@transient)) :named REQ2_AUXILIARY3))
(assert (! (=> patient_has_finding_of_right_to_left_cardiac_shunt_now@@suspected@@transient (and patient_has_finding_of_right_to_left_cardiac_shunt_now@@suspected patient_has_finding_of_right_to_left_cardiac_shunt_now@@transient)) :named REQ2_AUXILIARY4))
(assert (! (=> patient_has_finding_of_bidirectional_cardiac_shunt_now@@known patient_has_finding_of_bidirectional_cardiac_shunt_now) :named REQ2_AUXILIARY5))
(assert (! (=> patient_has_finding_of_bidirectional_cardiac_shunt_now@@suspected patient_has_finding_of_bidirectional_cardiac_shunt_now) :named REQ2_AUXILIARY6))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_right_to_left_cardiac_shunt_now@@known@@transient patient_has_finding_of_right_to_left_cardiac_shunt_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_right_to_left_cardiac_shunt_now@@suspected@@transient patient_has_finding_of_right_to_left_cardiac_shunt_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not (< patient_age_value_recorded_now_in_years 18)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_pregnant_now) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_is_lactating_now) :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_preinfarction_syndrome_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_right_to_left_cardiac_shunt_now@@known) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_right_to_left_cardiac_shunt_now@@suspected) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_bidirectional_cardiac_shunt_now@@known) :named REQ2_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_bidirectional_cardiac_shunt_now@@suspected) :named REQ2_COMPONENT3_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_right_to_left_cardiac_shunt_now@@known@@transient) :named REQ2_COMPONENT4_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_right_to_left_cardiac_shunt_now@@suspected@@transient) :named REQ2_COMPONENT5_OTHER_REQUIREMENTS))
(assert (! (not patient_has_allergy_to_definity_ever) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
