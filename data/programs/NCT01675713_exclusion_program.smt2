;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_finding_of_walking_now Bool)
(declare-const patient_has_finding_of_finding_of_walking_now@@performed_slowly Bool)
(declare-const patient_has_finding_of_finding_of_walking_now@@sustained_for_twenty_minutes Bool)
(declare-const patient_has_finding_of_walking_now@@performed_slowly@@sustained_for_twenty_minutes Bool)
(declare-const patient_has_finding_of_walking_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_finding_of_walking_now@@performed_slowly@@sustained_for_twenty_minutes (and patient_has_finding_of_finding_of_walking_now patient_has_finding_of_finding_of_walking_now@@performed_slowly patient_has_finding_of_finding_of_walking_now@@sustained_for_twenty_minutes)) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_finding_of_walking_now@@performed_slowly patient_has_finding_of_finding_of_walking_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_finding_of_walking_now@@sustained_for_twenty_minutes patient_has_finding_of_finding_of_walking_now) :named REQ0_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_walking_now@@performed_slowly@@sustained_for_twenty_minutes patient_has_finding_of_walking_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not patient_has_finding_of_walking_now@@performed_slowly@@sustained_for_twenty_minutes) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
