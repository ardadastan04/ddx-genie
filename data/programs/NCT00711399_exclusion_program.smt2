;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_insertion_of_pleural_tube_drain_now Bool)
(declare-const patient_has_chest_tube_now Bool)
(declare-const patient_has_finding_of_skin_lesion_now Bool)
(declare-const patient_has_finding_of_skin_lesion_now@@precludes_attachment_of_sensors Bool)
(declare-const patient_skin_lesion_count_now Real)
(declare-const patient_has_finding_of_skin_lesion_now@@precludes_attachment_of_sensors@@strong_clinical_support Bool)
(declare-const patient_has_finding_of_respiratory_distress_now Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const patient_sex_is_female_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_insertion_of_pleural_tube_drain_now patient_has_chest_tube_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_skin_lesion_now@@precludes_attachment_of_sensors patient_has_finding_of_skin_lesion_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_skin_lesion_now@@precludes_attachment_of_sensors (>= patient_skin_lesion_count_now 1.0)) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_skin_lesion_now@@precludes_attachment_of_sensors@@strong_clinical_support patient_has_finding_of_skin_lesion_now@@precludes_attachment_of_sensors) :named REQ1_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_skin_lesion_now@@precludes_attachment_of_sensors@@strong_clinical_support patient_has_finding_of_skin_lesion_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not patient_has_chest_tube_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or patient_has_finding_of_skin_lesion_now@@precludes_attachment_of_sensors patient_has_finding_of_skin_lesion_now@@precludes_attachment_of_sensors@@strong_clinical_support)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_respiratory_distress_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_is_pregnant_now patient_sex_is_female_now)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
