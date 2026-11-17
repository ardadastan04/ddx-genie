;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=3 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour Real)
(declare-const patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now Bool)
(declare-const patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@diagnosed_by_polysomnography Bool)
(declare-const patient_has_mild_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography Bool)
(declare-const patient_has_moderate_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography Bool)
(declare-const patient_has_severe_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography Bool)
(declare-const patient_has_mild_obstructive_sleep_apnea_now Bool)
(declare-const patient_has_severe_obstructive_sleep_apnea_now Bool)
(declare-const patient_has_moderate_obstructive_sleep_apnea_now Bool)

;; Existing auxiliary assertions
(assert (! (= patient_has_mild_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography (and (>= patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour 5.0) (< patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour 15.0) patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@diagnosed_by_polysomnography)) :named REQ1_AUXILIARY0))
(assert (! (= patient_has_moderate_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography (and (>= patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour 15.0) (<= patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour 30.0) patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@diagnosed_by_polysomnography)) :named REQ1_AUXILIARY1))
(assert (! (= patient_has_severe_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography (and (> patient_apnea_hypopnea_index_value_recorded_now_withunit_per_hour 30.0) patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@diagnosed_by_polysomnography)) :named REQ1_AUXILIARY2))
(assert (! (=> patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now@@diagnosed_by_polysomnography patient_has_diagnosis_of_obstructive_sleep_apnea_syndrome_now) :named REQ1_AUXILIARY3))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_mild_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography patient_has_mild_obstructive_sleep_apnea_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_moderate_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography patient_has_moderate_obstructive_sleep_apnea_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))
(assert (! (=> patient_has_severe_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography patient_has_severe_obstructive_sleep_apnea_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_2))

;; Other kept assertions
(assert (! (>= patient_age_value_recorded_now_in_years 18) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (<= patient_age_value_recorded_now_in_years 75) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or patient_has_mild_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography patient_has_moderate_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography patient_has_severe_obstructive_sleep_apnea_now@@diagnosed_by_polysomnography) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
