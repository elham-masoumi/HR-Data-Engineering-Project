# HR-Data-Engineering-Project
This project demonstrates an end-to-end HR data pipeline using SQL Server and Power BI.

## Data Loading (Staging)
- Source: IBM HR Analytics Employee Attrition dataset (CSV)
- Loaded into SQL Server as a staging table: `dbo.stg_hr_employee_raw`
- Purpose: preserve the raw structure and prepare the data for validation and transformation before loading to the data warehouse.

## Data Quality Checks
Basic validation checks are performed on the staging table (row counts, null checks, duplicates, and value ranges) before building the warehouse schema.

## Data Warehouse (SQL Server)
A simple HR data warehouse was built using a star schema:

**Staging**
- `dbo.stg_hr_employee_raw` (raw CSV load)

**Dimensions (dw)**
- `dw.DimEmployee`
- `dw.DimDepartment`
- `dw.DimJobRole`
- `dw.DimEducation`
- `dw.DimDate` (snapshot date)

**Fact (dw)**
- `dw.FactEmployeeSnapshot` (employee snapshot metrics + attrition flag)

## ETL (SQL-based)
- Loaded raw CSV into staging
- Populated dimension tables using `SELECT DISTINCT`
- Loaded the snapshot fact table using surrogate keys from dimensions
- Performed basic validation checks (row counts, duplicates)

## BI Consumption
- Power BI connects to the warehouse tables and/or `dw.vw_HR_Snapshot` view for reporting.
