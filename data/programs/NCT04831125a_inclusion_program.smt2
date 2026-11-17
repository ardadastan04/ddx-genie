;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_bradycardia_now Bool)
(declare-const patient_has_finding_of_bradycardia_now@@according_to_american_college_of_cardiology_guidelines Bool)
(declare-const patient_has_finding_of_bradycardia_now@@according_to_american_heart_association_guidelines Bool)
(declare-const patient_has_finding_of_bradycardia_now@@according_to_heart_rhythm_society_guidelines Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_bradycardia_now@@according_to_american_college_of_cardiology_guidelines patient_has_finding_of_bradycardia_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_bradycardia_now@@according_to_american_heart_association_guidelines patient_has_finding_of_bradycardia_now) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_finding_of_bradycardia_now@@according_to_heart_rhythm_society_guidelines patient_has_finding_of_bradycardia_now) :named REQ0_AUXILIARY2))

;; Other kept assertions
(assert (! (or patient_has_finding_of_bradycardia_now@@according_to_american_college_of_cardiology_guidelines patient_has_finding_of_bradycardia_now@@according_to_american_heart_association_guidelines patient_has_finding_of_bradycardia_now@@according_to_heart_rhythm_society_guidelines) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
