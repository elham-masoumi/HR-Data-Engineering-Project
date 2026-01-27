USE HR_Project;
GO

CREATE OR ALTER VIEW dw.vw_HR_Snapshot AS
SELECT
    d.FullDate AS SnapshotDate,
    e.EmployeeNumber,
    e.Gender,
    e.MaritalStatus,
    e.Age,
    dep.DepartmentName,
    job.JobRoleName,
    edu.EducationLevel,
    f.MonthlyIncome,
    f.YearsAtCompany,
    f.PerformanceRating,
    f.AttritionFlag
FROM dw.FactEmployeeSnapshot f
JOIN dw.DimDate d         ON d.DateKey = f.SnapshotDateKey
JOIN dw.DimEmployee e     ON e.EmployeeKey = f.EmployeeKey
JOIN dw.DimDepartment dep ON dep.DepartmentKey = f.DepartmentKey
JOIN dw.DimJobRole job    ON job.JobRoleKey = f.JobRoleKey
JOIN dw.DimEducation edu  ON edu.EducationKey = f.EducationKey;
GO

