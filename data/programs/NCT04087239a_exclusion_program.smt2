;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_mental_disorder_now Bool)
(declare-const patient_has_finding_of_mental_disorder_now@@maternal Bool)
(declare-const patient_has_finding_of_mental_disorder_now@@severe Bool)
(declare-const patient_has_finding_of_mental_disorder_now@@maternal@@severe Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_mental_disorder_now@@maternal@@severe (and patient_has_finding_of_mental_disorder_now patient_has_finding_of_mental_disorder_now@@maternal patient_has_finding_of_mental_disorder_now@@severe)) :named REQ0_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_mental_disorder_now@@maternal patient_has_finding_of_mental_disorder_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_mental_disorder_now@@maternal@@severe patient_has_finding_of_mental_disorder_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_mental_disorder_now@@severe patient_has_finding_of_mental_disorder_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! (not patient_has_finding_of_mental_disorder_now@@maternal@@severe) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
