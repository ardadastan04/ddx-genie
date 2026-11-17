;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=1 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_history_of_endovascular_carotid_artery_surgery_on_same_side Bool)
(declare-const patient_has_history_of_open_carotid_artery_surgery_on_same_side Bool)
(declare-const patient_has_undergone_radiotherapy_to_neck_inthehistory Bool)
(declare-const patient_can_undergo_carotid_endarterectomy_now Bool)
(declare-const patient_can_undergo_insertion_of_carotid_artery_stent_now Bool)
(declare-const patient_has_impaired_consent_capacity_now Bool)
(declare-const patient_can_undergo_magnetic_resonance_imaging_now Bool)
(declare-const patient_can_undergo_magnetic_resonance_imaging_now@@unable_to_lie_in_scanner_for_sixty_minutes Bool)
(declare-const patient_has_finding_of_renal_impairment_now Bool)
(declare-const patient_is_exposed_to_sedative_now Bool)
(declare-const patient_is_exposed_to_sedative_now@@needed_during_magnetic_resonance_imaging_scans Bool)
(declare-const patient_has_prisoner_status_now Bool)

;; Existing auxiliary assertions
(assert (! (=> (or patient_has_finding_of_renal_impairment_now patient_is_exposed_to_sedative_now@@needed_during_magnetic_resonance_imaging_scans patient_can_undergo_magnetic_resonance_imaging_now@@unable_to_lie_in_scanner_for_sixty_minutes) (not patient_can_undergo_magnetic_resonance_imaging_now)) :named REQ4_AUXILIARY0))
(assert (! (=> patient_can_undergo_magnetic_resonance_imaging_now@@unable_to_lie_in_scanner_for_sixty_minutes (not patient_can_undergo_magnetic_resonance_imaging_now)) :named REQ4_AUXILIARY1))
(assert (! (=> patient_is_exposed_to_sedative_now@@needed_during_magnetic_resonance_imaging_scans patient_is_exposed_to_sedative_now) :named REQ4_AUXILIARY2))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_can_undergo_magnetic_resonance_imaging_now@@unable_to_lie_in_scanner_for_sixty_minutes patient_can_undergo_magnetic_resonance_imaging_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))

;; Other kept assertions
(assert (! (not (or patient_has_history_of_endovascular_carotid_artery_surgery_on_same_side patient_has_history_of_open_carotid_artery_surgery_on_same_side)) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_radiotherapy_to_neck_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (or (not patient_can_undergo_carotid_endarterectomy_now) (not patient_can_undergo_insertion_of_carotid_artery_stent_now))) :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_impaired_consent_capacity_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (not patient_can_undergo_magnetic_resonance_imaging_now)) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_prisoner_status_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
