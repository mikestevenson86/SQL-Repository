DECLARE @Month int
DECLARE @Three int
DECLARE @Six int
DECLARE @Nine int
DECLARE @Twelve int

SET @Month=1
SET @Three=2
SET @Six=5
SET @Nine=8
SET @Twelve=11

CREATE TABLE SalesforceReporting..Temp ([Month Name] VarChar(10), Three Date, Six Date, Nine Date, Twelve Date, ThreeToSix int, SixToNine int, NineToTwelve int, TwelveOnly int) 

SELECT
l.Id,
MAX(CONVERT(date, lh.CreatedDate)) NIDate
INTO #NI
FROM
Salesforce..Lead l
inner join Salesforce..LeadHistory lh ON l.Id = lh.LeadId and Field = 'Suspended_Closed_Reason__c' and NewValue = 'Not Interested'
WHERE l.Status = 'Suspended' and l.Suspended_Closed_Reason__c = 'Not Interested'
GROUP BY l.Id

WHILE @Month<13
BEGIN
INSERT INTO
SalesforceReporting..Temp
SELECT
DATENAME(MONTH,DATEADD(mm,@Month,GETDATE())) [Month Name],
DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Three, 0) Three,
DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Six, 0) Six,
DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Nine, 0) Nine,
DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Twelve, 0) Twelve,
SUM(case when ni.NIDate between DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Six, 0) and DATEADD(dd,-1,DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Three, 0)) then 1 else 0 end) ThreeToSix,
SUM(case when ni.NIDate between DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Nine, 0) and DATEADD(dd,-1,DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Six, 0)) then 1 else 0 end) SixToNine,
SUM(case when ni.NIDate between DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Twelve, 0) and DATEADD(dd,-1,DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Nine, 0)) then 1 else 0 end) NineToTwelve,
SUM(case when ni.NIDate between DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Twelve, 0) and DATEADD(dd,-1,DATEADD(mm, DATEDIFF(mm,0,GETDATE())-@Twelve+1, 1)) then 1 else 0 end) TwelveOnly
FROM
#NI ni

SET @Month = @Month+1
SET @Three = @Three-1
SET @Six = @Six-1
SET @Nine = @Nine-1
SET @Twelve = @Twelve-1

END

SELECT *
FROM SalesforceReporting..Temp

DROP TABLE #NI
DROP TABLE SalesforceReporting..Temp