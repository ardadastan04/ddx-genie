;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_undergoing_laparoscopy_now Bool)
(declare-const patient_is_undergoing_laparoscopy_now@@diagnostic_intent Bool)
(declare-const patient_will_undergo_appendectomy_inthefuture Bool)
(declare-const patient_will_undergo_appendectomy_inthefuture@@for_appendectomy_a_froid_not_for_acute_appendicitis Bool)
(declare-const patient_will_undergo_laparoscopy_inthefuture Bool)
(declare-const patient_will_undergo_laparoscopy_inthefuture@@diagnostic_intent Bool)
(declare-const patient_is_primarily_chosen_for_open_appendectomy_now Bool)
(declare-const patient_is_able_to_give_written_informed_consent_now Bool)
(declare-const patient_is_able_to_give_written_informed_consent_now@@inability_due_to_language_barrier Bool)
(declare-const patient_is_able_to_give_written_informed_consent_now@@inability_due_to_legal_incapacity Bool)
(declare-const patient_has_refused_written_informed_consent_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_is_undergoing_laparoscopy_now@@diagnostic_intent patient_is_undergoing_laparoscopy_now) :named REQ0_AUXILIARY0))
(assert (! (=> patient_will_undergo_appendectomy_inthefuture@@for_appendectomy_a_froid_not_for_acute_appendicitis patient_will_undergo_appendectomy_inthefuture) :named REQ0_AUXILIARY1))
(assert (! (=> patient_will_undergo_laparoscopy_inthefuture@@diagnostic_intent patient_will_undergo_laparoscopy_inthefuture) :named REQ0_AUXILIARY2))
(assert (! (=> (or patient_is_able_to_give_written_informed_consent_now@@inability_due_to_language_barrier patient_is_able_to_give_written_informed_consent_now@@inability_due_to_legal_incapacity) (not patient_is_able_to_give_written_informed_consent_now)) :named REQ2_AUXILIARY0))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_is_able_to_give_written_informed_consent_now@@inability_due_to_language_barrier patient_is_able_to_give_written_informed_consent_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_is_able_to_give_written_informed_consent_now@@inability_due_to_legal_incapacity patient_is_able_to_give_written_informed_consent_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (not (and (or patient_is_undergoing_laparoscopy_now@@diagnostic_intent patient_will_undergo_laparoscopy_inthefuture@@diagnostic_intent) patient_will_undergo_appendectomy_inthefuture@@for_appendectomy_a_froid_not_for_acute_appendicitis)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_primarily_chosen_for_open_appendectomy_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_is_able_to_give_written_informed_consent_now :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_refused_written_informed_consent_now) :named REQ3_COMPONENT0_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
