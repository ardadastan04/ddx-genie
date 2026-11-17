;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_tissue_necrosis_now@@located_in_area_of_appendicular_stump Bool)
(declare-const patient_has_finding_of_advanced_inflammatory_changes_now@@located_in_area_of_appendicular_stump@@at_time_of_laparoscopic_appendectomy Bool)
(declare-const patient_has_finding_of_tissue_necrosis_now Bool)
(declare-const patient_has_finding_of_advanced_inflammatory_changes_now Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_advanced_inflammatory_changes_now@@located_in_area_of_appendicular_stump@@at_time_of_laparoscopic_appendectomy patient_has_finding_of_advanced_inflammatory_changes_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_tissue_necrosis_now@@located_in_area_of_appendicular_stump patient_has_finding_of_tissue_necrosis_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not patient_has_finding_of_tissue_necrosis_now@@located_in_area_of_appendicular_stump) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_advanced_inflammatory_changes_now@@located_in_area_of_appendicular_stump@@at_time_of_laparoscopic_appendectomy) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
