SELECT Id Lid
INTO #Temp
FROM
Salesforce..Lead
WHERE Id in
(
SELECT distinct(lm_filler2) lid
FROM SalesforceReporting..call_history
WHERE call_type in (0,2,4)
UNION
SELECT distinct(lm_filler2) lid
FROM Enterprise..call_history
WHERE call_type in (0,2,4)
)

SELECT 
COUNT(Id) Tier4Leads,
SUM(case when Lid is not null then 1 else 0 end) Called,
SUM(case when l.Date_Made__c is not null then 1 else 0 end) DateMade,
SUM(case when l.Date_Made__c is not null and l.Approved_Date__c is not null then 1 else 0 end) Approved
FROM Salesforce..Lead l
left outer join #Temp t ON l.Id = t.lid
WHERE (Suspended_Closed_Reason__c is null or Suspended_Closed_Reason__c <> 'Tier 4 SIC Code') 
and Status in ('open','callback requested','approved') 
and Affinity_Cold__c = 'Cold'
and	l.SIC2007_Code__c not in ('A','B','D','E','K','R')
and l.SIC2007_Code3__c not in ('1629','9100','20150','20160','20200','20301','20412','35110','43110','47300','49100','49200','49311','49319')
and l.SIC2007_Code3__c not in ('50100','50200','50300','50400','51211','64110','64191','69101','69102','69109','82200','86101','86210','86220','99999')
and	LEFT(l.PostalCode,4) not in ('EX31','EX33','EX34','EX35','EX39')
and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
and LEFT(l.PostalCode,4) not between 'NP1' and 'NP20'
and l.Area_Code__c not in ('KW','BT','SA','LD','TR','PL')	
and	l.FT_Employees__c between 6 and 225
and	(l.Phone <> '' or l.Phone is not null)
and Id in
(
SELECT LeadId
FROM Salesforce..LeadHistory
WHERE OldValue = 'Tier 4 SIC Code' and Field = 'Suspended_Closed_Reason__c'
)

SELECT 
COUNT(Id) ColdLeads,
SUM(case when Lid is not null then 1 else 0 end) Called,
SUM(case when l.Date_Made__c is not null then 1 else 0 end) DateMade,
SUM(case when l.Date_Made__c is not null and l.Approved_Date__c is not null then 1 else 0 end) Approved
FROM Salesforce..Lead l
left outer join #Temp t ON l.Id = t.lid
WHERE Affinity_Cold__c = 'Cold' and Status in ('open','callback requested','approved') 
and	l.SIC2007_Code__c not in ('A','B','D','E','K','R')
and l.SIC2007_Code3__c not in ('1629','9100','20150','20160','20200','20301','20412','35110','43110','47300','49100','49200','49311','49319')
and l.SIC2007_Code3__c not in ('50100','50200','50300','50400','51211','64110','64191','69101','69102','69109','82200','86101','86210','86220','99999')
and	LEFT(l.PostalCode,4) not in ('EX31','EX33','EX34','EX35','EX39')
and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
and LEFT(l.PostalCode,4) not between 'NP1' and 'NP20'
and l.Area_Code__c not in ('KW','BT','SA','LD','TR','PL')	
and	l.FT_Employees__c between 6 and 225
and	(l.Phone <> '' or l.Phone is not null)

DROP TABLE #Temp