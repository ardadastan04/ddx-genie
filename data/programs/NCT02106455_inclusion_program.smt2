;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_osteitis_deformans_now Bool)
(declare-const patient_is_exposed_to_risedronate_sodium_now Bool)
(declare-const patient_is_exposed_to_risedronate_sodium_now@@administered_as_tablets Bool)
(declare-const patient_is_exposed_to_risedronate_sodium_now@@dose_is_17_5_mg Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_exposed_to_risedronate_sodium_now@@administered_as_tablets patient_is_exposed_to_risedronate_sodium_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_is_exposed_to_risedronate_sodium_now@@dose_is_17_5_mg patient_is_exposed_to_risedronate_sodium_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_osteitis_deformans_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
