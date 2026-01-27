USE HR_Project;
GO

-- Department
INSERT INTO dw.DimDepartment (DepartmentName)
SELECT DISTINCT s.Department
FROM dbo.stg_hr_employee_raw s
WHERE s.Department IS NOT NULL
AND NOT EXISTS (
  SELECT 1 FROM dw.DimDepartment d WHERE d.DepartmentName = s.Department
);

-- JobRole
INSERT INTO dw.DimJobRole (JobRoleName)
SELECT DISTINCT s.JobRole
FROM dbo.stg_hr_employee_raw s
WHERE s.JobRole IS NOT NULL
AND NOT EXISTS (
  SELECT 1 FROM dw.DimJobRole j WHERE j.JobRoleName = s.JobRole
);

-- Education
INSERT INTO dw.DimEducation (EducationLevel)
SELECT DISTINCT s.Education
FROM dbo.stg_hr_employee_raw s
WHERE s.Education IS NOT NULL
AND NOT EXISTS (
  SELECT 1 FROM dw.DimEducation e WHERE e.EducationLevel = s.Education
);

-- Employee
INSERT INTO dw.DimEmployee (EmployeeNumber, Gender, MaritalStatus, Age)
SELECT DISTINCT
  s.EmployeeNumber, s.Gender, s.MaritalStatus, s.Age
FROM dbo.stg_hr_employee_raw s
WHERE s.EmployeeNumber IS NOT NULL
AND NOT EXISTS (
  SELECT 1 FROM dw.DimEmployee de WHERE de.EmployeeNumber = s.EmployeeNumber
);
GO

