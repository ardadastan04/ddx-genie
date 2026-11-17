;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=2 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_has_chinese_descent_and_full_chinese_parentage Bool)
(declare-const patient_has_south_korean_descent_and_full_south_korean_parentage Bool)
(declare-const patient_has_taiwanese_descent_and_full_taiwanese_parentage Bool)
(declare-const patient_has_diagnosis_of_chronic_hepatitis_c_inthehistory Bool)
(declare-const patient_has_finding_of_hepatitis_c_virus_genotype_1b_infection_now Bool)
(declare-const patient_has_finding_of_hepatitis_c_virus_genotype_1b_infection_now@@indicated_by_screening_laboratory_result Bool)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now Bool)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now@@compensated Bool)
(declare-const child_pugh_score_value_recorded_at_screening_withunit_points Real)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_previous_liver_biopsy Bool)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_liver_biopsy_during_screening Bool)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_fibroscan_within_6_months_of_screening Bool)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_fibroscan_during_screening_period Bool)
(declare-const metavir_score_value_recorded_on_liver_biopsy_during_screening_withunit_score Real)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_metavir_score_on_liver_biopsy_during_screening Bool)
(declare-const ishak_score_value_recorded_on_liver_biopsy_during_screening_withunit_score Real)
(declare-const patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_ishak_score_on_liver_biopsy_during_screening Bool)
(declare-const fibroscan_score_value_recorded_within_6_months_of_screening_withunit_kilopascals Real)
(declare-const fibroscan_score_value_recorded_during_screening_period_withunit_kilopascals Real)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_hepatitis_c_virus_genotype_1b_infection_now@@indicated_by_screening_laboratory_result patient_has_finding_of_hepatitis_c_virus_genotype_1b_infection_now) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_cirrhosis_of_liver_now@@compensated patient_has_finding_of_cirrhosis_of_liver_now) :named REQ3_AUXILIARY0))
(assert (! (= patient_has_finding_of_cirrhosis_of_liver_now@@compensated (and patient_has_finding_of_cirrhosis_of_liver_now (<= child_pugh_score_value_recorded_at_screening_withunit_points 6))) :named REQ3_AUXILIARY1))
(assert (! (=> patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_metavir_score_on_liver_biopsy_during_screening patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_liver_biopsy_during_screening) :named REQ4_AUXILIARY0))
(assert (! (=> patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_ishak_score_on_liver_biopsy_during_screening patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_liver_biopsy_during_screening) :named REQ4_AUXILIARY1))
(assert (! (= patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_metavir_score_on_liver_biopsy_during_screening (> metavir_score_value_recorded_on_liver_biopsy_during_screening_withunit_score 3.0)) :named REQ4_AUXILIARY2))
(assert (! (= patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_ishak_score_on_liver_biopsy_during_screening (> ishak_score_value_recorded_on_liver_biopsy_during_screening_withunit_score 4.0)) :named REQ4_AUXILIARY3))
(assert (! (= patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_fibroscan_within_6_months_of_screening (>= fibroscan_score_value_recorded_within_6_months_of_screening_withunit_kilopascals 14.6)) :named REQ4_AUXILIARY4))
(assert (! (= patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_fibroscan_during_screening_period (>= fibroscan_score_value_recorded_during_screening_period_withunit_kilopascals 14.6)) :named REQ4_AUXILIARY5))
(assert (! (=> patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_previous_liver_biopsy patient_has_finding_of_cirrhosis_of_liver_now) :named REQ4_AUXILIARY6))
(assert (! (=> patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_liver_biopsy_during_screening patient_has_finding_of_cirrhosis_of_liver_now) :named REQ4_AUXILIARY7))
(assert (! (=> patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_fibroscan_within_6_months_of_screening patient_has_finding_of_cirrhosis_of_liver_now) :named REQ4_AUXILIARY8))
(assert (! (=> patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_fibroscan_during_screening_period patient_has_finding_of_cirrhosis_of_liver_now) :named REQ4_AUXILIARY9))

;; AUTO auxiliary (qualifier => stem) links [Bool→Bool]
(assert (! (=> patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_ishak_score_on_liver_biopsy_during_screening patient_has_finding_of_cirrhosis_of_liver_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_0))
(assert (! (=> patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_metavir_score_on_liver_biopsy_during_screening patient_has_finding_of_cirrhosis_of_liver_now) :named AUTO_AUXILIARY_QUAL_IMPLIES_STEM_1))

;; Other kept assertions
(assert (! (or patient_has_chinese_descent_and_full_chinese_parentage patient_has_south_korean_descent_and_full_south_korean_parentage patient_has_taiwanese_descent_and_full_taiwanese_parentage) :named REQ0_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_diagnosis_of_chronic_hepatitis_c_inthehistory :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_has_finding_of_hepatitis_c_virus_genotype_1b_infection_now@@indicated_by_screening_laboratory_result :named REQ2_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! patient_has_finding_of_cirrhosis_of_liver_now@@compensated :named REQ3_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_previous_liver_biopsy patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_liver_biopsy_during_screening patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_fibroscan_within_6_months_of_screening patient_has_finding_of_cirrhosis_of_liver_now@@documented_by_fibroscan_during_screening_period) :named REQ4_COMPONENT0_OTHER_REQUIREMENTS))
