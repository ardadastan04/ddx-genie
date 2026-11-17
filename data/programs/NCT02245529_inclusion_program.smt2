;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@symptomatic Bool)
(declare-const patient_has_symptoms_of_benign_prostatic_hyperplasia_now@@determined_according_to_physician Bool)
(declare-const patient_has_symptoms_of_benign_prostatic_hyperplasia_now@@require_medical_treatment_to_improve_quality_of_life Bool)
(declare-const patient_has_symptoms_of_benign_prostatic_hyperplasia_now Bool)
(declare-const patient_has_undergone_medical_therapy_inthehistory Bool)
(declare-const patient_has_undergone_medical_therapy_inthehistory@@outcome_is_inadequate_response Bool)
(declare-const patient_is_undergoing_medical_therapy_now Bool)
(declare-const patient_is_undergoing_medical_therapy_now@@with_other_drugs Bool)
(declare-const patient_has_diagnosis_of_benign_prostatic_hyperplasia_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_symptoms_of_benign_prostatic_hyperplasia_now@@determined_according_to_physician patient_has_symptoms_of_benign_prostatic_hyperplasia_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_symptoms_of_benign_prostatic_hyperplasia_now@@require_medical_treatment_to_improve_quality_of_life patient_has_symptoms_of_benign_prostatic_hyperplasia_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_medical_therapy_inthehistory@@outcome_is_inadequate_response patient_has_undergone_medical_therapy_inthehistory) :named REQ1_AUXILIARY0))
(assert (! (=> patient_is_undergoing_medical_therapy_now@@with_other_drugs patient_is_undergoing_medical_therapy_now) :named REQ1_AUXILIARY1))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@symptomatic patient_has_diagnosis_of_benign_prostatic_hyperplasia_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (or patient_has_diagnosis_of_benign_prostatic_hyperplasia_now@@symptomatic (and patient_has_symptoms_of_benign_prostatic_hyperplasia_now@@determined_according_to_physician patient_has_symptoms_of_benign_prostatic_hyperplasia_now@@require_medical_treatment_to_improve_quality_of_life)) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (not patient_has_undergone_medical_therapy_inthehistory) (and patient_is_undergoing_medical_therapy_now@@with_other_drugs patient_has_undergone_medical_therapy_inthehistory@@outcome_is_inadequate_response)) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
