;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const number_of_previous_episodes_of_clostridioides_difficile_infection_in_the_past_6_months Real)
(declare-const patient_has_diagnosis_of_chronic_disease_now Bool)
(declare-const patient_has_diagnosis_of_chronic_disease_now@@associated_with_chronic_diarrhea Bool)
(declare-const patient_has_diagnosis_of_inflammatory_bowel_disease_now Bool)
(declare-const patient_has_diagnosis_of_irritable_bowel_syndrome_with_diarrhea_now Bool)
(declare-const patient_has_received_therapy_for_clostridium_difficile_infection_prior_to_randomization Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_diagnosis_of_inflammatory_bowel_disease_now patient_has_diagnosis_of_irritable_bowel_syndrome_with_diarrhea_now) patient_has_diagnosis_of_chronic_disease_now@@associated_with_chronic_diarrhea) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_chronic_disease_now@@associated_with_chronic_diarrhea patient_has_diagnosis_of_chronic_disease_now) :named REQ1_AUXILIARY1))

;; Other kept assertions
(assert (! (not (>= number_of_previous_episodes_of_clostridioides_difficile_infection_in_the_past_6_months 1)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_diagnosis_of_chronic_disease_now@@associated_with_chronic_diarrhea) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_received_therapy_for_clostridium_difficile_infection_prior_to_randomization) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
