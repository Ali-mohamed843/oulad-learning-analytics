# OULAD (modified) - Data Quality Issues to Fix in SSIS

Source: Kuzilek, J., Hlosta, M., & Zdrahal, Z. (2017). Open University Learning Analytics dataset. Scientific Data, 4:170171. CC BY 4.0.
Modification: data quality issues were deliberately injected for this course project. studentVle was randomly sampled to 500,000 rows (before issues were added). Mention this in the report.

## All files
- Duplicate rows (studentInfo, studentRegistration, studentAssessment, assessments, courses, vle, studentVle)
- Lowercase codes (code_module, code_presentation) that break joins -> UPPER/TRIM
- "?" and "N/A" and blanks used as missing values -> convert to NULL

## studentInfo
- gender: M / Male / male / " F " / blank -> M or F
- region, highest_education: mixed case, trailing spaces, typos ("Est Anglian")
- imd_band: "%" missing in some rows, "N/A"
- age_band: "0 - 35", "35 to 55", "55+" -> 0-35, 35-55, 55<=
- num_of_prev_attempts: words ("one", "two"), "-1", "N/A", blank -> integer
- studied_credits: "60 credits", 0, negative, 99999, blank
- disability: Y / Yes / 1 / TRUE / N / No / 0 / FALSE -> Y or N
- final_result: mixed case, spaces, blank

## studentRegistration
- date_registration: "N/A", "unknown", "-159 days", blank
- date_unregistration: "N/A" instead of "?", trailing spaces

## studentAssessment
- score: "85%", "N/A", "absent", "-", >100, negative
- date_submitted: "?", "N/A", blank
- is_banked: 0/1 mixed with N/Y

## assessments
- assessment_type: tma / Exam / "TMA " -> TMA, CMA, Exam
- weight: "10%"; date: "N/A", "19 days"

## courses / vle
- module_presentation_length: "268 days"
- vle activity_type: mixed case, spaces; week_from "N/A"

## studentVle
- sum_click: negative, blank, "N/A", "many", 99999 (outlier)
- date: blank, "N/A", "day -10"
