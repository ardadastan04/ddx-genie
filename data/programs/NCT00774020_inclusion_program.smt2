;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_diagnosis_of_osteitis_deformans_now Bool)
(declare-const patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_radiological_report Bool)
(declare-const patient_serum_alkaline_phosphatase_level_finding_value_recorded_now_withunit_u_per_l Real)
(declare-const patient_serum_alkaline_phosphatase_upper_limit_of_normal_now_withunit_u_per_l Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_radiological_report patient_has_diagnosis_of_osteitis_deformans_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! patient_has_diagnosis_of_osteitis_deformans_now@@confirmed_by_radiological_report :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (>= patient_serum_alkaline_phosphatase_level_finding_value_recorded_now_withunit_u_per_l (* 2.0 patient_serum_alkaline_phosphatase_upper_limit_of_normal_now_withunit_u_per_l)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
