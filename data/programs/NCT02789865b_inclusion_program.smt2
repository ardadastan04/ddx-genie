;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=4 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const alvarado_score_value_recorded_now_withunit_points Real)
(declare-const patient_has_finding_of_ultrasound_scan_finding_now@@suggests_uncomplicated_acute_appendicitis Bool)
(declare-const patient_has_finding_of_ultrasound_scan_finding_now@@cannot_exclude_acute_appendicitis Bool)
(declare-const patient_has_undergone_computed_tomography_now@@findings_cannot_exclude_acute_appendicitis Bool)
(declare-const patient_has_undergone_computed_tomography_now@@findings_suggest_uncomplicated_acute_appendicitis Bool)
(declare-const patient_has_undergone_computed_tomography_now Bool)
(declare-const patient_has_finding_of_ultrasound_scan_finding_now Bool)

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_ultrasound_scan_finding_now@@cannot_exclude_acute_appendicitis patient_has_finding_of_ultrasound_scan_finding_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_ultrasound_scan_finding_now@@suggests_uncomplicated_acute_appendicitis patient_has_finding_of_ultrasound_scan_finding_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_undergone_computed_tomography_now@@findings_cannot_exclude_acute_appendicitis patient_has_undergone_computed_tomography_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))
(assert (! (=> patient_has_undergone_computed_tomography_now@@findings_suggest_uncomplicated_acute_appendicitis patient_has_undergone_computed_tomography_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_3))

;; Other kept assertions
(assert (! (< alvarado_score_value_recorded_now_withunit_points 7) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_ultrasound_scan_finding_now@@suggests_uncomplicated_acute_appendicitis patient_has_undergone_computed_tomography_now@@findings_suggest_uncomplicated_acute_appendicitis patient_has_finding_of_ultrasound_scan_finding_now@@cannot_exclude_acute_appendicitis patient_has_undergone_computed_tomography_now@@findings_cannot_exclude_acute_appendicitis) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
