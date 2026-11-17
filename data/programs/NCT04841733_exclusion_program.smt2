;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_is_goalkeeper Bool)
(declare-const patient_is_injured_player_now Bool)

;; Other kept assertions
(assert (! (not patient_is_goalkeeper) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_is_injured_player_now) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
