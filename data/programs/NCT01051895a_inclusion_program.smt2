;; ===================== QUALIFIER LINKER =====================
;; Rule: add (qualifier => stem) only when BOTH are Bool; remove (stem => qualifier); drop ill-typed implications.
;; Added_aux=0 Removed_reverse=0 Removed_illtyped=0 Skipped_nonbool_pairs=0
;; =============================================================

;; Declarations/definitions (original + any auto-added Bool stems)
(declare-const patient_sex_is_female_now Bool)
(declare-const patient_age_value_recorded_now_in_years Real)
(declare-const patient_is_located_in_british_columbia_now Bool)
(declare-const patient_is_located_in_nova_scotia_now Bool)
(declare-const patient_is_located_in_newfoundland_now Bool)
(declare-const patient_is_located_in_bc_ns_nf_now Bool)
(declare-const patient_meets_age_and_location_criteria_now Bool)
(declare-const patient_understands_english_language_now Bool)
(declare-const patient_understands_french_language_now Bool)
(declare-const site_has_french_speaking_coordinator_now Bool)
(declare-const patient_has_diagnosis_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory Bool)
(declare-const patient_has_diagnosis_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory@@biopsy_proven Bool)
(declare-const patient_has_diagnosis_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory@@treated Bool)
(declare-const patient_has_diagnosis_of_carcinoma_in_situ_of_uterine_cervix_inthehistory Bool)
(declare-const patient_has_diagnosis_of_carcinoma_in_situ_of_uterine_cervix_inthehistory@@biopsy_proven Bool)
(declare-const patient_has_diagnosis_of_carcinoma_in_situ_of_uterine_cervix_inthehistory@@treated Bool)
(declare-const patient_has_diagnosis_of_adenocarcinoma_in_situ_inthehistory Bool)
(declare-const patient_has_diagnosis_of_adenocarcinoma_in_situ_inthehistory@@biopsy_proven Bool)
(declare-const patient_has_diagnosis_of_adenocarcinoma_in_situ_inthehistory@@treated Bool)

;; Existing auxiliary assertions
(assert (! (= patient_is_located_in_bc_ns_nf_now (or patient_is_located_in_british_columbia_now patient_is_located_in_nova_scotia_now patient_is_located_in_newfoundland_now)) :named REQ0_AUXILIARY0))
(assert (! (= patient_meets_age_and_location_criteria_now (or (and patient_is_located_in_bc_ns_nf_now (>= patient_age_value_recorded_now_in_years 19)) (and (not patient_is_located_in_bc_ns_nf_now) (>= patient_age_value_recorded_now_in_years 18)))) :named REQ0_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory@@biopsy_proven patient_has_diagnosis_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_diagnosis_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory@@treated patient_has_diagnosis_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_diagnosis_of_carcinoma_in_situ_of_uterine_cervix_inthehistory@@biopsy_proven patient_has_diagnosis_of_carcinoma_in_situ_of_uterine_cervix_inthehistory) :named REQ2_AUXILIARY2))
(assert (! (=> patient_has_diagnosis_of_carcinoma_in_situ_of_uterine_cervix_inthehistory@@treated patient_has_diagnosis_of_carcinoma_in_situ_of_uterine_cervix_inthehistory) :named REQ2_AUXILIARY3))
(assert (! (=> patient_has_diagnosis_of_adenocarcinoma_in_situ_inthehistory@@biopsy_proven patient_has_diagnosis_of_adenocarcinoma_in_situ_inthehistory) :named REQ2_AUXILIARY4))
(assert (! (=> patient_has_diagnosis_of_adenocarcinoma_in_situ_inthehistory@@treated patient_has_diagnosis_of_adenocarcinoma_in_situ_inthehistory) :named REQ2_AUXILIARY5))

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! patient_meets_age_and_location_criteria_now :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or patient_understands_english_language_now (and patient_understands_french_language_now site_has_french_speaking_coordinator_now)) :named REQ1_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (and patient_has_diagnosis_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory@@biopsy_proven patient_has_diagnosis_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory@@treated) (and patient_has_diagnosis_of_carcinoma_in_situ_of_uterine_cervix_inthehistory@@biopsy_proven patient_has_diagnosis_of_carcinoma_in_situ_of_uterine_cervix_inthehistory@@treated) (and patient_has_diagnosis_of_adenocarcinoma_in_situ_inthehistory@@biopsy_proven patient_has_diagnosis_of_adenocarcinoma_in_situ_inthehistory@@treated)) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
