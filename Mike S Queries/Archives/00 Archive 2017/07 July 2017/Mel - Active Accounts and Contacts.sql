SELECT Account__c, COUNT(Id) Sites
INTO #Sites
FROM Salesforce..Site__c
GROUP BY Account__c

SELECT s__c, COUNT(a.Id) WithSites
FROM Salesforce..Account a
left outer join #Sites s ON a.Id = s.Account__c
--left outer join Salesforce..Contact c ON a.Id = c.AccountId and c.Active__c = 'true'
WHERE Citation_Client__c = 'true' and s.Account__c is not null
GROUP BY s__c
ORDER BY case when S__c is null then 1
when S__c = 'Bronze' then 2
when S__c = 'Silver' then 3
when S__c = 'Gold' then 4
when S__c = 'Gold+' then 5
when S__c = 'Platinum' then 6 end

SELECT s__c, COUNT(a.Id) WithoutSites
FROM Salesforce..Account a
left outer join Salesforce..Site__c s ON a.Id = s.Account__c
--left outer join Salesforce..Contact c ON a.Id = c.AccountId and c.Active__c = 'true'
WHERE s.Id is null and Citation_Client__c = 'true'
GROUP BY s__c
ORDER BY case when S__c is null then 1
when S__c = 'Bronze' then 2
when S__c = 'Silver' then 3
when S__c = 'Gold' then 4
when S__c = 'Gold+' then 5
when S__c = 'Platinum' then 6 end

SELECT s__c, COUNT(a.Id) OneSite
FROM Salesforce..Account a
left outer join #Sites s ON a.Id = s.Account__c
--left outer join Salesforce..Contact c ON a.Id = c.AccountId and c.Active__c = 'true'
WHERE Citation_Client__c = 'true' and s.Sites = 1
GROUP BY s__c
ORDER BY case when S__c is null then 1
when S__c = 'Bronze' then 2
when S__c = 'Silver' then 3
when S__c = 'Gold' then 4
when S__c = 'Gold+' then 5
when S__c = 'Platinum' then 6 end

SELECT s__c, COUNT(a.Id) TwoOrMore
FROM Salesforce..Account a
left outer join #Sites s ON a.Id = s.Account__c
--left outer join Salesforce..Contact c ON a.Id = c.AccountId and c.Active__c = 'true'
WHERE Citation_Client__c = 'true' and s.Sites >= 2
GROUP BY s__c
ORDER BY case when S__c is null then 1
when S__c = 'Bronze' then 2
when S__c = 'Silver' then 3
when S__c = 'Gold' then 4
when S__c = 'Gold+' then 5
when S__c = 'Platinum' then 6 end

SELECT s__c, COUNT(a.Id) ActiveComplaint
FROM Salesforce..Account a
--left outer join Salesforce..Contact c ON a.Id = c.AccountId and c.Active__c = 'true'
WHERE Citation_Client__c = 'true' and ActiveComplaint__c is not null
GROUP BY s__c
ORDER BY case when S__c is null then 1
when S__c = 'Bronze' then 2
when S__c = 'Silver' then 3
when S__c = 'Gold' then 4
when S__c = 'Gold+' then 5
when S__c = 'Platinum' then 6 end

SELECT s__c, COUNT(a.Id) OnHold
FROM Salesforce..Account a
--left outer join Salesforce..Contact c ON a.Id = c.AccountId and c.Active__c = 'true'
WHERE Citation_Client__c = 'true' and OnHold__c is not null
GROUP BY s__c
ORDER BY case when S__c is null then 1
when S__c = 'Bronze' then 2
when S__c = 'Silver' then 3
when S__c = 'Gold' then 4
when S__c = 'Gold+' then 5
when S__c = 'Platinum' then 6 end

SELECT s__c, COUNT(a.Id) CitationOnly
FROM Salesforce..Account a
--left outer join Salesforce..Contact c ON a.Id = c.AccountId and c.Active__c = 'true'
WHERE Citation_Client__c = 'true' and QMSClientCheck__c = 'false'
GROUP BY s__c
ORDER BY case when S__c is null then 1
when S__c = 'Bronze' then 2
when S__c = 'Silver' then 3
when S__c = 'Gold' then 4
when S__c = 'Gold+' then 5
when S__c = 'Platinum' then 6 end

SELECT s__c, COUNT(a.Id) CitationAndQMS
FROM Salesforce..Account a
--left outer join Salesforce..Contact c ON a.Id = c.AccountId and c.Active__c = 'true'
WHERE Citation_Client__c = 'true' and QMSClientCheck__c = 'true'
GROUP BY s__c
ORDER BY case when S__c is null then 1
when S__c = 'Bronze' then 2
when S__c = 'Silver' then 3
when S__c = 'Gold' then 4
when S__c = 'Gold+' then 5
when S__c = 'Platinum' then 6 end

SELECT c.AccountId
INTO #NonRenew
FROM Salesforce..Contract c
inner join Salesforce..Opportunity o ON c.Source_Opportunity__c = o.Id
WHERE o.RecordTypeId in ('012D0000000NbinIAC','012D0000000NaVdIAK') and Early_Renewal__c <> 'true' and Overall_Target_Opportunity__c <> 'No'
and c.EndDate between CONVERT(date, GETDATE()) and CONVERT(date, DATEADD(month,9,GETDATE()))
GROUP BY c.AccountId

SELECT s__c, COUNT(a.Id) NonRenews
FROM Salesforce..Account a
left outer join #NonRenew nr ON a.Id = nr.AccountId
--left outer join Salesforce..Contact c ON a.Id = c.AccountId and c.Active__c = 'true'
WHERE Citation_Client__c = 'true' and nr.AccountId is null
GROUP BY s__c
ORDER BY case when S__c is null then 1
when S__c = 'Bronze' then 2
when S__c = 'Silver' then 3
when S__c = 'Gold' then 4
when S__c = 'Gold+' then 5
when S__c = 'Platinum' then 6 end

SELECT AccountId
INTO #Renew
FROM Salesforce..Contract
WHERE CONVERT(date, StartDate) <= CONVERT(date, GETDATE()) and CONVERT(date, EndDate) >= CONVERT(date, GETDATE())
and Cancellation_Date__c is null and Renewal_Type__c = 'Auto' and EndDate not between CONVERT(date, GETDATE()) and CONVERT(date, DATEADD(month,9,GETDATE()))
GROUP BY AccountId

SELECT AccountId
INTO #RenewOpps
FROM Salesforce..Opportunity
WHERE RecordTypeId in ('012D0000000NaVdIAK','012D0000000NbinIAC')

SELECT s__c, COUNT(a.Id) Renews
FROM Salesforce..Account a
left outer join #Renew r ON a.Id = r.AccountId
left outer join #RenewOpps o ON a.Id = o.AccountId
--left outer join Salesforce..Contact c ON a.Id = c.AccountId and c.Active__c = 'true'
WHERE Citation_Client__c = 'true' and r.AccountId is not null and o.AccountId is null
GROUP BY S__c
ORDER BY case when S__c is null then 1
when S__c = 'Bronze' then 2
when S__c = 'Silver' then 3
when S__c = 'Gold' then 4
when S__c = 'Gold+' then 5
when S__c = 'Platinum' then 6 end

DROP TABLE #Renew
DROP TABLE #RenewOpps
DROP TABLE #NonRenew
DROP TABLE #Sites