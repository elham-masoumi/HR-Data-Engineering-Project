USE HR_Project;
GO

SELECT COUNT(*) AS stg_rows FROM dbo.stg_hr_employee_raw;

SELECT COUNT(*) AS dimEmployee FROM dw.DimEmployee;
SELECT COUNT(*) AS dimDepartment FROM dw.DimDepartment;
SELECT COUNT(*) AS dimJobRole FROM dw.DimJobRole;
SELECT COUNT(*) AS dimEducation FROM dw.DimEducation;

DECLARE @DateKey INT = (YEAR(GETDATE())*10000 + MONTH(GETDATE())*100 + DAY(GETDATE()));
SELECT COUNT(*) AS fact_rows_today
FROM dw.FactEmployeeSnapshot
WHERE SnapshotDateKey = @DateKey;

SELECT TOP 10 * FROM dw.vw_HR_Snapshot;
GO

