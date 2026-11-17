;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_contraindication_to_oral_therapy_now Bool)
(declare-const patient_has_contraindication_to_enteral_therapy_now Bool)
(declare-const patient_has_finding_of_clostridioides_difficile_infection_now Bool)
(declare-const patient_has_finding_of_clostridioides_difficile_infection_now@@fulminant Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now Bool)
(declare-const patient_has_finding_of_disease_condition_finding_now@@acutely_life_threatening Bool)
(declare-const patient_has_finding_of_acute_diarrhea_now Bool)
(declare-const patient_has_finding_of_acute_diarrhea_now@@cause_other_than_clostridium_difficile Bool)
(declare-const patient_has_finding_of_chronic_diarrhea_now Bool)
(declare-const patient_has_finding_of_chronic_diarrhea_now@@cause_other_than_clostridium_difficile Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_clostridioides_difficile_infection_now@@fulminant patient_has_finding_of_clostridioides_difficile_infection_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_clostridioides_difficile_infection_now@@fulminant patient_has_contraindication_to_enteral_therapy_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_disease_condition_finding_now@@acutely_life_threatening patient_has_finding_of_disease_condition_finding_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_acute_diarrhea_now@@cause_other_than_clostridium_difficile patient_has_finding_of_acute_diarrhea_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_chronic_diarrhea_now@@cause_other_than_clostridium_difficile patient_has_finding_of_chronic_diarrhea_now) :named REQ2_AUXILIARY1))

;; Other kept assertions
(assert (! (not patient_has_contraindication_to_oral_therapy_now) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_enteral_therapy_now) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_disease_condition_finding_now@@acutely_life_threatening) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_acute_diarrhea_now@@cause_other_than_clostridium_difficile) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_chronic_diarrhea_now@@cause_other_than_clostridium_difficile) :named REQ2_COMPONENT1_OTHER_REQUIREMENTS))
