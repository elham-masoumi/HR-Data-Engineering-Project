# HR Data Warehouse ETL (SQL Server + SSIS + Power BI)

## Overview
End-to-end HR data engineering project demonstrating a layered architecture:
CSV source → SQL Server Staging → Data Warehouse (Star Schema) → Power BI reporting.
Source: IBM HR Analytics Employee Attrition dataset (CSV)

## Dataset
IBM HR Analytics Employee Attrition dataset (CSV).

## Tech Stack
- SQL Server (SSMS)
- SSIS (Visual Studio)
- Power BI
- GitHub

## Architecture
- **Staging:** `dbo.stg_hr_employee_raw` (raw CSV load)
- **Warehouse (dw schema):**
  - Dimensions: `dw.DimEmployee`, `dw.DimDepartment`, `dw.DimJobRole`, `dw.DimEducation`, `dw.DimDate`
  - Fact: `dw.FactEmployeeSnapshot` (PK: SnapshotDateKey + EmployeeKey)
- **BI View:** `dw.vw_HR_Snapshot`

## ETL (SSIS)
### Package 01: `01_Load_Staging.dtsx`
- Loads the CSV file into SQL Server staging
- Handles data type conversions and ensures consistent staging loads

### Package 02: `02_Load_DW.dtsx`
- Loads dimensions from staging
- Ensures daily snapshot date in `dw.DimDate`
- Deletes existing snapshot rows for the load date and reloads the fact table
- Loads `dw.FactEmployeeSnapshot` using Lookup transforms (surrogate keys)

## Data Quality & Validation
- Record counts validated between staging and fact table (1470 rows)
- Basic checks for duplicates and nulls in key fields

## Power BI
Power BI connects to `dw.vw_HR_Snapshot` to build dashboards for:
- Headcount
- Attrition rate
- Attrition by department and job role
- Income and tenure analysis

## Screenshots
See `/Screenshots` for ETL flow and dashboard examples.

## Screenshots

### SSIS – Load Staging
![SSIS Package 01 Control Flow](Screenshots/ssis_package01_control_flow.png)

![SSIS Package 01 Data Flow](Screenshots/ssis_package01_data_flow.png)

### SSIS – Load Data Warehouse
![SSIS Package 02 Control Flow](Screenshots/ssis_package02_control_flow.png)

![SSIS Package 02 Data Flow](Screenshots/ssis_package02_data_flow.png)

### Power BI Dashboard
![Power BI Dashboard](Screenshots/powerbi_dashboard.png)

