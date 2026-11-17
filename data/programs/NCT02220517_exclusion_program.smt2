;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_carcinoma_of_prostate_now Bool)
(declare-const patient_has_diagnosis_of_carcinoma_of_prostate_now@@known Bool)
(declare-const patient_can_undergo_magnetic_resonance_imaging_now Bool)
(declare-const patient_can_undergo_biopsy_of_prostate_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_carcinoma_of_prostate_now@@known patient_has_diagnosis_of_carcinoma_of_prostate_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not patient_has_diagnosis_of_carcinoma_of_prostate_now@@known) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_can_undergo_magnetic_resonance_imaging_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_can_undergo_biopsy_of_prostate_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
