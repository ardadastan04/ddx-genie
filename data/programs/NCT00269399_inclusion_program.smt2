;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_has_finding_of_acute_diarrhea_now Bool)
(declare-const patient_has_finding_of_infectious_enteritis_of_intestine_now Bool)
(declare-const patient_has_finding_of_fever_now Bool)
(declare-const patient_has_finding_of_nausea_now Bool)
(declare-const patient_has_finding_of_loss_of_appetite_now Bool)
(declare-const patient_has_finding_of_vomiting_now Bool)
(declare-const patient_has_finding_of_abdominal_pain_now@@severe Bool)
(declare-const patient_has_finding_of_abdominal_discomfort_now@@severe Bool)
(declare-const patient_has_at_least_one_other_sign_of_enteric_infection_now Bool)
(declare-const patient_has_undergone_clostridium_difficile_toxin_assay_now_outcome_is_positive Bool)
(declare-const patient_has_undergone_clostridium_difficile_toxin_assay_now_outcome_is_positive@@temporalcontext_screening Bool)
(declare-const patient_has_finding_of_abdominal_pain_now Bool)
(declare-const patient_has_finding_of_abdominal_discomfort_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_fever_now patient_has_finding_of_nausea_now patient_has_finding_of_loss_of_appetite_now patient_has_finding_of_vomiting_now patient_has_finding_of_abdominal_pain_now@@severe patient_has_finding_of_abdominal_discomfort_now@@severe) patient_has_finding_of_infectious_enteritis_of_intestine_now) :named REQ0_AUXILIARY0))
(assert (! (= patient_has_at_least_one_other_sign_of_enteric_infection_now (or patient_has_finding_of_fever_now patient_has_finding_of_nausea_now patient_has_finding_of_loss_of_appetite_now patient_has_finding_of_vomiting_now patient_has_finding_of_abdominal_pain_now@@severe patient_has_finding_of_abdominal_discomfort_now@@severe patient_has_finding_of_infectious_enteritis_of_intestine_now)) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_clostridium_difficile_toxin_assay_now_outcome_is_positive@@temporalcontext_screening patient_has_undergone_clostridium_difficile_toxin_assay_now_outcome_is_positive) :named REQ1_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_abdominal_discomfort_now@@severe patient_has_finding_of_abdominal_discomfort_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_abdominal_pain_now@@severe patient_has_finding_of_abdominal_pain_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_acute_diarrhea_now :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_at_least_one_other_sign_of_enteric_infection_now :named REQ0_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! patient_has_undergone_clostridium_difficile_toxin_assay_now_outcome_is_positive@@temporalcontext_screening :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
