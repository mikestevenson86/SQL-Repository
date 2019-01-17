SELECT 
DATENAME(Month,DATEADD(mm,Number,GETDATE())) mName,
DATEPART(Month,DATEADD(mm,Number,GETDATE())) mNumber,
DATEPART(Year,DATEADD(mm,Number,GETDATE())) yNumber
INTO #Months
FROM Master.dbo.spt_Values
WHERE Name IS NULL AND Number BETWEEN 1 AND 10
ORDER BY Number