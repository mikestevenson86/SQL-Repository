SELECT DATEPART(month, Date_Made__c) MonthMade, SIC2007_Code__c, COUNT(Id) Apps
INTO #Apps
FROM Salesforce..Lead
WHERE Date_Made__c > '2015-01-01' and Date_Made__c < '2015-07-01' and Affinity_Cold__c = 'Cold'
GROUP BY DATEPART(month, Date_Made__c), SIC2007_Code__c

SELECT DATEPART(month, act_date) MonthCalled, s.[Description], COUNT(seqno) Calls, ap.Apps
INTO #CPA
FROM SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
left outer join #Apps ap ON l.SIC2007_Code__c = ap.SIC2007_Code__c and DATEPART(month, act_date) = ap.MonthMade
left outer join SalesforceReporting..SIC1 s ON l.SIC2007_Code__c = s.[SIC Code 1]
WHERE act_date > '2015-01-01' and act_date < '2015-07-01' and call_type in (0,2,4) and l.Affinity_Cold__c = 'Cold'
GROUP BY DATEPART(month, act_date), s.[Description], ap.Apps
ORDER BY DATEPART(month, act_date), s.[Description]

SELECT MonthCalled, [Description], case when Apps is null then 0 else Calls/Apps end CallsToAppts
FROM #CPA

SELECT DATEPART(month, Date_Made__c) MonthMade, af.Sector, COUNT(Id) Apps
INTO #Apps2
FROM Salesforce..Lead l
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE Date_Made__c > '2015-01-01' and Date_Made__c < '2015-07-01'
GROUP BY DATEPART(month, Date_Made__c), af.Sector

SELECT DATEPART(month, act_date) MonthCalled, af.Sector, COUNT(seqno) Calls, ap.Apps
INTO #CPA2
FROM SalesforceReporting..call_history ch
left outer join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
left outer join #Apps2 ap ON af.Sector = ap.Sector and DATEPART(month, act_date) = ap.MonthMade
WHERE act_date > '2015-01-01' and act_date < '2015-07-01' and call_type in (0,2,4)
GROUP BY DATEPART(month, act_date), af.Sector, ap.Apps
ORDER BY DATEPART(month, act_date), af.Sector

SELECT MonthCalled, Sector, case when Apps is null then 0 else Calls/Apps end CallsToAppts
FROM #CPA2

DROP TABLE #Apps
DROP TABLE #CPA
DROP TABLE #Apps2
DROP TABLE #CPA2