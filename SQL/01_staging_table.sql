USE HR_Project;
GO

IF OBJECT_ID('dbo.stg_hr_employee_raw','U') IS NOT NULL
    DROP TABLE dbo.stg_hr_employee_raw;
GO

CREATE TABLE dbo.stg_hr_employee_raw (
    -- فقط ستون‌های کلیدی که در DW استفاده می‌کنی را نگه دار
    EmployeeNumber INT NULL,
    Age INT NULL,
    Gender NVARCHAR(20) NULL,
    MaritalStatus NVARCHAR(20) NULL,
    Department NVARCHAR(50) NULL,
    JobRole NVARCHAR(100) NULL,
    Education INT NULL,
    EducationField NVARCHAR(50) NULL,
    BusinessTravel NVARCHAR(50) NULL,
    Over18 NVARCHAR(10) NULL,
    OverTime NVARCHAR(5) NULL,
    MonthlyIncome INT NULL,
    YearsAtCompany INT NULL,
    PerformanceRating INT NULL,
    Attrition NVARCHAR(5) NULL
);
GO

