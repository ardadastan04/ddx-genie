;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=8 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_lesion_of_brain_now@@interpreted_as_suspected_infiltrating_glioma Bool)
(declare-const patient_has_finding_of_astrocytoma_of_brain_now@@diffuse Bool)
(declare-const patient_has_finding_of_astrocytoma_of_brain_now@@who_grade_2 Bool)
(declare-const patient_has_finding_of_oligodendroglioma_of_brain_now@@who_grade_2@@new@@interpreted_as_suspected_infiltrating_glioma Bool)
(declare-const patient_has_finding_of_oligodendroglioma_of_brain_now@@who_grade_3@@new@@interpreted_as_suspected_infiltrating_glioma Bool)
(declare-const patient_has_finding_of_astrocytoma_of_brain_now@@anaplastic Bool)
(declare-const patient_has_finding_of_astrocytoma_of_brain_now@@who_grade_3 Bool)
(declare-const patient_has_finding_of_astrocytoma_of_brain_now@@who_grade_4 Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_can_undergo_mri_with_contrast_now Bool)
(declare-const patient_has_undergone_serum_pregnancy_test_ever Bool)
(declare-const patient_is_pregnant_now Bool)
(declare-const serum_pregnancy_test_result_value_withunit_mIU_per_mL Real)
(declare-const patient_has_finding_of_oligodendroglioma_of_brain_now Bool)
(declare-const patient_has_finding_of_astrocytoma_of_brain_now Bool)
(declare-const patient_has_finding_of_lesion_of_brain_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or (and patient_has_finding_of_astrocytoma_of_brain_now@@diffuse patient_has_finding_of_astrocytoma_of_brain_now@@who_grade_2) patient_has_finding_of_oligodendroglioma_of_brain_now@@who_grade_2@@new@@interpreted_as_suspected_infiltrating_glioma patient_has_finding_of_oligodendroglioma_of_brain_now@@who_grade_3@@new@@interpreted_as_suspected_infiltrating_glioma (and patient_has_finding_of_astrocytoma_of_brain_now@@anaplastic patient_has_finding_of_astrocytoma_of_brain_now@@who_grade_3) patient_has_finding_of_astrocytoma_of_brain_now@@who_grade_4) patient_has_finding_of_lesion_of_brain_now@@interpreted_as_suspected_infiltrating_glioma) :named REQ0_AUXILIARY0))
(assert (! (=> (< serum_pregnancy_test_result_value_withunit_mIU_per_mL 5.0) (not patient_is_pregnant_now)) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_astrocytoma_of_brain_now@@anaplastic patient_has_finding_of_astrocytoma_of_brain_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_astrocytoma_of_brain_now@@diffuse patient_has_finding_of_astrocytoma_of_brain_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_astrocytoma_of_brain_now@@who_grade_2 patient_has_finding_of_astrocytoma_of_brain_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_finding_of_astrocytoma_of_brain_now@@who_grade_3 patient_has_finding_of_astrocytoma_of_brain_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))
(assert (! (=> patient_has_finding_of_astrocytoma_of_brain_now@@who_grade_4 patient_has_finding_of_astrocytoma_of_brain_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_4))
(assert (! (=> patient_has_finding_of_lesion_of_brain_now@@interpreted_as_suspected_infiltrating_glioma patient_has_finding_of_lesion_of_brain_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_5))
(assert (! (=> patient_has_finding_of_oligodendroglioma_of_brain_now@@who_grade_2@@new@@interpreted_as_suspected_infiltrating_glioma patient_has_finding_of_oligodendroglioma_of_brain_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_6))
(assert (! (=> patient_has_finding_of_oligodendroglioma_of_brain_now@@who_grade_3@@new@@interpreted_as_suspected_infiltrating_glioma patient_has_finding_of_oligodendroglioma_of_brain_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_7))

;; Other kept assertions
(assert (! patient_has_finding_of_lesion_of_brain_now@@interpreted_as_suspected_infiltrating_glioma :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 80.0) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_can_undergo_mri_with_contrast_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (and patient_has_undergone_serum_pregnancy_test_ever (< serum_pregnancy_test_result_value_withunit_mIU_per_mL 5.0)) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
