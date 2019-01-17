DECLARE @Date1 DATE, @Date2 DATE

SET @Date1 = '2013-01-01'
SET @Date2 = (
			SELECT MAX(dtTo) 
			FROM [DATABASE].CitationMain.dbo.cit_tfl_absence ab 
			inner join [DATABASE].CitationMain.dbo.cit_tfl_Employee em 
			ON ab.empUID = em.empUID 
			WHERE em.compID = 5537
			)

SELECT DATEADD(DAY,number+1,@Date1) [Date]
INTO #Temp
FROM master..spt_values
WHERE type = 'P'
AND DATEADD(DAY,number+1,@Date1) < @Date2
ORDER BY [Date]

SELECT
t.Date, em.fName, sName, ab.reason
FROM
[DATABASE].CitationMain.dbo.cit_tfl_absence ab
left outer join #Temp t ON t.Date between ab.dtFrom and ab.dtTo
inner join [DATABASE].CitationMain.dbo.cit_tfl_Employee em ON ab.empUID = em.empUID
WHERE em.compID = 5537 and t.Date is not null

ORDER BY t.Date, em.sName

DROP TABLE #Temp