;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_carotid_stenosis_now Bool)
(declare-const patient_has_finding_of_carotid_stenosis_now@@monolateral Bool)
(declare-const patient_has_finding_of_carotid_stenosis_now@@significant Bool)
(declare-const patient_has_finding_of_carotid_stenosis_now@@soft Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_carotid_stenosis_now@@monolateral patient_has_finding_of_carotid_stenosis_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_carotid_stenosis_now@@significant patient_has_finding_of_carotid_stenosis_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_carotid_stenosis_now@@soft patient_has_finding_of_carotid_stenosis_now) :named REQ0_AUXILIARY2))

;; Other kept assertions
(assert (! patient_has_finding_of_carotid_stenosis_now@@monolateral :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_carotid_stenosis_now@@significant :named REQ0_COMPONENT1_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_carotid_stenosis_now@@soft :named REQ0_COMPONENT2_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
