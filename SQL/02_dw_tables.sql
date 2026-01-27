USE HR_Project;
GO

-- Dimensions
IF OBJECT_ID('dw.DimDepartment','U') IS NOT NULL DROP TABLE dw.DimDepartment;
IF OBJECT_ID('dw.DimJobRole','U') IS NOT NULL DROP TABLE dw.DimJobRole;
IF OBJECT_ID('dw.DimEducation','U') IS NOT NULL DROP TABLE dw.DimEducation;
IF OBJECT_ID('dw.DimEmployee','U') IS NOT NULL DROP TABLE dw.DimEmployee;
IF OBJECT_ID('dw.DimDate','U') IS NOT NULL DROP TABLE dw.DimDate;
IF OBJECT_ID('dw.FactEmployeeSnapshot','U') IS NOT NULL DROP TABLE dw.FactEmployeeSnapshot;
GO

CREATE TABLE dw.DimDepartment (
    DepartmentKey INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE dw.DimJobRole (
    JobRoleKey INT IDENTITY(1,1) PRIMARY KEY,
    JobRoleName NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE dw.DimEducation (
    EducationKey INT IDENTITY(1,1) PRIMARY KEY,
    EducationLevel INT NOT NULL UNIQUE
);

CREATE TABLE dw.DimEmployee (
    EmployeeKey INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeNumber INT NOT NULL UNIQUE,
    Gender NVARCHAR(20) NULL,
    MaritalStatus NVARCHAR(20) NULL,
    Age INT NULL
);

CREATE TABLE dw.DimDate (
    DateKey INT NOT NULL PRIMARY KEY,      -- yyyymmdd
    FullDate DATE NOT NULL UNIQUE,
    [Year] INT NOT NULL,
    [Month] INT NOT NULL,
    MonthName NVARCHAR(20) NOT NULL
);

CREATE TABLE dw.FactEmployeeSnapshot (
    SnapshotDateKey INT NOT NULL,
    EmployeeKey INT NOT NULL,
    DepartmentKey INT NOT NULL,
    JobRoleKey INT NOT NULL,
    EducationKey INT NOT NULL,
    MonthlyIncome INT NULL,
    YearsAtCompany INT NULL,
    PerformanceRating INT NULL,
    AttritionFlag BIT NOT NULL,

    CONSTRAINT PK_FactEmployeeSnapshot PRIMARY KEY (SnapshotDateKey, EmployeeKey),
    CONSTRAINT FK_Fact_Date FOREIGN KEY (SnapshotDateKey) REFERENCES dw.DimDate(DateKey),
    CONSTRAINT FK_Fact_Emp FOREIGN KEY (EmployeeKey) REFERENCES dw.DimEmployee(EmployeeKey),
    CONSTRAINT FK_Fact_Dep FOREIGN KEY (DepartmentKey) REFERENCES dw.DimDepartment(DepartmentKey),
    CONSTRAINT FK_Fact_Job FOREIGN KEY (JobRoleKey) REFERENCES dw.DimJobRole(JobRoleKey),
    CONSTRAINT FK_Fact_Edu FOREIGN KEY (EducationKey) REFERENCES dw.DimEducation(EducationKey)
);
GO

