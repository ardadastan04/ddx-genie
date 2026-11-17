;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_undergone_endovascular_repair_of_carotid_artery_inthehistory Bool)
(declare-const patient_has_undergone_endovascular_repair_of_carotid_artery_inthehistory@@on_the_same_side Bool)
(declare-const patient_has_undergone_operation_on_carotid_artery_inthehistory Bool)
(declare-const patient_has_undergone_operation_on_carotid_artery_inthehistory@@open_surgery Bool)
(declare-const patient_has_undergone_operation_on_carotid_artery_inthehistory@@on_the_same_side Bool)
(declare-const patient_has_undergone_radiotherapy_to_neck_inthehistory Bool)
(declare-const patient_can_undergo_carotid_endarterectomy_now Bool)
(declare-const patient_is_undergoing_carotid_endarterectomy_now Bool)
(declare-const patient_can_undergo_insertion_of_carotid_artery_stent_now Bool)
(declare-const patient_is_undergoing_insertion_of_carotid_artery_stent_now Bool)
(declare-const patient_has_finding_of_impaired_consent_capacity_now Bool)
(declare-const patient_has_contraindication_to_magnetic_resonance_imaging_scan_now Bool)
(declare-const patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_impaired_renal_function Bool)
(declare-const patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_need_for_sedative_medication_during_magnetic_resonance_imaging_scan Bool)
(declare-const patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_inability_to_lie_in_scanner_for_sixty_minutes Bool)
(declare-const patient_has_finding_of_incarceration_in_prison_now Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_undergone_endovascular_repair_of_carotid_artery_inthehistory@@on_the_same_side patient_has_undergone_endovascular_repair_of_carotid_artery_inthehistory) :named REQ0_AUXILIARY0))
(assert (! (=> patient_has_undergone_operation_on_carotid_artery_inthehistory@@open_surgery patient_has_undergone_operation_on_carotid_artery_inthehistory) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_undergone_operation_on_carotid_artery_inthehistory@@on_the_same_side patient_has_undergone_operation_on_carotid_artery_inthehistory) :named REQ0_AUXILIARY2))
(assert (! (=> (or patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_impaired_renal_function patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_need_for_sedative_medication_during_magnetic_resonance_imaging_scan patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_inability_to_lie_in_scanner_for_sixty_minutes) patient_has_contraindication_to_magnetic_resonance_imaging_scan_now) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_impaired_renal_function patient_has_contraindication_to_magnetic_resonance_imaging_scan_now) :named REQ4_AUXILIARY1))
(assert (! (=> patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_need_for_sedative_medication_during_magnetic_resonance_imaging_scan patient_has_contraindication_to_magnetic_resonance_imaging_scan_now) :named REQ4_AUXILIARY2))
(assert (! (=> patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_inability_to_lie_in_scanner_for_sixty_minutes patient_has_contraindication_to_magnetic_resonance_imaging_scan_now) :named REQ4_AUXILIARY3))

;; Other kept assertions
(assert (! (not patient_has_undergone_endovascular_repair_of_carotid_artery_inthehistory@@on_the_same_side) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and patient_has_undergone_operation_on_carotid_artery_inthehistory@@open_surgery patient_has_undergone_operation_on_carotid_artery_inthehistory@@on_the_same_side)) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_undergone_radiotherapy_to_neck_inthehistory) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not (and (not patient_can_undergo_carotid_endarterectomy_now) patient_is_undergoing_carotid_endarterectomy_now)) :named REQ2_COMPONENT0_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
(assert (! (not (and (not patient_can_undergo_insertion_of_carotid_artery_stent_now) patient_is_undergoing_insertion_of_carotid_artery_stent_now)) :named REQ2_COMPONENT1_CAN_ALWAYS_GO_FROM_SATISFIED_TO_NOTSATISFIED))
(assert (! (not patient_has_finding_of_impaired_consent_capacity_now) :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_impaired_renal_function) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_need_for_sedative_medication_during_magnetic_resonance_imaging_scan) :named REQ4_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (not patient_has_contraindication_to_magnetic_resonance_imaging_scan_now@@due_to_inability_to_lie_in_scanner_for_sixty_minutes) :named REQ4_COMPONENT2_OTHER_REQUIREMENTS))
(assert (! (not patient_has_finding_of_incarceration_in_prison_now) :named REQ5_COMPONENT0_OTHER_REQUIREMENTS))
