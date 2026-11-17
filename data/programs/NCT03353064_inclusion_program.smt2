;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_carbon_dioxide_measurement_partial_pressure_value_recorded_now_withunit_mm_hg Real)
(declare-const patient_has_finding_of_hypercapnia_now Bool)
(declare-const patient_has_finding_of_hypercapnia_now@@secondary_to_chronic_obstructive_pulmonary_disease_and_obstructive_sleep_apnea_overlap Bool)
(declare-const patient_has_finding_of_hypercapnia_now@@secondary_to_obesity_hypoventilation_syndrome Bool)
(declare-const patient_has_finding_of_hypercapnia_now@@secondary_to_neuromuscular_disease Bool)
(declare-const patient_has_finding_of_hypercapnia_now@@secondary_to_neuromuscular_weakness Bool)
(declare-const evidence_of_hypercapnia_now Bool)
(declare-const patient_requires_non_invasive_ventilation_now Bool)
(declare-const patient_requires_non_invasive_positive_pressure_ventilation_now_as_outpatient Bool)

;; Existing auxiliary assertions
(assert (! (= evidence_of_hypercapnia_now (>= patient_carbon_dioxide_measurement_partial_pressure_value_recorded_now_withunit_mm_hg 45.0)) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_hypercapnia_now@@secondary_to_chronic_obstructive_pulmonary_disease_and_obstructive_sleep_apnea_overlap patient_has_finding_of_hypercapnia_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_hypercapnia_now@@secondary_to_obesity_hypoventilation_syndrome patient_has_finding_of_hypercapnia_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_finding_of_hypercapnia_now@@secondary_to_neuromuscular_disease patient_has_finding_of_hypercapnia_now) :named REQ1_AUXILIARY3))
(assert (! (=> patient_has_finding_of_hypercapnia_now@@secondary_to_neuromuscular_weakness patient_has_finding_of_hypercapnia_now) :named REQ1_AUXILIARY4))

;; Other kept assertions
(assert (! (> patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or (and evidence_of_hypercapnia_now patient_has_finding_of_hypercapnia_now@@secondary_to_chronic_obstructive_pulmonary_disease_and_obstructive_sleep_apnea_overlap) (and evidence_of_hypercapnia_now patient_has_finding_of_hypercapnia_now@@secondary_to_obesity_hypoventilation_syndrome) (and evidence_of_hypercapnia_now patient_has_finding_of_hypercapnia_now@@secondary_to_neuromuscular_disease) (and evidence_of_hypercapnia_now patient_has_finding_of_hypercapnia_now@@secondary_to_neuromuscular_weakness)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_requires_non_invasive_ventilation_now patient_requires_non_invasive_positive_pressure_ventilation_now_as_outpatient) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
