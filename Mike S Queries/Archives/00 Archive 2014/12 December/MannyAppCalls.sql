SELECT
Id
INTO
#Temp
FROM
Salesforce..Lead
WHERE
Date_Made__c between '2014-06-01' and '2014-10-31'

SELECT
Id,
SUM([Calls Made Before and Including Date Made]) [Calls Made Before and Including Date Made],
SUM([Calls Made After Date Made]) [Calls Made After Date Made],
SUM([Calls Made After Approved Before First Visit]) [Calls Made After Approved Before First Visit],
SUM([Calls Made After Date Made Before and Including Approved Date]) [Calls Made After Date Made Before and Including Approved Date],
SUM([Calls Made After First Visit]) [Calls Made After First Visit]
INTO
#Calls
FROM
(
SELECT
t.Id,
SUM(case when ch.act_date <= l.Date_Made__c then 1 else 0 end)[Calls Made Before and Including Date Made],
SUM(case when ch.act_date > l.Date_Made__c then 1 else 0 end)[Calls Made After Date Made],
SUM(case when ch.act_date > l.Approved_Date__c and ch.act_date <= X1st_Visit_Date__c then 1 else 0 end)[Calls Made After Approved Before First Visit],
SUM(case when ch.act_date > l.Date_Made__c and ch.act_date <= Approved_Date__c then 1 else 0 end)[Calls Made After Date Made Before and Including Approved Date],
SUM(case when ch.act_date > x1st_visit_Date__c then 1 else 0 end)[Calls Made After First Visit]
FROM
SalesforceReporting..call_history ch
inner join #Temp t ON ch.lm_filler2 = t.Id
inner join Salesforce..Lead l ON t.Id = l.Id
WHERE call_type in (0,2,4)
GROUP BY t.Id
UNION
SELECT
t.Id,
SUM(case when ch.act_date <= l.Date_Made__c then 1 else 0 end)[Calls Made Before and Including Date Made],
SUM(case when ch.act_date > l.Date_Made__c then 1 else 0 end)[Calls Made After Date Made],
SUM(case when ch.act_date > l.Approved_Date__c and ch.act_date <= X1st_Visit_Date__c then 1 else 0 end)[Calls Made After Approved Before First Visit],
SUM(case when ch.act_date > l.Date_Made__c and ch.act_date <= Approved_Date__c then 1 else 0 end)[Calls Made After Date Made Before and Including Approved Date],
SUM(case when ch.act_date > x1st_visit_Date__c then 1 else 0 end)[Calls Made After First Visit]
FROM
Enterprise..call_history ch
inner join #Temp t ON ch.lm_filler2 = t.Id
inner join Salesforce..Lead l ON t.Id = l.Id
WHERE call_type in (0,2,4)
GROUP BY t.Id
) detail
GROUP BY
Id

SELECT
l.Id,
SUM(case when CONVERT(date, ah.CreatedDate) <= l.Date_Made__c then 1 else 0 end)[Calls Made Before and Including Date Made],
SUM(case when CONVERT(date, ah.CreatedDate) > l.Date_Made__c then 1 else 0 end)[Calls Made After Date Made],
SUM(case when CONVERT(date, ah.CreatedDate) > l.Approved_Date__c and CONVERT(date, ah.CreatedDate) <= X1st_Visit_Date__c then 1 else 0 end)[Calls Made After Approved Before First Visit],
SUM(case when CONVERT(date, ah.CreatedDate) > l.Date_Made__c and CONVERT(date, ah.CreatedDate) <= Approved_Date__c then 1 else 0 end)[Calls Made After Date Made Before and Including Approved Date],
SUM(case when CONVERT(date, ah.CreatedDate) > x1st_visit_Date__c then 1 else 0 end)[Calls Made After First Visit]
INTO
#Diary
FROM
Salesforce..Task ah
inner join Salesforce..Lead l ON ah.WhatId = l.ConvertedOpportunityId
inner join #Temp t ON l.Id = t.Id
inner join Salesforce..[User] u ON ah.CreatedById = u.Id
WHERE
Subject = 'Call'
and
u.Name in ('Lisa Mooney','Caroline Wagstaffe','Tobias Gordon','Stefano Spinola','Joanne Eaton','Karnell Singh','Matthew Walker','Mansoor Kayani')
GROUP BY 
l.Id

SELECT 
l.Id,
bdc.Name BDC, 
bdm.Name BDM, 
Company, 
RIGHT(l.phone, LEN(REPLACE(l.Phone,' ',''))-1) Phone,
CONVERT(date, l.Date_Made__c) DateBooked,
DATEPART(month,l.Date_Made__c) MonthBooked, 
ISNULL(c.[Calls Made Before and Including Date Made],0)+ISNULL(d.[Calls Made Before and Including Date Made],0) [Calls Made Before and Including Date Made],
ISNULL(c.[Calls Made After Date Made],0)+ISNULL(d.[Calls Made After Date Made],0) [Calls Made After Date Made],
ISNULL(c.[Calls Made After Approved Before First Visit],0)+ISNULL(d.[Calls Made After Approved Before First Visit],0) [Calls Made After Approved Before First Visit],
ISNULL(c.[Calls Made After Date Made Before and Including Approved Date],0)+ISNULL(d.[Calls Made After Date Made Before and Including Approved Date],0) [Calls Made After Date Made Before and Including Approved Date],
ISNULL(c.[Calls Made After First Visit],0)+ISNULL(d.[Calls Made After First Visit],0) [Calls Made After First Visit],
CONVERT(date, l.Approved_Date__c) DateApproved,
CONVERT(date, l.X1st_Visit_Date__c) FirstVisitDate,
uMan.Name TeamManager

FROM
Salesforce..Lead l
inner join Salesforce..[User] bdc ON l.BDC__c = bdc.Id
inner join Salesforce..[User] bdm ON l.OwnerId = bdm.Id
inner join Salesforce..[User] uMan ON bdc.ManagerId = uMan.Id
left outer join #Calls c ON l.Id = c.Id
left outer join #Diary d ON l.Id = d.Id

WHERE
Date_Made__c between '2014-06-01' and '2014-10-31'
and
bdc.Department = 'Telemarketing'

DROP TABLE #Temp
DROP TABLE #Calls
DROP TABLE #Diary