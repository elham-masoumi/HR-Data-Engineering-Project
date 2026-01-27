# HR-Data-Engineering-Project
This project demonstrates an end-to-end HR data pipeline using SQL Server and Power BI.

## Data Loading (Staging)
- Source: IBM HR Analytics Employee Attrition dataset (CSV)
- Loaded into SQL Server as a staging table: `dbo.stg_hr_employee_raw`
- Purpose: preserve the raw structure and prepare the data for validation and transformation before loading to the data warehouse.

## Data Quality Checks
Basic validation checks are performed on the staging table (row counts, null checks, duplicates, and value ranges) before building the warehouse schema.
