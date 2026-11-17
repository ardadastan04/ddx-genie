;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_child_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_has_internal_defibrillator_now Bool)
(declare-const patient_has_external_defibrillator_now Bool)
(declare-const patient_has_undergone_surgical_procedure_inthehistory Bool)
(declare-const patient_has_finding_of_incision_now Bool)
(declare-const patient_has_finding_of_incision_now@@is_fresh Bool)
(declare-const patient_has_finding_of_incision_now@@located_on_chest Bool)
(declare-const patient_has_finding_of_injury_of_integument_now Bool)
(declare-const patient_has_finding_of_injury_of_integument_now@@located_on_chest Bool)
(declare-const patient_has_finding_of_burn_of_chest_wall_now Bool)
(declare-const patient_has_finding_of_skin_irritation_now Bool)
(declare-const patient_has_finding_of_skin_irritation_now@@located_on_chest Bool)
(declare-const patient_has_finding_of_infectious_disease_now Bool)
(declare-const patient_has_finding_of_infectious_disease_now@@located_on_chest Bool)
(declare-const patient_has_finding_of_wound_now Bool)
(declare-const patient_has_finding_of_wound_now@@located_on_chest Bool)
(declare-const patient_is_in_critical_care_unit_now Bool)
(declare-const patient_satisfies_contraindication_associated_with_vsp_system_now Bool)
(declare-const patient_satisfies_contraindication_associated_with_vsp_system_now@@associated_with_vsp_system Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_incision_now@@is_fresh patient_has_finding_of_incision_now) :named REQ3_AUXILIARY0))
(assert (! (=> patient_has_finding_of_incision_now@@located_on_chest patient_has_finding_of_incision_now) :named REQ3_AUXILIARY1))
(assert (! (=> (or patient_has_finding_of_burn_of_chest_wall_now patient_has_finding_of_skin_irritation_now@@located_on_chest patient_has_finding_of_infectious_disease_now@@located_on_chest patient_has_finding_of_wound_now@@located_on_chest) patient_has_finding_of_injury_of_integument_now@@located_on_chest) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_finding_of_injury_of_integument_now@@located_on_chest patient_has_finding_of_injury_of_integument_now) :named REQ4_AUXILIARY1))
(assert (! (=> patient_has_finding_of_skin_irritation_now@@located_on_chest patient_has_finding_of_skin_irritation_now) :named REQ4_AUXILIARY2))
(assert (! (=> patient_has_finding_of_infectious_disease_now@@located_on_chest patient_has_finding_of_infectious_disease_now) :named REQ4_AUXILIARY3))
(assert (! (=> patient_has_finding_of_wound_now@@located_on_chest patient_has_finding_of_wound_now) :named REQ4_AUXILIARY4))
(assert (! (=> patient_satisfies_contraindication_associated_with_vsp_system_now@@associated_with_vsp_system patient_satisfies_contraindication_associated_with_vsp_system_now) :named REQ6_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_is_child_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_sex_is_female_now patient_is_pregnant_now)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_internal_defibrillator_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_external_defibrillator_now) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_undergone_surgical_procedure_inthehistory patient_has_finding_of_incision_now@@is_fresh patient_has_finding_of_incision_now@@located_on_chest)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_injury_of_integument_now@@located_on_chest) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_in_critical_care_unit_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_satisfies_contraindication_associated_with_vsp_system_now) :named REQ6_COMPONENT0_OTHER_REQUIREMENTS))
