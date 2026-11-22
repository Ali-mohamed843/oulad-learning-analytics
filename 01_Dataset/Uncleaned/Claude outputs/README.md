# OULAD Learning Analytics

End-to-end BI project on the **Open University Learning Analytics Dataset (OULAD)**:
SSIS data cleaning → SQL Server star schema → Power BI dashboard → ML withdrawal prediction.

## Pipeline

1. **SSIS** - cleans the raw CSV files (duplicates, casing, missing values, bad numbers) and loads them into the `stg` schema.
2. **SQL Server** - builds a star schema (`dbo`) in database **Education**: 4 dimensions + 3 facts.
3. **Power BI** - DAX measures and a 3-page dashboard (Overview, Who Withdraws, Engagement).
4. **Machine Learning** - predicts which students will withdraw (Logistic Regression, Decision Tree).

## Repository structure

| Folder | Contents |
|---|---|
| `01_Dataset/Uncleaned` | Raw CSV files + data quality checklist |
| `02_SSIS` | `EDU_Staging.dtsx` - cleaning and staging package |
| `03_SQL_Server` | Database, staging and star schema scripts |
| `04_PowerBI` | `OULAD_Dashboard.pbix` |
| `05_Machine_Learning` | Withdrawal prediction notebook |
| `06_Documentation` | Team tasks and the final report |

## Getting started

1. Install **SQL Server 2022 Developer** + **SSMS**.
2. Run `03_SQL_Server/01_Create_Database_and_Staging_Tables.sql` (change the file paths to a folder on your PC).
3. Open `02_SSIS/EDU_Staging.dtsx` in Visual Studio (SSIS extension), set the variables `DataFolder` (your `01_Dataset\Uncleaned` path) and `ServerName` (e.g. `localhost`), then run it.

Full setup for each task is in `06_Documentation/Team_Tasks.pdf`.

> The database backup (`Education.bak`) is shared on Drive, not in Git.

## Dataset

Kuzilek, J., Hlosta, M., & Zdrahal, Z. (2017). *Open University Learning Analytics dataset.* Scientific Data, 4:170171. CC BY 4.0.
Modified for this course project: data quality issues were injected and `studentVle` was sampled to 500,000 rows.
