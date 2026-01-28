# HR Data Warehouse ETL (SQL Server + SSIS + Power BI)

## Overview
End-to-end HR data engineering project demonstrating a layered architecture:
CSV source → SQL Server Staging → Data Warehouse (Star Schema) → Power BI reporting.

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


## How to Run the Project Locally

### Prerequisites
- SQL Server (LocalDB or full instance)
- SQL Server Management Studio (SSMS)
- Visual Studio with SQL Server Integration Services (SSIS)
- Power BI Desktop

### Step 1: Database and Schema Setup
Run the following script in SSMS to create the database and data warehouse schema:
- `SQL/00_setup.sql`

### Step 2: Create Staging Table
Create the staging table structure:
- `SQL/01_staging_table.sql`

### Step 3: Create Data Warehouse Tables
Create all dimension and fact tables:
- `SQL/02_dw_tables.sql`

### Step 4: Load Staging Data (SSIS)
Open the SSIS solution in Visual Studio and run:
- `01_Load_Staging.dtsx`

This package loads the raw HR CSV file into the staging table
`dbo.stg_hr_employee_raw`.

### Step 5: Load Dimensions and Fact (SSIS)
Run the second SSIS package:
- `02_Load_DW.dtsx`

This package:
- Loads dimension tables from staging
- Ensures the snapshot date exists in `dw.DimDate`
- Deletes existing fact rows for the snapshot date
- Loads `dw.FactEmployeeSnapshot` using Lookup transforms

### Step 6: Create Reporting View
Create the BI-friendly view used by Power BI:
- `SQL/06_view_vw_hr_snapshot.sql`

### Step 7: Validate the Load
Run basic validation and record count checks:
- `SQL/07_validation_checks.sql`

### Step 8: Power BI Reporting
Connect Power BI to SQL Server and use the view:
- `dw.vw_HR_Snapshot`

Build dashboards for headcount, attrition rate, and workforce analytics.


  

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

