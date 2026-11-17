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
(declare-const patient_understands_english Bool)
(declare-const patient_understands_french Bool)
(declare-const site_has_french_speaking_coordinator_available Bool)
(declare-const patient_has_finding_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory Bool)
(declare-const patient_has_finding_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory@@confirmed_by_biopsy Bool)
(declare-const patient_has_finding_of_carcinoma_in_situ_of_uterine_cervix_inthehistory Bool)
(declare-const patient_has_finding_of_carcinoma_in_situ_of_uterine_cervix_inthehistory@@confirmed_by_biopsy Bool)
(declare-const patient_has_finding_of_adenocarcinoma_in_situ_inthehistory Bool)
(declare-const patient_has_finding_of_adenocarcinoma_in_situ_inthehistory@@confirmed_by_biopsy Bool)

;; Existing auxiliary assertions
(assert (! (=> patient_has_finding_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory@@confirmed_by_biopsy patient_has_finding_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory) :named REQ2_AUXILIARY0))
(assert (! (=> patient_has_finding_of_carcinoma_in_situ_of_uterine_cervix_inthehistory@@confirmed_by_biopsy patient_has_finding_of_carcinoma_in_situ_of_uterine_cervix_inthehistory) :named REQ2_AUXILIARY1))
(assert (! (=> patient_has_finding_of_adenocarcinoma_in_situ_inthehistory@@confirmed_by_biopsy patient_has_finding_of_adenocarcinoma_in_situ_inthehistory) :named REQ2_AUXILIARY2))

;; Other kept assertions
(assert (! patient_sex_is_female_now :named REQ0_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
(assert (! (or (and (not patient_is_located_in_british_columbia_now) (not patient_is_located_in_nova_scotia_now) (not patient_is_located_in_newfoundland_now) (>= patient_age_value_recorded_now_in_years 18)) (and (or patient_is_located_in_british_columbia_now patient_is_located_in_nova_scotia_now patient_is_located_in_newfoundland_now) (>= patient_age_value_recorded_now_in_years 19))) :named REQ0_COMPONENT1_OTHER_REQUIREMENTS))
(assert (! (or patient_understands_english (and patient_understands_french site_has_french_speaking_coordinator_available)) :named REQ1_COMPONENT0_OTHER_REQUIREMENTS))
(assert (! (or patient_has_finding_of_cervical_intraepithelial_neoplasia_grade_2_inthehistory@@confirmed_by_biopsy patient_has_finding_of_carcinoma_in_situ_of_uterine_cervix_inthehistory@@confirmed_by_biopsy patient_has_finding_of_adenocarcinoma_in_situ_inthehistory@@confirmed_by_biopsy) :named REQ2_COMPONENT0_PRESCREEN_NOTES_MUST_COMPLETELY_SUFFICE))
