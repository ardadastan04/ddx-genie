;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=4 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_finding_of_cerebral_infarction_now Bool)
(declare-const patient_has_finding_of_cerebral_infarction_now@@incomplete Bool)
(declare-const patient_has_finding_of_abscess_now Bool)
(declare-const patient_has_finding_of_abscess_now@@present_as_lesions Bool)
(declare-const patient_has_finding_of_abscess_now@@symptomatic Bool)
(declare-const patient_has_finding_of_abscess_now@@excessive_bleeding_risk Bool)
(declare-const patient_has_finding_of_abscess_now@@symptomatic@@excessive_bleeding_risk Bool)
(declare-const patient_has_finding_of_tumor_finding_now Bool)
(declare-const patient_has_finding_of_tumor_finding_now@@symptomatic Bool)
(declare-const patient_has_finding_of_tumor_finding_now@@excessive_bleeding_risk Bool)
(declare-const patient_has_finding_of_tumor_finding_now@@symptomatic@@excessive_bleeding_risk Bool)
(declare-const patient_has_finding_of_cerebrovascular_accident_now Bool)
(declare-const patient_has_finding_of_cerebrovascular_accident_now@@present_as_lesions Bool)
(declare-const patient_has_finding_of_cerebrovascular_accident_now@@symptomatic Bool)
(declare-const patient_has_finding_of_cerebrovascular_accident_now@@excessive_bleeding_risk Bool)
(declare-const patient_has_finding_of_cerebrovascular_accident_now@@symptomatic@@excessive_bleeding_risk Bool)
(declare-const patient_has_finding_of_respiratory_complication_now Bool)
(declare-const patient_is_unable_to_adapt_to_exercise_program Bool)
(declare-const patient_has_finding_of_clouded_consciousness_now Bool)
(declare-const patient_has_finding_of_coma_now Bool)
(declare-const patient_has_finding_of_cerebrovascular_accident_now@@acute Bool)
(declare-const patient_does_not_want_to_be_involved_in_voluntary_work Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_cerebral_infarction_now@@incomplete patient_has_finding_of_cerebral_infarction_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_finding_of_abscess_now@@present_as_lesions patient_has_finding_of_abscess_now) :named REQ1_AUXILIARY0))
(assert (! (=> patient_has_finding_of_abscess_now@@symptomatic patient_has_finding_of_abscess_now) :named REQ1_AUXILIARY1))
(assert (! (=> patient_has_finding_of_abscess_now@@excessive_bleeding_risk patient_has_finding_of_abscess_now) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_finding_of_abscess_now@@symptomatic@@excessive_bleeding_risk (and patient_has_finding_of_abscess_now@@symptomatic patient_has_finding_of_abscess_now@@excessive_bleeding_risk)) :named REQ1_AUXILIARY3))
(assert (! (=> patient_has_finding_of_tumor_finding_now@@symptomatic patient_has_finding_of_tumor_finding_now) :named REQ1_AUXILIARY4))
(assert (! (=> patient_has_finding_of_tumor_finding_now@@excessive_bleeding_risk patient_has_finding_of_tumor_finding_now) :named REQ1_AUXILIARY5))
(assert (! (=> patient_has_finding_of_tumor_finding_now@@symptomatic@@excessive_bleeding_risk (and patient_has_finding_of_tumor_finding_now@@symptomatic patient_has_finding_of_tumor_finding_now@@excessive_bleeding_risk)) :named REQ1_AUXILIARY6))
(assert (! (=> patient_has_finding_of_cerebrovascular_accident_now@@present_as_lesions patient_has_finding_of_cerebrovascular_accident_now) :named REQ1_AUXILIARY7))
(assert (! (=> patient_has_finding_of_cerebrovascular_accident_now@@symptomatic patient_has_finding_of_cerebrovascular_accident_now) :named REQ1_AUXILIARY8))
(assert (! (=> patient_has_finding_of_cerebrovascular_accident_now@@excessive_bleeding_risk patient_has_finding_of_cerebrovascular_accident_now) :named REQ1_AUXILIARY9))
(assert (! (=> patient_has_finding_of_cerebrovascular_accident_now@@symptomatic@@excessive_bleeding_risk (and patient_has_finding_of_cerebrovascular_accident_now@@symptomatic patient_has_finding_of_cerebrovascular_accident_now@@excessive_bleeding_risk)) :named REQ1_AUXILIARY10))
(assert (! (=> (or patient_has_finding_of_clouded_consciousness_now patient_has_finding_of_coma_now) patient_is_unable_to_adapt_to_exercise_program) :named REQ3_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_abscess_now@@symptomatic@@excessive_bleeding_risk patient_has_finding_of_abscess_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_cerebrovascular_accident_now@@acute patient_has_finding_of_cerebrovascular_accident_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_finding_of_cerebrovascular_accident_now@@symptomatic@@excessive_bleeding_risk patient_has_finding_of_cerebrovascular_accident_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_finding_of_tumor_finding_now@@symptomatic@@excessive_bleeding_risk patient_has_finding_of_tumor_finding_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))

;; Other kept assertions
(assert (! (not patient_has_finding_of_cerebral_infarction_now@@incomplete) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_abscess_now@@symptomatic@@excessive_bleeding_risk) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_tumor_finding_now@@symptomatic@@excessive_bleeding_risk) :named REQ1_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_cerebrovascular_accident_now@@symptomatic@@excessive_bleeding_risk) :named REQ1_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_respiratory_complication_now) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_unable_to_adapt_to_exercise_program) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_finding_of_cerebrovascular_accident_now@@acute patient_does_not_want_to_be_involved_in_voluntary_work)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
