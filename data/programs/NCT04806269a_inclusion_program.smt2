;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_thyrotoxicosis_now Bool)
(declare-const patient_has_diagnosis_of_thyrotoxicosis_now@@newly_diagnosed Bool)
(declare-const patient_has_diagnosis_of_hypothyroidism_now Bool)
(declare-const patient_has_diagnosis_of_hypothyroidism_now@@newly_diagnosed Bool)
(declare-const patient_is_able_to_use_wearable_devices Bool)
(declare-const patient_is_able_to_use_smart_phones Bool)
(declare-const patient_is_able_to_use_mobile_apps Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_thyrotoxicosis_now@@newly_diagnosed patient_has_diagnosis_of_thyrotoxicosis_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_hypothyroidism_now@@newly_diagnosed patient_has_diagnosis_of_hypothyroidism_now) :named REQ0_AUXILIARY1))

;; Other kept assertions
(assert (! (or patient_has_diagnosis_of_thyrotoxicosis_now@@newly_diagnosed patient_has_diagnosis_of_hypothyroidism_now@@newly_diagnosed) :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_able_to_use_wearable_devices :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_able_to_use_smart_phones :named REQ1_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_is_able_to_use_mobile_apps :named REQ1_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
