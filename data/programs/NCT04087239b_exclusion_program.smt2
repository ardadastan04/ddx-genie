;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_mental_disorder_now Bool)
(declare-const patient_has_finding_of_mental_disorder_now@@severe Bool)
(declare-const patient_is_pregnant_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_mental_disorder_now@@severe patient_has_finding_of_mental_disorder_now) :named REQ0_AUXILIARY0))

;; Other kept assertions
(assert (! (not (and patient_is_pregnant_now patient_has_finding_of_mental_disorder_now@@severe)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
