DECLARE @StartDate as Date
DECLARE @MonthName as VarChar(50)

SET @StartDate = '2017-01-01'

WHILE @StartDate < '2018-03-01'
BEGIN

IF OBJECT_ID('tempdb..#Calls') IS NOT NULL
	BEGIN
		DROP TABLE #Calls
	END

IF OBJECT_ID('tempdb..#Updates') IS NOT NULL
	BEGIN
		DROP TABLE #Updates
	END

SET @MonthName = DATENAME(Month, @StartDate) + ' ' + CONVERT(VarChar, YEAR(@StartDate))

SELECT l.Id, 
SUM(case when t.CallType = 'Inbound' then 1 else 0 end) Inbound, 
SUM(case when t.CallType = 'Outbound' then 1 else 0 end) Outbound
INTO #Calls
FROM Salesforce..Lead l
inner join Salesforce..Task t ON l.Id = t.WhoId
WHERE 
l.Data_Supplier__c = 'ML_API'
and
CallObject is not null
and 
DATENAME(Month, t.ActivityDate) + ' ' + CONVERT(VarChar, YEAR(t.ActivityDate)) = @MonthName
GROUP BY l.Id

SELECT l.Id UpdatedLeads
INTO #Updates
FROM Salesforce..Lead l
inner join Salesforce..LeadHistory lh ON l.Id = lh.LeadId
WHERE 
DATENAME(Month, @StartDate) + ' ' + CONVERT(VarChar, YEAR(@StartDate)) = @MonthName
and
l.Data_Supplier__c = 'ML_API'
GROUP BY l.Data_Supplier__c

INSERT INTO SalesforceReporting..SupplierMonth
(MonthYear,DataSupplier,TotalLeads,DiallableLeads,Inserts,Updates,Inbound,Outbound,InboundAppsBooked,OutboundAppsBooked,SAT,Deals)
SELECT 
@MonthName,
l.Data_Supplier__c,

COUNT(l.Id) TotalLeads,
SUM(case when dl.Id is not null then 1 else 0 end) DiallableLeads,
SUM(case when DATENAME(Month, l.CreatedDate) + ' ' + CONVERT(VarChar, YEAR(l.CreatedDate)) = @MonthName then 1 else 0 end) Inserts,
MAX(up.UpdatedLeads) Updates,
SUM(c.Inbound) Inbound,
SUM(c.Outbound) Outbound,
SUM(case when DATENAME(Month, l.Date_Made__c) + ' ' + CONVERT(VarChar, YEAR(l.Date_Made__c)) = @MonthName and l.MADE_Criteria__c like '%Inbound%' then 1 else 0 end) InboundAppsBooked,
SUM(case when DATENAME(Month, l.Date_Made__c) + ' ' + CONVERT(VarChar, YEAR(l.Date_Made__c)) = @MonthName and l.MADE_Criteria__c like '%Outbound%' then 1 else 0 end) OutboundAppsBooked,
SUM(case when DATENAME(Month, o.SAT_Date__c) + ' ' + CONVERT(VarChar, YEAR(o.SAT_Date__c)) = @MonthName then 1 else 0 end) SAT,
SUM(case when DATENAME(Month, o.Deal_Start_Date__c) + ' ' + CONVERT(VarChar, YEAR(o.Deal_Start_Date__c)) = @MonthName then 1 else 0 end) Deals
FROM Salesforce..Lead l
left outer join #Calls c ON l.Id = c.Id
left outer join #Updates up ON l.Id = up.UpdatedLeads
left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
left outer join SalesforceReporting..DiallableLeads dl ON l.Id = dl.Id
GROUP BY l.Data_Supplier__c
ORDER BY l.Data_Supplier__c

SET @StartDate = DATEADD(month,1,@StartDate)

END