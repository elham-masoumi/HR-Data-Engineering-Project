USE HR_Project;
GO

DECLARE @d DATE = CAST(GETDATE() AS DATE);
DECLARE @DateKey INT = (YEAR(@d) * 10000) + (MONTH(@d) * 100) + DAY(@d);

IF NOT EXISTS (SELECT 1 FROM dw.DimDate WHERE DateKey = @DateKey)
BEGIN
  INSERT INTO dw.DimDate (DateKey, FullDate, [Year], [Month], MonthName)
  VALUES (@DateKey, @d, YEAR(@d), MONTH(@d), DATENAME(MONTH, @d));
END
GO

