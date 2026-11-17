;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_exacerbation_now Bool)
(declare-const patient_is_in_clinical_validation_group Bool)
(declare-const patient_is_in_clinical_validation_group@@in_groups_other_than_clinical_validation_group Bool)
(declare-const patient_is_undergoing_computed_tomography_now Bool)
(declare-const patient_is_undergoing_computed_tomography_now@@at_time_of_exacerbation Bool)
(declare-const patient_is_undergoing_physical_examination_now Bool)
(declare-const patient_is_undergoing_physical_examination_now@@at_time_of_exacerbation Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_computed_tomography_now@@at_time_of_exacerbation patient_is_undergoing_computed_tomography_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_undergoing_physical_examination_now@@at_time_of_exacerbation patient_is_undergoing_physical_examination_now) :named REQ0_AUXILIARY1))
(assert (! (= patient_is_in_clinical_validation_group@@in_groups_other_than_clinical_validation_group (not patient_is_in_clinical_validation_group)) :named REQ0_AUXILIARY2))
(assert (! (= (or patient_is_undergoing_physical_examination_now@@at_time_of_exacerbation patient_is_undergoing_computed_tomography_now@@at_time_of_exacerbation) (and patient_has_exacerbation_now (or patient_is_undergoing_physical_examination_now patient_is_undergoing_computed_tomography_now))) :named REQ0_AUXILIARY3))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_in_clinical_validation_group@@in_groups_other_than_clinical_validation_group patient_is_in_clinical_validation_group) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not (or (and patient_is_in_clinical_validation_group (or patient_is_undergoing_physical_examination_now@@at_time_of_exacerbation patient_is_undergoing_computed_tomography_now@@at_time_of_exacerbation)) patient_is_in_clinical_validation_group@@in_groups_other_than_clinical_validation_group)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
