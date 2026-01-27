USE HR_Project;
GO

DECLARE @d DATE = CAST(GETDATE() AS DATE);
DECLARE @DateKey INT = (YEAR(@d) * 10000) + (MONTH(@d) * 100) + DAY(@d);

-- Replace today's snapshot (prevents PK duplicates)
DELETE FROM dw.FactEmployeeSnapshot
WHERE SnapshotDateKey = @DateKey;

INSERT INTO dw.FactEmployeeSnapshot (
  SnapshotDateKey, EmployeeKey, DepartmentKey, JobRoleKey, EducationKey,
  MonthlyIncome, YearsAtCompany, PerformanceRating, AttritionFlag
)
SELECT
  @DateKey,
  de.EmployeeKey,
  dd.DepartmentKey,
  dj.JobRoleKey,
  edu.EducationKey,
  s.MonthlyIncome,
  s.YearsAtCompany,
  s.PerformanceRating,
  CASE WHEN UPPER(LTRIM(RTRIM(s.Attrition))) = 'YES' THEN 1 ELSE 0 END
FROM dbo.stg_hr_employee_raw s
JOIN dw.DimEmployee de   ON de.EmployeeNumber = s.EmployeeNumber
JOIN dw.DimDepartment dd ON dd.DepartmentName = s.Department
JOIN dw.DimJobRole dj    ON dj.JobRoleName = s.JobRole
JOIN dw.DimEducation edu ON edu.EducationLevel = s.Education;
GO

