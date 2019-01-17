SELECT *
INTO #Calls
FROM
(
SELECT l.Id, SUM(case when call_type in (0,2,4) then 1 else 0 end) Connects
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS and l.Date_Made__c between '2013-01-01' and GETDATE()
GROUP BY l.Id
UNION
SELECT l.Id, SUM(case when call_type in (0,2,4) then 1 else 0 end) Connects
FROM Enterprise..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS and l.Date_Made__c between '2013-01-01' and GETDATE()
GROUP BY l.Id
) detail

SELECT case when LeadSource = 'Cross Sell - QMS' then 'QMS'
when LeadSource <> 'Cross Sell - QMS' and MADE_Criteria__c like '%inbound%' then 'Inbound'
when LeadSource <> 'Cross Sell - QMS' and MADE_Criteria__c like '%outbound%' then 'Outbound'
when LeadSource <> 'Cross Sell - QMS' and MADE_Criteria__c like '%seminar%' then 'Seminars' end Category,
l.Date_Made__c DateMade,
l.Id,
Connects
INTO #Temp
FROM Salesforce..Lead l
left outer join #Calls c ON l.Id = c.Id
WHERE Date_Made__c between '2013-01-01' and GETDATE()
ORDER BY Category

SELECT
DATEPART(Year, DateMade),
DATEPART(Month, DateMade),
CONVERT(VarChar, DATENAME(month, DateMade)) + ' ' + CONVERT(VarChar,DATEPART(Year, DateMade)) MonthMade,
Category,
COUNT(Id),
AVG(Connects)
FROM
#Temp
GROUP BY
DATEPART(Year, DateMade),
DATEPART(Month, DateMade),
CONVERT(VarChar, DATENAME(month, DateMade)) + ' ' + CONVERT(VarChar, DATEPART(Year, DateMade)),
Category
ORDER BY
DATEPART(Year, DateMade),
DATEPART(Month, DateMade),
Category

DROP TABLE #Calls
DROP TABLE #Temp