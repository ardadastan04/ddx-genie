;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const number_of_community_based_outpatient_centers_involved_in_primary_care_management_in_past_6_months Real)
(declare-const patient_has_undergone_primary_care_management_inthepast6months Bool)
(declare-const patient_has_undergone_primary_care_management_inthepast6months@@obtained_at_more_than_one_site Bool)
(declare-const patient_has_undergone_primary_care_management_inthepast6months@@evidence_of_more_than_one_community_based_outpatient_center_involved_in_care Bool)
(declare-const patient_has_diagnosis_of_dementia_now Bool)
(declare-const patient_has_finding_of_aphasia_now Bool)
(declare-const patient_has_finding_of_aphasia_now@@documented Bool)
(declare-const patient_has_diagnosis_of_psychotic_disorder_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_undergone_primary_care_management_inthepast6months@@evidence_of_more_than_one_community_based_outpatient_center_involved_in_care (and patient_has_undergone_primary_care_management_inthepast6months (> number_of_community_based_outpatient_centers_involved_in_primary_care_management_in_past_6_months 1))) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_undergone_primary_care_management_inthepast6months@@obtained_at_more_than_one_site (and patient_has_undergone_primary_care_management_inthepast6months patient_has_undergone_primary_care_management_inthepast6months@@evidence_of_more_than_one_community_based_outpatient_center_involved_in_care)) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_primary_care_management_inthepast6months@@obtained_at_more_than_one_site patient_has_undergone_primary_care_management_inthepast6months) :named REQ0_AUXILIARY2))
(assert (! (=> patient_has_undergone_primary_care_management_inthepast6months@@evidence_of_more_than_one_community_based_outpatient_center_involved_in_care patient_has_undergone_primary_care_management_inthepast6months) :named REQ0_AUXILIARY3))
(assert (! (=> patient_has_finding_of_aphasia_now@@documented patient_has_finding_of_aphasia_now) :named REQ2_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_undergone_primary_care_management_inthepast6months@@obtained_at_more_than_one_site) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_dementia_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_aphasia_now@@documented) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_psychotic_disorder_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
