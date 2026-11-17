;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_neonatal_jaundice_within_24_hours_of_birth Bool)
(declare-const patient_has_finding_of_neonatal_jaundice_after_8_days_of_age Bool)
(declare-const patient_has_finding_of_hemolysis_now Bool)
(declare-const patient_has_finding_of_hemolysis_now@@based_on_maternal_history Bool)
(declare-const patient_is_exposed_to_irregular_blood_group_antibody_now Bool)
(declare-const patient_has_finding_of_kernicterus_of_newborn_now Bool)
(declare-const patient_is_neonate_now Bool)
(declare-const patient_is_undergoing_light_therapy_now Bool)
(declare-const patient_has_undergone_light_therapy_inthehistory Bool)
(declare-const patient_has_finding_of_congenital_malformation_now Bool)
(declare-const patient_has_finding_of_congenital_malformation_now@@is_large Bool)
(declare-const patient_has_finding_of_congenital_malformation_now@@located_at_forehead Bool)
(declare-const patient_has_finding_of_congenital_malformation_now@@located_at_sternum Bool)
(declare-const patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_forehead Bool)
(declare-const patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_sternum Bool)
(declare-const patient_has_finding_of_serum_bilirubin_level_finding_inthehistory Bool)
(declare-const patient_has_finding_of_serum_bilirubin_level_finding_inthehistory@@before_admission_to_pediatric_ward Bool)
(declare-const patient_has_finding_of_serum_bilirubin_level_finding_now Bool)
(declare-const patient_has_finding_of_serum_bilirubin_level_finding_now@@has_reached_phototherapy_limit Bool)
(declare-const patient_has_finding_of_serum_bilirubin_level_finding_now@@has_reached_exchange_transfusion_limit Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_irregular_blood_group_antibody_now patient_has_finding_of_hemolysis_now@@based_on_maternal_history) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_hemolysis_now@@based_on_maternal_history patient_has_finding_of_hemolysis_now) :named REQ1_AUXILIARY1))
(assert (! (= patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_forehead (and patient_has_finding_of_congenital_malformation_now@@is_large patient_has_finding_of_congenital_malformation_now@@located_at_forehead)) :named REQ4_AUXILIARY0))
(assert (! (= patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_sternum (and patient_has_finding_of_congenital_malformation_now@@is_large patient_has_finding_of_congenital_malformation_now@@located_at_sternum)) :named REQ4_AUXILIARY1))
(assert (! (=> patient_has_finding_of_congenital_malformation_now@@is_large patient_has_finding_of_congenital_malformation_now) :named REQ4_AUXILIARY2))
(assert (! (=> patient_has_finding_of_congenital_malformation_now@@located_at_forehead patient_has_finding_of_congenital_malformation_now) :named REQ4_AUXILIARY3))
(assert (! (=> patient_has_finding_of_congenital_malformation_now@@located_at_sternum patient_has_finding_of_congenital_malformation_now) :named REQ4_AUXILIARY4))
(assert (! (=> patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_forehead patient_has_finding_of_congenital_malformation_now@@is_large) :named REQ4_AUXILIARY5))
(assert (! (=> patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_forehead patient_has_finding_of_congenital_malformation_now@@located_at_forehead) :named REQ4_AUXILIARY6))
(assert (! (=> patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_sternum patient_has_finding_of_congenital_malformation_now@@is_large) :named REQ4_AUXILIARY7))
(assert (! (=> patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_sternum patient_has_finding_of_congenital_malformation_now@@located_at_sternum) :named REQ4_AUXILIARY8))
(assert (! (=> patient_has_finding_of_serum_bilirubin_level_finding_inthehistory@@before_admission_to_pediatric_ward patient_has_finding_of_serum_bilirubin_level_finding_inthehistory) :named REQ5_AUXILIARY0))
(assert (! (=> patient_has_finding_of_serum_bilirubin_level_finding_now@@has_reached_phototherapy_limit patient_has_finding_of_serum_bilirubin_level_finding_now) :named REQ5_AUXILIARY1))
(assert (! (=> patient_has_finding_of_serum_bilirubin_level_finding_now@@has_reached_exchange_transfusion_limit patient_has_finding_of_serum_bilirubin_level_finding_now) :named REQ5_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_forehead patient_has_finding_of_congenital_malformation_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_sternum patient_has_finding_of_congenital_malformation_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_neonatal_jaundice_within_24_hours_of_birth) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_neonatal_jaundice_after_8_days_of_age) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_hemolysis_now@@based_on_maternal_history) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_kernicterus_of_newborn_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_neonate_now patient_is_undergoing_light_therapy_now)) :named REQ3_COMPONENT0_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
(assert (! (not (and patient_is_neonate_now patient_has_undergone_light_therapy_inthehistory)) :named REQ3_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_forehead) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_congenital_malformation_now@@is_large@@located_at_sternum) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_serum_bilirubin_level_finding_inthehistory@@before_admission_to_pediatric_ward (or patient_has_finding_of_serum_bilirubin_level_finding_now@@has_reached_phototherapy_limit patient_has_finding_of_serum_bilirubin_level_finding_now@@has_reached_exchange_transfusion_limit))) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
