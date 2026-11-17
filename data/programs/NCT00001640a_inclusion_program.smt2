;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_autosomal_dominant_late_onset_parkinson_disease_now Bool)
(declare-const patient_has_finding_of_autosomal_dominant_late_onset_parkinson_disease_now@@apparently_being_inherited_in_the_patients_family Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now Bool)
(declare-const patient_has_diagnosis_of_parkinson_s_disease_now@@supported_by_tremor_bradykinesia_and_responsiveness_to_levodopa Bool)
(declare-const patient_has_finding_of_tremor_now Bool)
(declare-const patient_has_finding_of_bradykinesia_now Bool)
(declare-const patient_is_exposed_to_levodopa_now@@responsiveness Bool)
(declare-const patient_has_finding_of_dementia_associated_with_parkinson_s_disease_now Bool)
(declare-const patient_is_exposed_to_levodopa_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_autosomal_dominant_late_onset_parkinson_disease_now@@apparently_being_inherited_in_the_patients_family patient_has_finding_of_autosomal_dominant_late_onset_parkinson_disease_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_parkinson_s_disease_now@@supported_by_tremor_bradykinesia_and_responsiveness_to_levodopa patient_has_diagnosis_of_parkinson_s_disease_now) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_diagnosis_of_parkinson_s_disease_now@@supported_by_tremor_bradykinesia_and_responsiveness_to_levodopa (and patient_has_finding_of_tremor_now patient_has_finding_of_bradykinesia_now patient_is_exposed_to_levodopa_now@@responsiveness)) :named REQ1_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_exposed_to_levodopa_now@@responsiveness patient_is_exposed_to_levodopa_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18.0) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_autosomal_dominant_late_onset_parkinson_disease_now@@apparently_being_inherited_in_the_patients_family :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_parkinson_s_disease_now@@supported_by_tremor_bradykinesia_and_responsiveness_to_levodopa :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_dementia_associated_with_parkinson_s_disease_now :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! true :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
