SELECT Date_Made__c, u.Name, COUNT(l.Id) Appts
INTO #Appts
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c = u.Id
WHERE Date_Made__c > '2014-12-26'
GROUP BY Date_Made__c, u.Name

SELECT act_date CallDate, u.Name Agent, COUNT(seqno) Dials, SUM(case when call_type in (0,2,4) then 1 else 0 end) Connects,
ISNULL(a.Appts, 0) Appts
FROM SalesforceReporting..call_history ch
inner join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c
left outer join #Appts a ON ch.act_date = a.Date_Made__c and u.Name = a.Name
WHERE act_date > '2014-12-26'
GROUP BY act_date, u.Name, ISNULL(a.Appts, 0)
ORDER BY CallDate, Agent

DROP TABLE #Appts